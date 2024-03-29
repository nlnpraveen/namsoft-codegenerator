USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 03/12/2012 17:39:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[CGEN_fnToCamelCase]
	(@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128))
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
	DECLARE @CamelStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	
	-- Check Emptiness
	IF @Input='_'
		RETURN ''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @CamelStr = ''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps='True' AND LEN(@Input) > 0
	BEGIN
		SET @CamelStr=[dbo].[CGEN_fnToCamelCase](LOWER(@Input), 0, '', '')		
		RETURN @CamelStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, '_')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+1, LEN(@Input)-LEN(@Prefix))
		SET @CamelStr=LOWER(@Prefix)
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 2
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@CamelStr = @CamelStr + 
					CASE WHEN @Chr='_' THEN '' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr='_' THEN 1 ELSE 0 END, @Index = @Index + 1       
		
	END
	
	RETURN @CamelStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @CamelStr = @CamelStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE '[a-zA-Z]' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END