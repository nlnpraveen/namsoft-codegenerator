USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsTablePrimaryKeyPresent]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsTablePrimaryKeyPresent]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsTablePrimaryKeyPresent]    Script Date: 03/12/2012 17:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Retunrs true if the table has a primary key
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnIsTablePrimaryKeyPresent]
( 
	@TableName nvarchar(128)    
)  

RETURNS BIT 
AS  

BEGIN 

    DECLARE @IndId Int

	SELECT 	@IndId=indid 
	FROM 	sysindexes
	WHERE 	id = OBJECT_ID(@TableName)
	AND 	indid BETWEEN 1 AND 254 
	AND 	(status & 2048) = 2048


	-----------------------------
	IF @IndId Is Null
		RETURN 0
	RETURN 1
	-----------------------------

END

