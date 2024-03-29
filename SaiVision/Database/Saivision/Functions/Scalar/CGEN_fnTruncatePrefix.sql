USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTruncatePrefix]    Script Date: 03/12/2012 17:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Removes the prefix appropriately from the string
-- =============================================
  
ALTER FUNCTION [dbo].[CGEN_fnTruncatePrefix]
( 
	@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128)
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

DECLARE @Prefix nVarchar(128), @Str nVarChar(128)
DECLARE @prefixesTable TABLE ([prefix] VARCHAR(8000))

	--Check if required to truncate
	IF ((PATINDEX('[_]%', @PrefixToTruncate) > 0 AND LEN(@PrefixToTruncate)=1) Or (@IsTruncatePrefix='False'))
		RETURN @Input
	
	IF (@PrefixToTruncate Is Not Null) AND (@IsTruncatePrefix='True')
	BEGIN
		Insert INTo @prefixesTable([prefix])
		SELECT [strval] FROM [dbo].[Split](@PrefixToTruncate, ',')
		
		--SELECT * FROM @prefixesTable
		
		WHILE EXISTS(SELECT * FROM @prefixesTable)
		BEGIN
			SELECT TOP 1 @Prefix=[prefix] FROM @prefixesTable
			
			IF PATINDEX(@Prefix+'%', @Input)=1
			BEGIN
				SET @Input=SUBSTRING(@Input, LEN(@Prefix)+1, LEN(@Input)-LEN(@Prefix))
				SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)
				IF @PrefixToApply Is Not Null
				BEGIN
					SET @PrefixToApply = [dbo].[CGEN_fnTrimUnderscores](@PrefixToApply)
					SET @Input=@PrefixToApply + '_' + @Input
				END
				BREAK
			END
			DELETE TOP (1) @prefixesTable
		END	
	END
	ELSE IF @IsTruncatePrefix='True'
	BEGIN
		SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, '_')
		IF @Prefix <> @Input
		BEGIN
			SET @Str=SUBSTRING(@Input, LEN(@Prefix)+2, LEN(@Input)-LEN(@Prefix))				
			IF LEN(@Str) > 0		
				SET @Input=@Str
			ELSE
				SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)
		END		
	END
	SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)

	RETURN @Input

END

