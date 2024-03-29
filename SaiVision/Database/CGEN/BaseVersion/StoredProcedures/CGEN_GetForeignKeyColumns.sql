USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetForeignKeyColumns]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetForeignKeyColumns]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GetForeignKeyColumns]    Script Date: 03/12/2012 16:56:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get the foreign key columns for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetForeignKeyColumns]
	@TableName nvarchar(128)
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT
       FK.Table_Name, CU.Column_Name, FK.Constraint_Name, FK.Constraint_Type 
FROM       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE      FK.TABLE_NAME=@TableName AND cu.Column_Name Not In ('LastUpdateUserId')

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

