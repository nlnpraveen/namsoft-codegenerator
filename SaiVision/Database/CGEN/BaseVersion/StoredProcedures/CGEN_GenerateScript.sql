USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 08/18/2012 00:58:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScript]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScript]
GO


USE [CodeGenerator]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 04/30/2012 17:22:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates Select, Insert, Update and Delete scripts for a table
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Master Table Configuration
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.05
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.13
-- Description:   IsInsert
-- =============================================  
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.06.21
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle bulk update, bulk delete
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.15
-- Description:		Move cgen metadata to its own database
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.20
-- Description:		Pass @MasterTableId
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.09.24
-- Description:		Filter on [IsGenerateCode]
-- =============================================


CREATE PROCEDURE [dbo].[CGEN_GenerateScript]     
	@IsDropOnly Bit='False'
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @SelectByPKProcName VarChar(200), @SelectByColumnsProcName VarChar(200), @UpdateByColumnsProcName VarChar(200), @DeleteByColumnsProcName VarChar(200)
DECLARE @SelectProcName VarChar(200), @InsertProcName VarChar(200), @InsertBulkProcName VarChar(200), @UpdateBulkProcName VarChar(200), @DeleteBulkProcName VarChar(200)
	,@UpdateByPKProcName VarChar(200), @DeleteByPKProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
DECLARE @PrimaryKeyColumnName NVarChar(128), @PrimaryKeyColumnNamePascal NVarChar(128)
DECLARE @ColumnName VarChar(128), @ConstraintName VarChar(128)

DECLARE @CGEN_MasterTableId Int, @DatabaseName nvarchar(128), @TableName nvarchar(128), @TableNamePascal nvarchar(128), @IsSelect Bit, @IsInsert Bit, 
	@IsInsertBulk Bit, @IsUpdateBulk Bit, @IsDeleteBulk Bit, @IsSelectByPK Bit, @IsUpdateByPK Bit, @IsDeleteByPK Bit,
	@IsSelectByColumns Bit, @IsUpdateByColumns Bit, @IsDeleteByColumns Bit, @ColumnNames NVarChar(128), @ColumnNamesPascal NVarChar(128), @RowId Int

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterTableEntries]'))AND([type] = 'U')) )	
	DROP TABLE #MasterTableEntries


SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [mt].[TableName] ORDER BY [mt].[TableName])
	  ,[mt].[CGEN_MasterTableId]
	  ,[d].[DatabaseName]
      ,[mt].[TableName]
		  ,[TableNamePascal]=IsNull([mt].[TableNamePascal], [dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
      ,[PrimaryKeyColumnName]
      ,[PrimaryKeyColumnNamePascal]=[dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[CGEN_MasterTableId])
      ,[mt].[IsSelect]
      ,[mt].[IsInsert]
      ,[mt].[IsInsertBulk]
      ,[mt].[IsUpdateBulk]
      ,[mt].[IsDeleteBulk]
      ,[mt].[IsSelectByPK]
      ,[mt].[IsUpdateByPK]
      ,[mt].[IsDeleteByPK]
      ,[mtc].[IsSelectByColumns]
      ,[mtc].[IsUpdateByColumns]
      ,[mtc].[IsDeleteByColumns]
      ,[mtc].[ColumnNames]
      ,[ColumnNamesPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[CGEN_MasterTableId], [mtc].[ColumnNames])
INTO [#MasterTableEntries]      
FROM [dbo].[CGEN_MasterTable] [mt] WITH(NOLOCK)
	JOIN [CGEN_MasterDatabase] [d] WITH(NOLOCK) ON [mt].[CGEN_MasterDatabaseId]=[d].[CGEN_MasterDatabaseId] 
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]='True' AND [mt].[CGEN_MasterTableId]=[mtc].[CGEN_MasterTableId]
	WHERE [mt].[IsActive]='True' AND [mt].[IsGenerateCode]='True'

WHILE EXISTS(SELECT 'X' FROM [#MasterTableEntries])
BEGIN

	SELECT @CGEN_MasterTableId=Null, @TableNamePascal=Null, @DatabaseName=Null, @TableName=Null ,@IsSelect=Null, @IsInsert=Null ,@IsSelectByPK=Null 
		,@IsInsertBulk=Null, @IsUpdateBulk=Null, @IsDeleteBulk=Null, @IsUpdateByPK=Null ,@IsDeleteByPK=Null  ,@IsSelectByColumns=Null ,@IsUpdateByColumns=Null ,@IsDeleteByColumns=Null
		,@ColumnNames=Null, @ColumnNamesPascal=Null, @RowId=Null


	SELECT TOP 1 @CGEN_MasterTableId=[CGEN_MasterTableId], @DatabaseName=[DatabaseName], @TableNamePascal=[TableNamePascal], @TableName=[TableName],@PrimaryKeyColumnName=[PrimaryKeyColumnName],@PrimaryKeyColumnNamePascal=[PrimaryKeyColumnNamePascal],@IsSelect=[IsSelect], @IsInsert=[IsInsert] 
		,@IsInsertBulk=[IsInsertBulk], @IsUpdateBulk=[IsUpdateBulk], @IsDeleteBulk=[IsDeleteBulk], @IsSelectByPK=[IsSelectByPK] 
		,@IsUpdateByPK=[IsUpdateByPK] ,@IsDeleteByPK=[IsDeleteByPK]  ,@IsSelectByColumns=[IsSelectByColumns] ,@IsUpdateByColumns=[IsUpdateByColumns] ,@IsDeleteByColumns=[IsDeleteByColumns]
		,@ColumnNames=[ColumnNames], @ColumnNamesPascal=[ColumnNamesPascal], @RowId=[RowId]
	FROM [#MasterTableEntries]
	
		--Not Required
		--SELECT @PrimaryKeyColumnNamePascal=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase](@TableName)
		SELECT @SelectProcName = @TableNamePascal+'_Get'
			,@SelectByPKProcName = @TableNamePascal+'_GetBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
			,@InsertProcName = @TableNamePascal+'_Insert', @InsertBulkProcName = @TableNamePascal+'_InsertBulk'
			, @UpdateBulkProcName = @TableNamePascal+'_UpdateBulk', @DeleteBulkProcName = @TableNamePascal+'_DeleteBulk'
			,@UpdateByPKProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
			,@DeleteByPKProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
		SELECT @SelectByColumnsProcName = @TableNamePascal+'_GetBy_'+REPLACE(@ColumnNamesPascal,',','_')
			,@UpdateByColumnsProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@ColumnNamesPascal,',','_')
			,@DeleteByColumnsProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@ColumnNamesPascal,',','_')
		
		--PRINT @TableName
		
		IF @IsSelect='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectProcName, 'Select', @IsDropOnly
		IF @IsSelectByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectByPKProcName, 'SelectByPK', @IsDropOnly
		IF @IsUpdateByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateByPKProcName, 'UpdateByPK', @IsDropOnly
		IF @IsDeleteByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteByPKProcName, 'DeleteByPK', @IsDropOnly		
		IF @IsInsert='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @InsertProcName, 'Insert', @IsDropOnly
		IF @IsInsertBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @InsertBulkProcName, 'InsertBulk', @IsDropOnly
		IF @IsUpdateBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateBulkProcName, 'UpdateBulk', @IsDropOnly
		IF @IsDeleteBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteBulkProcName, 'DeleteBulk', @IsDropOnly
		
		IF @IsSelectByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectByColumnsProcName, 'SelectByColumns', @IsDropOnly, @ColumnNames
		IF @IsUpdateByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateByColumnsProcName, 'UpdateByColumns', @IsDropOnly, @ColumnNames		
		IF @IsDeleteByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteByColumnsProcName, 'DeleteByColumns', @IsDropOnly, @ColumnNames
		
		
		--SELECT PrimaryKeyColumnName=@PrimaryKeyColumnName, PrimaryKeyColumnNamePascal=@PrimaryKeyColumnNamePascal, SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectByColumnsProcName=@SelectByColumnsProcName, UpdateByColumnsProcName=@UpdateByColumnsProcName, DeleteByColumnsProcName=@DeleteByColumnsProcName
	DELETE TOP (1) [#MasterTableEntries]
END


RETURN 0
--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1
