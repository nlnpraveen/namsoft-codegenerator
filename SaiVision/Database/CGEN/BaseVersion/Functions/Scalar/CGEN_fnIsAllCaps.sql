USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsAllCaps]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsAllCaps]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsAllCaps]    Script Date: 03/12/2012 17:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CGEN_fnIsAllCaps]
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