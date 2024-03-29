USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Select]    Script Date: 03/12/2012 17:29:29 ******/
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
ALTER PROCEDURE [dbo].[CGEN_Metadata_Select]
As
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------
SET NOCOUNT ON
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, dbo.[CGEN_fnGetPrimaryKeyColumn](TABLE_NAME) As 'PrimaryKey'
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RM_Role'

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE , COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], 'IsIdentity') 'IsIdentity'
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'RM_Role'SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0
--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1
