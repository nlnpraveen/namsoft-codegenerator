USE [CodeGenerator]
GO

/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 08/20/2012 17:20:50 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns_DataTypesSupported]'))
DROP VIEW [dbo].[vwCGEN_Columns_DataTypesSupported]
GO

/****** Object:  View [dbo].[vwCGEN_DataTypeColumns_Supported]    Script Date: 03/19/2012 15:27:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



-- =======================================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.03.19
-- Description:   Replaces the information_schema.columns view
--				  to return a list of columns with supported datatypes 
--				  for code generation
-- =======================================================

CREATE VIEW [dbo].[vwCGEN_Columns_DataTypesSupported]
AS


SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME='JOB_Job'


GO


