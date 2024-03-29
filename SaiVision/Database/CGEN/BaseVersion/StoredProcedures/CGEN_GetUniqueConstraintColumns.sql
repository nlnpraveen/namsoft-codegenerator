USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetUniqueConstraintColumns]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetUniqueConstraintColumns]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GetUniqueConstraintColumns]    Script Date: 03/12/2012 16:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get Unique Constraint Columns for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetUniqueConstraintColumns]
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

SELECT DISTINCT RK.Constraint_Name
FROM       
INFORMATION_SCHEMA.TABLE_CONSTRAINTS RK 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RK.Constraint_Type='Unique' AND RK.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE RK.TABLE_NAME=@TableName 


SELECT RK.TABLE_NAME, CU.Column_name, RK.Constraint_Name, RK.Constraint_Type
FROM       
INFORMATION_SCHEMA.TABLE_CONSTRAINTS RK 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RK.Constraint_Type='Unique' AND RK.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE      RK.TABLE_NAME=@TableName

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

