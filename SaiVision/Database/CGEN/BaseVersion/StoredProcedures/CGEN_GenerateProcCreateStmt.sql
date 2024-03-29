USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 08/18/2012 01:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcCreateStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 08/18/2012 01:21:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.19
-- Description:   Date datatype should not be assigned a default value
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.20
-- Description:   Default value for small datetime
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Select/Delete by composite PK
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Update by columns
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.10
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle UpdateBulk, DeleteBulk
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
( 
	@CGEN_MasterTableId Int,
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  
AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNameDataTypes VarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength int,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable varchar(10),
	@col_DefaultVal nvarchar(4000)
	DECLARE @TableColumns TABLE
	(	ColumnName nvarchar(128), 
		DataType nvarchar(128), 
		NumericPrecision tinyint, 
		NumericScale int, 
		CharacterMaximumLength int, 
		IsNullable varchar(3), 
		ColumnDefault nvarchar(4000), 
		IsIdentity Bit
	)	

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId

	Insert Into #SqlTable VALUES('CREATE PROCEDURE [dbo].['+ @ProcName +']' + @nline)
	
	SELECT @ckColumnNames = COALESCE(@ckColumnNames, @PrimaryKeyColumnName)
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, ',')
	END

	IF @ActionType = 'Insert'
	BEGIN
		INSERT INTO  @TableColumns (ColumnName, DataType, NumericPrecision, NumericScale, CharacterMaximumLength, IsNullable, ColumnDefault, IsIdentity)		
		SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		WHILE EXISTS(SELECT 'X' FROM @TableColumns)
		BEGIN
		
			SELECT TOP 1 @col_ColumnName=[ColumnName], @col_TypeName=[DataType], @col_Precision=[NumericPrecision], @col_Scale=[NumericScale], 
			@col_MaxLength=[CharacterMaximumLength], @col_IsNullable=[IsNullable], @col_DefaultVal=[ColumnDefault], @col_IsIdentity=[IsIdentity]
			FROM @TableColumns
		
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX('%[()]%',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX('%[()]%', @col_DefaultVal), 1, '')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + CASE @col_TypeName WHEN 'uniqueidentifier' THEN @col_ColumnName + ' ' + 'nvarchar(100)' ELSE @col_ColumnName + ' ' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName='decimal' THEN '(' + CONVERT(VarChar, @col_Precision) + ', ' + CONVERT(VarChar, @col_Scale) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar', 'char', 'nchar') And @col_MaxLength <> -1 THEN '(' + CONVERT(VarChar, @col_MaxLength) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar') And @col_MaxLength = -1 THEN '(MAX)' 
					ELSE '' 
				END +
				CASE 
					WHEN @col_IsNullable='YES' AND( @col_DefaultVal Is Null Or PATINDEX('%getdate%', @col_DefaultVal) > 0) THEN ' = Null' 
					WHEN 
						@col_DefaultVal Is Not Null 
						AND 
							((@col_TypeName IN ('date', 'datetime', 'smalldatetime') AND PATINDEX('%getdate%', @col_DefaultVal)=0)
							Or 
							(@col_TypeName Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier')))
						THEN ' = ' + @col_DefaultVal
					ELSE '' 
				END +
				CASE 
				WHEN (@PrimaryKeyColumnName = @col_ColumnName AND (@col_IsIdentity = 1 Or @col_TypeName = 'uniqueidentifier')) THEN ' OUTPUT'
					ELSE ''
				END
				
			DELETE FROM @TableColumns WHERE [ColumnName]=@col_ColumnName
		END

--		SELECT @ColNameDataTypes = 
--			CASE 
--				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
--					COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + col.[COLUMN_NAME] + ' ' + col.[DATA_TYPE] + 
--					CASE 
--						WHEN col.[DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, col.[numeric_precision]) + ', ' + CONVERT(VarChar, col.[numeric_scale]) + ')' 
--						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And col.character_maximum_length <> -1 THEN '(' + CONVERT(VarChar, col.character_maximum_length) + ')' 
--						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar') And col.character_maximum_length = -1 THEN '(MAX)' 
--						ELSE '' 
--					END +
--					CASE 
--						WHEN col.[IS_NULLABLE]='YES' AND col.[COLUMN_DEFAULT] Is Null THEN ' = Null' 
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN ('varchar', 'char', 'money') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN ('datetime', 'smalldatetime') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
--						ELSE '' 
--					END 
--				ELSE '--'
--			END
--		FROM INFORMATION_SCHEMA.COLUMNS col
--		WHERE TABLE_NAME = @TableName
		
		Insert Into #SqlTable VALUES(@ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType IN ('InsertBulk', 'UpdateBulk', 'DeleteBulk')
	BEGIN	
		SET @ColNameDataTypes = '@DataXml VarChar(MAX)'
		Insert Into #SqlTable VALUES(@cTAB + @ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType In ('UpdateByPK', 'UpdateByColumns') 
	BEGIN
		INSERT INTO  @TableColumns (ColumnName, DataType, NumericPrecision, NumericScale, CharacterMaximumLength, IsNullable, ColumnDefault, IsIdentity)		
		SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		WHILE EXISTS(SELECT 'X' FROM @TableColumns)
		BEGIN
		
			SELECT TOP 1 @col_ColumnName=[ColumnName], @col_TypeName=[DataType], @col_Precision=[NumericPrecision], @col_Scale=[NumericScale], 
			@col_MaxLength=[CharacterMaximumLength], @col_IsNullable=[IsNullable], @col_DefaultVal=[ColumnDefault], @col_IsIdentity=[IsIdentity]
			FROM @TableColumns
			
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX('%[()]%',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX('%[()]%', @col_DefaultVal), 1, '')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + CASE @col_TypeName WHEN 'uniqueidentifier' THEN @col_ColumnName + ' ' + 'nvarchar(100)' ELSE @col_ColumnName + ' ' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName='decimal' THEN '(' + CONVERT(VarChar, @col_Precision) + ', ' + CONVERT(VarChar, @col_Scale) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar', 'char', 'nchar') And @col_MaxLength <> -1 THEN '(' + CONVERT(VarChar, @col_MaxLength) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar') And @col_MaxLength = -1 THEN '(MAX)' 
					ELSE '' 
				END +
				CASE 
					WHEN @col_IsNullable='YES' AND @col_DefaultVal Is Null THEN ' = Null' 
					WHEN @col_DefaultVal Is Not Null AND @col_TypeName Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + @col_DefaultVal
					ELSE '' 
				END 

			DELETE FROM @TableColumns WHERE [ColumnName]=@col_ColumnName
		END

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	/*
	ELSE IF @ActionType = 'DeleteByPK' Or @ActionType = 'SelectByPK'
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			CASE 
				WHEN (@PrimaryKeyColumnName = col.[COLUMN_NAME]) THEN
					@cTAB + '@' + col.[COLUMN_NAME] + ' ' + CASE col.[DATA_TYPE] WHEN 'uniqueidentifier' THEN 'nvarchar(100)' ELSE col.[DATA_TYPE] END + 
					CASE 
						WHEN col.[DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, col.[numeric_precision]) + ', ' + CONVERT(VarChar, col.[numeric_scale]) + ')' 
						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And col.character_maximum_length <> -1 THEN '(' + CONVERT(VarChar, col.character_maximum_length) + ')' 
						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar') And col.character_maximum_length = -1 THEN '(MAX)' 
						ELSE '' 
					END +
					CASE 
						WHEN col.[IS_NULLABLE]='YES' AND col.[COLUMN_DEFAULT] Is Null THEN ' = Null' 
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN ('varchar', 'char', 'money') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
						ELSE '' 
					END 
				ELSE ''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	*/
	ELSE IF @ActionType IN ('DeleteByColumns', 'SelectByColumns', 'DeleteByPK', 'SelectByPK')
	BEGIN
		
		SELECT @ColNameDataTypes = 
			COALESCE(@ColNameDataTypes + ', ' + @nline, '') + 
					@cTAB + '@' + [c].[ColumnName] + ' ' + CASE [c].[DataType] WHEN 'uniqueidentifier' THEN 'nvarchar(100)' ELSE [c].[DataType] END + 
					CASE 
						WHEN [c].[DataType]='decimal' THEN '(' + CONVERT(VarChar, [c].[NumericPrecision]) + ', ' + CONVERT(VarChar, [c].[NumericScale]) + ')' 
						WHEN [c].[DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [c].[CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [c].[CharacterMaximumLength]) + ')' 
						WHEN [c].[DataType] IN ('varchar', 'nvarchar') And [c].[CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END +
					CASE 
						WHEN [c].[IsNullable]='YES' AND [c].[ColumnDefault] Is Null THEN ' = Null' 
						WHEN [c].[ColumnDefault] Is Not Null AND [c].[DataType] IN ('varchar', 'char', 'money') THEN ' = ' + Substring([c].[ColumnDefault], 2, LEN([c].[ColumnDefault]) - 2)
						WHEN [c].[ColumnDefault] Is Not Null AND [c].[DataType] Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + Substring([c].[ColumnDefault], 3, LEN([c].[ColumnDefault]) - 4)
						ELSE '' 
					END
		
		--SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		WHERE [c].[ColumnName] IN (SELECT [ColumnName] FROM @ckColumnsTable)
		

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END

	Insert Into #SqlTable VALUES('As')

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

