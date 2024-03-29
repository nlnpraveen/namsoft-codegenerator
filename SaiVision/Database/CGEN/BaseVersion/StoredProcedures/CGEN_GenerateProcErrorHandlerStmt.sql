USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 08/18/2012 01:22:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcErrorHandlerStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 08/18/2012 01:22:20 ******/
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
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.09.23
-- Description:   Update [IsPrimary] Check
-- =============================================  
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
( 
	@CGEN_MasterTableId Int,
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

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId

		
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
		
				', ''@' + [c].[ColumnName] + '='', @' + [c].[ColumnName]
			
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	END
	ELSE IF @ActionType In ('DeleteByPK', 'SelectByPK', 'UpdateByPK')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			CASE 
				--WHEN (@PrimaryKeyColumnName = [c].[ColumnName]) THEN
				WHEN [c].[IsPrimaryKey]='True' THEN
					', ''@' + [c].[ColumnName] + '='', @' + [c].[ColumnName]					
				ELSE ''
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	ELSE IF @ActionType In ('DeleteByColumns', 'SelectByColumns', 'UpdateByColumns')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			', ''@' + [ColumnName] + '='', @' + [ColumnName]					
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

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


GO

