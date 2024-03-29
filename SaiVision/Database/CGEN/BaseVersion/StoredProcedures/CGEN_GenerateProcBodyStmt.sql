USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 08/18/2012 01:22:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcBodyStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 08/18/2012 01:22:03 ******/
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
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  

CREATE PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
( 
	@CGEN_MasterTableId Int,
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

	DECLARE @PrimaryKeyColumnName NVarChar(128), @insColNames VarChar(MAX), @insColNamesPascal VarChar(MAX), @TableNamePascal nvarchar(128), @selColNames VarChar(MAX), @setColNames VarChar(MAX)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	--CREATE TABLE #SqlTable (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckPredicates nVarChar(MAX), @pkPredicates nVarChar(MAX)

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId
	
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
			@cTAB + @cTAB + '[' + c.[ColumnName] + ']' 
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]		
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
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + ']' 
				ELSE @insColNames--COALESCE(@insColNames, '')-- + '--' 
			END
			,@ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '@' + c.[ColumnName]  
				ELSE @ColNames--COALESCE(@ColNames, '')-- + '--'
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'VALUES' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '('+IsNull(@ColNames, '@ColNames is null') + @nline + @cTAB + ')')
		Insert Into #SqlTable VALUES(@nline)

		IF EXISTS(SELECT 'X' FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
			 AND [c].[IsIdentity]='True')
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
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + ']' 
				ELSE @insColNames--COALESCE(@insColNames, Null)-- + '--' 
			END
		
			,@insColNamesPascal = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@insColNamesPascal + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnNamePascal] + ']' 
				ELSE @insColNamesPascal--COALESCE(@insColNamesPascal, '')-- + '--' 
			END
			,@selColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnNamePascal] + '[not(@i:nil = "true")]''' ELSE '' END
				ELSE @selColNames--COALESCE(@selColNames, '')-- + '--' 
			END			
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		ORDER BY [c].[ColumnOrder]
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will insert a default value and not actually null			
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNamesPascal, '@insColNamesPascal is null') + @nline + @cTAB)
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
					@cTAB + @cTAB + '[' + [c].[ColumnNamePascal] + ']' 					
				,@setColNames = 
				CASE 
					WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity] = 1) THEN
						COALESCE(@setColNames + ', ' + @nline, '') + 
						@cTAB + @cTAB + '[bt].[' + [c].[ColumnName] + '] = [tmp].[' + [c].[ColumnNamePascal] + ']'
						ELSE @setColNames--COALESCE(@setColNames, '') + '--' 
					END
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnNamePascal] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		ORDER BY [c].[ColumnOrder]
		
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
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@CGEN_MasterTableId, @PrimaryKeyColumnName) + @nline)
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
					@cTAB + @cTAB + '[' + [c].[ColumnNamePascal] + ']' 					
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnNamePascal] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		ORDER BY [c].[ColumnOrder]
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'INTO ' + '[#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'FROM [dbo].[' + @TableName + '] [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@CGEN_MasterTableId, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END		
	ELSE IF @ActionType = 'UpdateByPK'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + '] = @' + [c].[ColumnName]
				ELSE @ColNames--'--'
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @ColNames + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)
	END
	ELSE IF @ActionType = 'UpdateByColumns'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') AND NOT(@ckColumnNames=[c].[ColumnName]) THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + '[' + [c].[ColumnName] + '] = @' + [c].[ColumnName]
				ELSE @ColNames--'--'
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

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


GO

