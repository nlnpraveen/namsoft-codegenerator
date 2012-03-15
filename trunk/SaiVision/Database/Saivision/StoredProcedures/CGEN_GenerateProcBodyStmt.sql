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
  
ALTER PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
( 
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

	DECLARE @PrimaryKeyColumnName NVarChar(128), @insColNames VarChar(MAX)
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
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		SELECT @ColNames = 
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

