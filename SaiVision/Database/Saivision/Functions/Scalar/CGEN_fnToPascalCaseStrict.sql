USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCaseStrict]    Script Date: 03/12/2012 17:39:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[CGEN_fnToPascalCaseStrict]
	(@Input nVarChar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @PascalStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	
	SELECT @PascalStr='', @StrLen=LEN(@Input), @Index=1, @Reset = 1
	
	-- Check Emptiness
	IF @Input='_'
		RETURN ''
	
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @PascalStr = @PascalStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
		   @Reset = CASE WHEN @Chr LIKE '[a-zA-Z]' THEN 0 ELSE 1 END, @Index = @Index + 1				
	END
	
	RETURN @PascalStr	
END