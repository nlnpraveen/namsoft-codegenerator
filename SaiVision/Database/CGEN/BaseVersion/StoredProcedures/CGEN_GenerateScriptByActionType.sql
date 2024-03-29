USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 08/18/2012 01:00:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScriptByActionType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 08/18/2012 01:00:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates script for a table based on action type (available actions: Select, SelectByPK, UpdateByPK, DeleteByPK, Insert, InsertBulk, SelectByColumns, UpdateByColumns, DeleteByColumns)
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.10
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


CREATE PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
	@CGEN_MasterTableId Int,
	@DatabaseName nvarchar(128),
	@TableName nvarchar(128),	
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@IsOnlyDrop	bit,
	@fkColumnName nVarchar(128) = Null
	
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @ScriptText NVarChar(MAX)
DECLARE @SelectProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2), @dline char(2)
IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#SqlTable]'))AND([type] = 'U')) )	
	DROP TABLE #SqlTable
CREATE Table #SqlTable(Id Int Identity Primary Key, SqlStr VarChar(MAX))

DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

--SELECT @TableName=[TableName], @DatabaseName=[DatabaseName] FROM [CGEN_MasterTable] [t] WITH(NOLOCK) JOIN [CGEN_MasterDatabase] [d] WITH(NOLOCK) ON [t].[CGEN_MasterDatabaseId]=[d].[CGEN_MasterDatabaseId] WHERE [t].[CGEN_MasterTableId]=@TableId

SET		@cTAB = char(9)
SET		@Indent = '   '
SET 	@nline = char(13) + char(10)
SET 	@dline = char(10) + char(13)

Insert Into #SqlTable VALUES('/****************************************************************************************/' + @dline)

EXEC [dbo].[CGEN_GenerateProcDropStmt] @DatabaseName, @ProcName--
Insert Into #SqlTable VALUES(@dline)


IF @IsOnlyDrop = 0
BEGIN
	Insert Into #SqlTable VALUES('SET ANSI_NULLS ON' + @nline)	
	Insert Into #SqlTable VALUES('SET QUOTED_IDENTIFIER ON' + @nline)
	Insert Into #SqlTable VALUES('GO')
	Insert Into #SqlTable VALUES(@dline)

	EXEC [dbo].[CGEN_GenerateProcHeader] @TableName, @ActionType--
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcCreateStmt] @CGEN_MasterTableId, @TableName, @ProcName, @ActionType, @fkColumnName--
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('-- DECLARE' + @nline)
	
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('DECLARE @ErrNo int' + @nline)
	IF @ActionType IN ('InsertBulk', 'UpdateBulk', 'DeleteBulk')
		Insert Into #SqlTable VALUES('DECLARE @DocHandle int' + @nline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('-- PROCESSING' + @nline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------')
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('SET NOCOUNT ON' + @nline)
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('BEGIN TRY' + @nline )
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcBodyStmt] @CGEN_MasterTableId, @ProcName, @TableName, @ActionType, @fkColumnName--
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('END TRY' + @nline)
	Insert Into #SqlTable VALUES('BEGIN CATCH' + @nline)
	--SET @ScriptText = @ScriptText + @cTAB + 'EXEC CME360_DatabaseExceptionLog_Add' + @nline  -- new
	EXEC [dbo].[CGEN_GenerateProcErrorHandlerStmt] @CGEN_MasterTableId, @TableName, @ProcName, @ActionType, @fkColumnName
	Insert Into #SqlTable VALUES('END CATCH' + @nline)
	Insert Into #SqlTable VALUES(@dline)	
	Insert Into #SqlTable VALUES('GO')	
END

--SELECT * FROM #SqlTable
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

--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1


GO

