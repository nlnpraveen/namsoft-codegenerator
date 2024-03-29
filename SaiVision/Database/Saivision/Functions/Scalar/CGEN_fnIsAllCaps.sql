USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsAllCaps]    Script Date: 03/12/2012 17:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[CGEN_fnIsAllCaps]
	(@Input nVarChar(128))
RETURNS Bit

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @IsAllCaps Bit
	
	SELECT @IsAllCaps=
		CASE 
			WHEN @Input = UPPER(@Input) COLLATE Latin1_General_CS_AI  
			THEN 'True' ELSE 'False'
		END 

	RETURN @IsAllCaps
END