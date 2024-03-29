USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 08/15/2012 14:55:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_SelectMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 08/15/2012 14:55:12 ******/
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
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.15
-- Description:		Move cgen metadata to its own database
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.09.18
-- Description:		Return [IsGenerateCode]
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.09.23
-- Description:		Update table names
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2013.06.26
-- Description:		Return table namespace
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2013.07.26
-- Description:		Return table namespaceId & Name
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
	@DatabaseName NVarChar(128)='CommandCenter'
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#TableObjects]'))AND([type] = 'U')) )	
	DROP TABLE #TableObjects
	
SELECT TOP 100 [RowId]=ROW_NUMBER() OVER(PARTITION BY [TableName] ORDER BY [TableName]), *
	,[SelectProc]=CASE [mt].[IsSelect] WHEN 'True' THEN [mt].[TableNamePascal]+'_Get' ELSE Null END 
	,[SelectByPKProc]=CASE [mt].[IsSelectByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[UpdateByPKProc]=CASE [mt].[IsUpdateByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[DeleteByPKProc]=CASE [mt].[IsDeleteByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[InsertBulkProc]=CASE [mt].[IsInsertBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_InsertBulk' ELSE Null END 
	,[UpdateBulkProc]=CASE [mt].[IsUpdateBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBulk' ELSE Null END 
	,[DeleteBulkProc]=CASE [mt].[IsDeleteBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBulk' ELSE Null END 
	,[SelectByColumnsProc]=CASE [mt].[IsSelectByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[UpdateByColumnsProc]=CASE [mt].[IsUpdateByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[DeleteByColumnsProc]=CASE [mt].[IsDeleteByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
INTO [#TableObjects]	
FROM (
	SELECT [DatabaseId]=[mt].[CGEN_MasterDatabaseId],[TableId]=[mt].[CGEN_MasterTableId],[mt].[TableName]
		  ,[TableNamePascal]=IsNull([mt].[TableNamePascal], [dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
		  ,[TableNameCamel]=IsNull([mt].[TableNameCamel], [dbo].[CGEN_fnToCamelCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
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
		,[PrimaryKey]=[PrimaryKeyColumnName]
		--,[PrimaryKey]=dbo.[CGEN_fnGetPrimaryKeyColumn]([mt].[TableName])
		,[PrimaryKeyPascal]=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[CGEN_MasterTableId])
		,[PrimaryKeyCamel]=dbo.[CGEN_fnGetPrimaryKeyColumn_CamelCase]([mt].[CGEN_MasterTableId])
		,[QueryColumns]=[ColumnNames]
		  ,[QueryColumnsPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[CGEN_MasterTableId], [mtc].[ColumnNames])
		  ,[QueryColumnsCamel]=[dbo].[CGEN_fnGetColumnNames_CamelCase]([mt].[CGEN_MasterTableId], [mtc].[ColumnNames])
		  ,[mt].[IsGenerateCode]
		  ,[mt].[IsgenerateCodeAlways]
		  ,[NamespaceName]=ISNULL(tn.NamespaceName, dn.NamespaceName)
		  ,[NamespaceId]=ISNULL(tn.[CGEN_NamespaceId], dn.[CGEN_NamespaceId])
	FROM [CGEN_MasterTable] [mt] WITH(NOLOCK)
	JOIN [CGEN_MasterDatabase] [md] WITH(NOLOCK) ON [md].[DatabaseName]=@DatabaseName AND [mt].[CGEN_MasterDatabaseId]=[md].[CGEN_MasterDatabaseId]
	JOIN [CGEN_Namespace] [dn] WITH(NOLOCK) ON [dn].[CGEN_NamespaceId]=[md].[DefaultNamespaceId]
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]='True' AND [mt].[CGEN_MasterTableId]=[mtc].[CGEN_MasterTableId]
	LEFT JOIN [CGEN_Namespace] [tn] WITH(NOLOCK) ON [tn].[CGEN_NamespaceId]=[mt].[CGEN_NamespaceId]
	WHERE [mt].[IsActive]='True' Or ([mt].IsGenerateCode = 'True' Or [mt].[IsGenerateCodeAlways]='True')
) [mt]

SELECT * FROM [#TableObjects]

SELECT TABLE_CATALOG=[db].[DatabaseName], TABLE_SCHEMA=[t].[SchemaName], [t].[CGEN_MasterDatabaseId],[TableId]=[t].[CGEN_MasterTableId], [ColumnId]=[c].[CGEN_MasterTableColumnId], [t].[TableName], [c].[ColumnName]
	,[ColumnNamePascal]=IsNull([c].[ColumnNamePascal], [dbo].CGEN_fnToPascalCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[ColumnNameCamel]=IsNull([c].[ColumnNameCamel], [dbo].CGEN_fnToCamelCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[c].[ColumnDefault], [c].[IsNullable], [c].[DataType] , [c].[IsIdentity]
FROM [CGEN_MasterDatabase] [db] WITH(NOLOCK)
JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON  [db].[DatabaseName]=@DatabaseName AND [t].[IsActive]='True' AND [db].[CGEN_MasterDatabaseId]=[t].[CGEN_MasterDatabaseId]
JOIN [CGEN_MasterTableColumn] [c] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
JOIN [#TableObjects] [to] WITH(NOLOCK) ON [to].[TableId]=[t].[CGEN_MasterTableId] 

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

GO


