USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 03/06/2012 20:47:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Changes for InsertBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Pass proc name to body proc
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.19
-- Description:   Changes for UpdateBulk, DeleteBulk
-- =============================================  

ALTER PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
( 
	@ProcName NVarChar(200),
	@TableName nvarchar(128),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  

AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength smallint,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable bit

	DECLARE @PrimaryKeyColumnName NVarChar(128), @insColNames VarChar(MAX), @TableNamePascal nvarchar(128), @selColNames VarChar(MAX), @setColNames VarChar(MAX)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	--CREATE TABLE #SqlTable (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckPredicates nVarChar(MAX), @pkPredicates nVarChar(MAX)

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName)
	
	IF @ckColumnNames Is Not Null
	BEGIN		
		SELECT @ckPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@ckColumnNames)
	END		
	IF @PrimaryKeyColumnName Is Not Null
	BEGIN		
		SELECT @pkPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@PrimaryKeyColumnName)
	END	
	

	SET @Stmt = ''

	IF @ActionType In ('Select', 'SelectByColumns', 'SelectByPK')
	BEGIN
		SELECT @ColNames = COALESCE(@ColNames + ', ' + @nline, '') + 
			@cTAB + @cTAB + '[' + col.[COLUMN_NAME] + ']' 
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT ' + @nline + 
									 @ColNames + @nline + 
									 @cTAB + 'FROM ' + 'dbo.[' + @TableName + ']')

		IF @ActionType = 'SelectByColumns'
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @ckPredicates)
			END
		ELSE IF @ActionType = 'SelectByPK'
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)		
			END

	END
	ELSE IF @ActionType = 'Insert'
	BEGIN
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + col.[COLUMN_NAME] + ']' 
				ELSE '--'
			END
			,@ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '@' + col.[COLUMN_NAME]  
				ELSE '--'
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
	
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'VALUES' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '('+IsNull(@ColNames, '@ColNames is null') + @nline + @cTAB + ')')
		Insert Into #SqlTable VALUES(@nline)

		IF EXISTS(SELECT 'X' FROM INFORMATION_SCHEMA.COLUMNS col
			WHERE TABLE_NAME = @TableName AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1')
		BEGIN
			Insert Into #SqlTable VALUES(@cTAB + 'SET @'+ @PrimaryKeyColumnName + ' = scope_identity()')
		END

	END
	ELSE IF @ActionType = 'InsertBulk'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + col.[COLUMN_NAME] + ']' 
				ELSE '--'
			END
			,@selColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DATA_TYPE] WHEN 'uniqueidentifier' THEN [COLUMN_NAME] + '] ' + 'nvarchar(100)' ELSE [COLUMN_NAME] + '] ' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, [numeric_precision]) + ', ' + CONVERT(VarChar, [numeric_scale]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And [character_maximum_length] <> -1 THEN '(' + CONVERT(VarChar, [character_maximum_length]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar') And [character_maximum_length] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IS_NULLABLE]='YES' THEN ' ''' + col.[COLUMN_NAME] + '[not(@i:nil = "true")]''' ELSE '' END
				ELSE '--'
			END			
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
		
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will insert a default value and not actually null			
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END
	ELSE IF @ActionType = 'UpdateBulk'
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
	
		Insert Into #SqlTable VALUES(@cTAB + 'IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#' + @TableNamePascal + ']''))AND([type] = ''U'')) )' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'DROP TABLE [#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + col.[ColumnNamePascal] + ']' 					
				,@setColNames = 
				CASE 
					WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND col.[IsIdentity] = 1) THEN
						COALESCE(@setColNames + ', ' + @nline, '') + 
						@cTAB + @cTAB + '[bt].[' + col.[COLUMN_NAME] + '] = [tmp].[' + col.[ColumnNamePascal] + ']'
						ELSE '--' 
					END
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DATA_TYPE] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, [numeric_precision]) + ', ' + CONVERT(VarChar, [numeric_scale]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And [character_maximum_length] <> -1 THEN '(' + CONVERT(VarChar, [character_maximum_length]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar') And [character_maximum_length] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IS_NULLABLE]='YES' THEN ' ''' + col.[COLUMN_NAME] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [vwCGEN_Columns] col
		WHERE TABLE_NAME = @TableName		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'INTO ' + '[#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@setColNames, '@setColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'FROM [dbo].[' + @TableName + '] [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@TableName, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END	
	ELSE IF @ActionType = 'DeleteBulk'
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
	
		Insert Into #SqlTable VALUES(@cTAB + 'IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#' + @TableNamePascal + ']''))AND([type] = ''U'')) )' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'DROP TABLE [#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + col.[ColumnNamePascal] + ']' 					
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DATA_TYPE] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, [numeric_precision]) + ', ' + CONVERT(VarChar, [numeric_scale]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And [character_maximum_length] <> -1 THEN '(' + CONVERT(VarChar, [character_maximum_length]) + ')' 
						WHEN [DATA_TYPE] IN ('varchar', 'nvarchar') And [character_maximum_length] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IS_NULLABLE]='YES' THEN ' ''' + col.[COLUMN_NAME] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [vwCGEN_Columns] col
		WHERE TABLE_NAME = @TableName		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'INTO ' + '[#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'FROM [dbo].[' + @TableName + '] [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@TableName, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END		
	ELSE IF @ActionType = 'UpdateByPK'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + col.[COLUMN_NAME] + '] = @' + col.[COLUMN_NAME]
				ELSE '--'
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @ColNames + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)
	END
	ELSE IF @ActionType = 'UpdateByColumns'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') AND NOT(@ckColumnNames=col.[COLUMN_NAME]) THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + '[' + col.[COLUMN_NAME] + '] = @' + col.[COLUMN_NAME]
				ELSE COALESCE(@ColNames + @nline, '--')
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @ColNames + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @ckPredicates)
		
	END
	ELSE IF @ActionType = 'DeleteByPK'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE FROM ' + '[dbo].['+@TableName + ']' + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)
	END
	ELSE IF @ActionType = 'DeleteByColumns'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE FROM ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'WHERE ' + @ckPredicates)
	END
	
	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr	
	*/
END

