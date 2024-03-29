USE [SaiVision]
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
  
ALTER FUNCTION [dbo].[CGEN_fnTrimUnderscores]
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

