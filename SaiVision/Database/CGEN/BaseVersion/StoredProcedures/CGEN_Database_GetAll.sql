USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Database_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Database_GetAll]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Database_GetAll]    Script Date: 08/27/2012 15:38:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2012.08.27
-- Description:		Get Database List
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Database_GetAll]
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON


	SELECT [CGEN_MasterDatabaseId]
	  ,[DatabaseName]
	  ,[LastSyncDate]
	FROM [dbo].[CGEN_MasterDatabase]

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

