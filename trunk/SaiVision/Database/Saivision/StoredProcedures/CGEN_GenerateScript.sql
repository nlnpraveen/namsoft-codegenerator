USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 03/12/2012 16:55:44 ******/
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


ALTER PROCEDURE [dbo].[CGEN_GenerateScript]     
	@IsDropOnly Bit='False'
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @SelectByPKProcName VarChar(200), @SelectByColumnsProcName VarChar(200), @UpdateByColumnsProcName VarChar(200), @DeleteByColumnsProcName VarChar(200)
DECLARE @SelectProcName VarChar(200), @InsertProcName VarChar(200), @UpdateByPKProcName VarChar(200), @DeleteByPKProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
DECLARE @PrimaryKeyColumnName NVarChar(128), @PrimaryKeyColumnNamePascal NVarChar(128)
DECLARE @ColumnName VarChar(128), @ConstraintName VarChar(128)

DECLARE @CGEN_MasterTableId Int, @TableName nvarchar(128), @TableNamePascal nvarchar(128), @IsSelect Bit, @IsInsert Bit, @IsSelectByPK Bit, @IsUpdateByPK Bit, @IsDeleteByPK Bit,
	@IsSelectByColumns Bit, @IsUpdateByColumns Bit, @IsDeleteByColumns Bit, @ColumnNames NVarChar(128), @ColumnNamesPascal NVarChar(128)

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterTableEntries]'))AND([type] = 'U')) )	
	DROP TABLE #MasterTableEntries


SELECT [mt].[CGEN_MasterTableId]
      ,[mt].[TableName]
      ,[TableNamePascal]=[dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
      ,[mt].[IsSelect]
      ,[mt].[IsInsert]
      ,[mt].[IsSelectByPK]
      ,[mt].[IsUpdateByPK]
      ,[mt].[IsDeleteByPK]
      ,[mtc].[IsSelectByColumns]
      ,[mtc].[IsUpdateByColumns]
      ,[mtc].[IsDeleteByColumns]
      ,[mtc].[ColumnNames]
      ,[ColumnNamesPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[TableName], [mtc].[ColumnNames])
INTO [#MasterTableEntries]      
FROM [dbo].[CGEN_MasterTable] [mt]
LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] ON [mtc].[IsActive]='True' AND [mt].[TableName]=[mtc].[TableName]
WHERE [mt].[IsActive]='True'

WHILE EXISTS(SELECT 'X' FROM [#MasterTableEntries])
BEGIN

	SELECT @CGEN_MasterTableId=Null, @TableNamePascal=Null, @TableName=Null ,@IsSelect=Null, @IsInsert=Null ,@IsSelectByPK=Null 
		,@IsUpdateByPK=Null ,@IsDeleteByPK=Null  ,@IsSelectByColumns=Null ,@IsUpdateByColumns=Null ,@IsDeleteByColumns=Null
		,@ColumnNames=Null, @ColumnNamesPascal=Null


	SELECT TOP 1 @CGEN_MasterTableId=[CGEN_MasterTableId], @TableNamePascal=[TableNamePascal], @TableName=[TableName] ,@IsSelect=[IsSelect], @IsInsert=[IsInsert] ,@IsSelectByPK=[IsSelectByPK] 
		,@IsUpdateByPK=[IsUpdateByPK] ,@IsDeleteByPK=[IsDeleteByPK]  ,@IsSelectByColumns=[IsSelectByColumns] ,@IsUpdateByColumns=[IsUpdateByColumns] ,@IsDeleteByColumns=[IsDeleteByColumns]
		,@ColumnNames=[ColumnNames], @ColumnNamesPascal=[ColumnNamesPascal]
	FROM [#MasterTableEntries]
	

		SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName), @PrimaryKeyColumnNamePascal=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase](@TableName)
		SELECT @SelectProcName = @TableNamePascal+'_Get', @SelectByPKProcName = @TableNamePascal+'_GetBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_'), @InsertProcName = @TableNamePascal+'_Insert', @UpdateByPKProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_'), @DeleteByPKProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
		SELECT @SelectByColumnsProcName = @TableNamePascal+'_GetBy_'+REPLACE(@ColumnNamesPascal,',','_'), @UpdateByColumnsProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@ColumnNamesPascal,',','_'), @DeleteByColumnsProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@ColumnNamesPascal,',','_')
		
		
		IF @IsSelect='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectProcName, 'Select', @IsDropOnly
		IF @IsSelectByPK='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectByPKProcName, 'SelectByPK', @IsDropOnly
		IF @IsUpdateByPK='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @UpdateByPKProcName, 'UpdateByPK', @IsDropOnly
		IF @IsDeleteByPK='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @DeleteByPKProcName, 'DeleteByPK', @IsDropOnly		
		IF @IsInsert='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @InsertProcName, 'Insert', @IsDropOnly
		
		IF @IsSelectByColumns='True'
		BEGIN
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectByColumnsProcName, 'SelectByColumns', @IsDropOnly, @ColumnNames
		END
		IF @IsUpdateByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @UpdateByColumnsProcName, 'UpdateByColumns', @IsDropOnly, @ColumnNames		
		IF @IsDeleteByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @DeleteByColumnsProcName, 'DeleteByColumns', @IsDropOnly, @ColumnNames
		
		
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
