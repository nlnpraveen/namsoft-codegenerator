USE [SaiVision]
GO

/****** Object:  View [dbo].[vwCGEN_Columns_DataTypesSupported]    Script Date: 07/20/2012 15:04:45 ******/
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

ALTER VIEW [dbo].[vwCGEN_Columns]
AS

SELECT [c].TABLE_CATALOG, [c].TABLE_SCHEMA, [c].TABLE_NAME, [c].COLUMN_NAME
	,[ColumnNamePascal]=[dbo].CGEN_fnToPascalCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnNameCamel]=[dbo].CGEN_fnToCamelCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[c].COLUMN_DEFAULT, [c].IS_NULLABLE, [c].DATA_TYPE , [c].[character_maximum_length], [c].[numeric_precision], [c].[numeric_scale], [IsIdentity]=COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], 'IsIdentity') 
FROM INFORMATION_SCHEMA.COLUMNS [c]JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[TABLE_NAME]=[t].[TableName]LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		

/*
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME='JOB_Job'
*/

GO


