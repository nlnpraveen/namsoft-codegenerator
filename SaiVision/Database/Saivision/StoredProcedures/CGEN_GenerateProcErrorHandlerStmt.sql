USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 03/12/2012 16:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns the create statement for a procedure
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
-- Action date:   2012.02.19
-- Description:   Error handler statement was missing
-- =============================================
  
ALTER PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
( 
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
) 
AS  

SET NOCOUNT ON;

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

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))


	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName)

		
	Insert Into #SqlTable VALUES(@cTAB + 'DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SET @ProcName=OBJECT_NAME(@@ProcId)'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SELECT @ErrorInformation=Stuff(('+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SELECT'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + '''EXEC '','+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + '@ProcName+ '' '''+ @nline)
	--SET @Stmt = @Stmt + @cTAB + @cTAB + @cTAB + '''@RoleId='', IsNull(CONVERT(VarChar, @RoleId), + '' '','+ @nline
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, ',')	
	END	
	
	IF @ActionType In ('Insert')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
		
				', ''@' + col.[COLUMN_NAME] + '='', @' + col.[COLUMN_NAME]
			
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName		
	END
	ELSE IF @ActionType In ('DeleteByPK', 'SelectByPK', 'UpdateByPK')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			CASE 
				--WHEN (@PrimaryKeyColumnName = col.[COLUMN_NAME]) THEN
				WHEN PATINDEX('%'+col.[COLUMN_NAME]+'%', @PrimaryKeyColumnName) > 0 THEN
					', ''@' + col.[COLUMN_NAME] + '='', @' + col.[COLUMN_NAME]					
				ELSE ''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	ELSE IF @ActionType In ('DeleteByColumns', 'SelectByColumns', 'UpdateByColumns')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			', ''@' + [COLUMN_NAME] + '='', @' + [COLUMN_NAME]					
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName AND col.COLUMN_NAME IN (SELECT [ColumnName] FROM @ckColumnsTable)

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + IsNull(@ColNameDataTypes, '') + @nline)
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + 'FOR XML PATH ('''')'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + '),1,0,'''')'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation'+ @nline)
	
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

