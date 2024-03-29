USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCase]    Script Date: 03/12/2012 17:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[CGEN_fnToPascalCase]
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
	DECLARE @PascalStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	-- Check Emptiness
	IF @Input='_'
		RETURN ''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @PascalStr = ''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps='True' AND LEN(@Input) > 0
	BEGIN
		SET @PascalStr=[dbo].[CGEN_fnToPascalCase](LOWER(@Input), 0, '', '')		
		RETURN @PascalStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, '_')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+2, LEN(@Input)-LEN(@Prefix))
		SET @PascalStr=[dbo].[CGEN_fnToPascalCaseStrict](LOWER(@Prefix))				
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 1
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@PascalStr = @PascalStr + 
					CASE WHEN @Chr='_' THEN '' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr='_' THEN 1 ELSE 0 END, @Index = @Index + 1
        
        -- For Two Letter Words
        IF @Index=2 AND @StrLen=2
        BEGIN
			SET @Reset=2	 			
		END
		
	END
	
	RETURN @PascalStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @PascalStr = @PascalStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE '[a-zA-Z]' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END