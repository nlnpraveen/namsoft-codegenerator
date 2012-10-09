USE [CodeGenerator]
GO

/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 08/20/2012 17:20:50 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns]'))
DROP VIEW [dbo].[vwCGEN_Columns]
GO

USE [CodeGenerator]
GO

/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 08/20/2012 17:20:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





-- =======================================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.07.20
-- Description:   Replaces the information_schema.columns view
--				  to return a list of columns with supported datatypes 
--				  for code generation
-- =======================================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Use table [CGEN_MasterTableColumn]
-- =======================================================

CREATE VIEW [dbo].[vwCGEN_Columns]
AS

SELECT TABLE_CATALOG=[db].[DatabaseName], TABLE_SCHEMA=[t].[SchemaName], [t].[TableName], [c].[ColumnName]
	,[ColumnNamePascal]=IsNull([c].[ColumnNamePascal], [dbo].CGEN_fnToPascalCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[ColumnNameCamel]=IsNull([c].[ColumnNameCamel], [dbo].CGEN_fnToCamelCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[c].[ColumnDefault], [c].[IsNullable], [c].[DataType] , [c].[IsIdentity]
FROM [CGEN_MasterTableColumn] [c]
JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
JOIN [CGEN_MasterDatabase] [db] ON [db].[CGEN_MasterDatabaseId]=[t].[CGEN_MasterDatabaseId]


/*
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME='JOB_Job'
*/


GO

