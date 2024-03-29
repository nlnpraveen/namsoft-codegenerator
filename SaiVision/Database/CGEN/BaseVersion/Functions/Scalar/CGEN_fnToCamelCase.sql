USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 08/07/2012 14:25:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToCamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToCamelCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 08/07/2012 14:25:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[CGEN_fnToCamelCase]
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
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.07
-- Description:   Commented the use of LOWER(@Prefix)
--				  and lower only the first letter instead on the prefix to apply
--				  For Debug purposes
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API', @PrefixToApply='Apicell'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION', @PrefixToApply='Api'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedID', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION_NotificationFeed', @PrefixToApply='ApiNotificationFeed'
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
		IF @PrefixToApply Is Not Null AND LEN(@PrefixToApply) > 0
			SET @CamelStr=LOWER(SUBSTRING(@Prefix,1,1)) + SUBSTRING(@Prefix,2,LEN(@Prefix))
		ELSE
			SET @CamelStr=LOWER(@Prefix) -- Previously only this condition was present
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
GO