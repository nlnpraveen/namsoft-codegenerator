USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 03/12/2012 17:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		01-26-2009
-- Description:		Select all the Nams database metadata
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.02.05
-- Description:		Composite Keys
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.23
-- Description:		Insert, Update, Delete bulk functionality
-- =============================================
ALTER PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
As
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------
SET NOCOUNT ON
SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [TableName] ORDER BY [TableName]), *	,[SelectProc]=CASE [mt].[IsSelect] WHEN 'True' THEN [mt].[TableNamePascal]+'_Get' ELSE Null END 
	,[SelectByPKProc]=CASE [mt].[IsSelectByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[UpdateByPKProc]=CASE [mt].[IsUpdateByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[DeleteByPKProc]=CASE [mt].[IsDeleteByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[InsertBulkProc]=CASE [mt].[IsInsertBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_InsertBulk' ELSE Null END 
	,[UpdateBulkProc]=CASE [mt].[IsUpdateBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBulk' ELSE Null END 
	,[DeleteBulkProc]=CASE [mt].[IsDeleteBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBulk' ELSE Null END 
	,[SelectByColumnsProc]=CASE [mt].[IsSelectByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[UpdateByColumnsProc]=CASE [mt].[IsUpdateByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[DeleteByColumnsProc]=CASE [mt].[IsDeleteByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
FROM (	SELECT [mt].[TableName]
		  ,[TableNamePascal]=[dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
		  ,[TableNameCamel]=[dbo].[CGEN_fnToCamelCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
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
		,[PrimaryKey]=dbo.[CGEN_fnGetPrimaryKeyColumn]([mt].[TableName])
		,[PrimaryKeyPascal]=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[TableName])
		,[PrimaryKeyCamel]=dbo.[CGEN_fnGetPrimaryKeyColumn_CamelCase]([mt].[TableName])
		,[QueryColumns]=[ColumnNames]
		  ,[QueryColumnsPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[TableName], [mtc].[ColumnNames])
		  ,[QueryColumnsCamel]=[dbo].[CGEN_fnGetColumnNames_CamelCase]([mt].[TableName], [mtc].[ColumnNames])
	FROM [CGEN_MasterTable] [mt] WITH(NOLOCK)
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]='True' AND [mt].[TableName]=[mtc].[TableName]
	WHERE [mt].[IsActive]='True'
) [mt]

SELECT [c].TABLE_CATALOG, [c].TABLE_SCHEMA, [TableName]=[c].TABLE_NAME, [ColumnName]=[c].COLUMN_NAME
	,[ColumnNamePascal]=[dbo].CGEN_fnToPascalCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnNameCamel]=[dbo].CGEN_fnToCamelCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnDefault]=[c].COLUMN_DEFAULT, [IsNullable]=[c].IS_NULLABLE, [DataType]=[c].DATA_TYPE , [IsIdentity]=COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], 'IsIdentity') 
FROM INFORMATION_SCHEMA.COLUMNS [c]JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[TABLE_NAME]=[t].[TableName]LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0
--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1
