USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetPrimaryKeyColumn]    Script Date: 03/12/2012 16:56:58 ******/
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

ALTER PROCEDURE [dbo].[CGEN_GetPrimaryKeyColumn]
	@TableName nvarchar(128),
	@ColumnName nvarchar(128) OUTPUT
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT @ColumnName=IsNull(dbo.CGEN_fnGetPrimaryKeyColumn(@TableName), '')

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

