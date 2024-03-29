USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnTrimUnderscores]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnTrimUnderscores]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTrimUnderscores]    Script Date: 03/12/2012 17:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.25  
-- Description:   Trims the left and right underscores if present
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnTrimUnderscores]
( 
	@Input nVarChar(128)
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @uIndex Int
	SELECT @uIndex = PATINDEX('[_]%', @Input)
	IF @uIndex > 0
	SELECT @Input=SUBSTRING(@Input, 2, LEN(@Input)-1)
	SELECT @uIndex = PATINDEX('%[_]', @Input)
	IF @uIndex > 0
	SELECT @Input=SUBSTRING(@Input, 1, LEN(@Input)-1)

	RETURN @Input

END

