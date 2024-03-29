USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Split]
GO

/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 03/12/2012 17:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split] (
@str_in VARCHAR(8000),
@separator VARCHAR(4) )
RETURNS @strtable TABLE (strval VARCHAR(8000))

AS
/*******************************************************************************
* Stored Procedure Name: Split
*                                               
* Creation Date: 8/20/2007
*	
* Praveen Namburi
*
*******************************************************************************/

BEGIN
DECLARE @Occurrences INT, @Counter INT, @tmpStr VARCHAR(8000)

SET @Counter = 0
IF SUBSTRING(@str_in,LEN(@str_in),1) <> @separator
	SET @str_in = @str_in + @separator

SET @Occurrences = (DATALENGTH(REPLACE(@str_in,@separator,@separator+'#')) - DATALENGTH(@str_in))/ DATALENGTH(@separator)
SET @tmpStr = @str_in

WHILE @Counter <= @Occurrences 

BEGIN
	SET @Counter = @Counter + 1
	INSERT INTO @strtable VALUES ( SUBSTRING(@tmpStr,1,CHARINDEX(@separator,@tmpStr)-1))
	SET @tmpStr = SUBSTRING(@tmpStr,CHARINDEX(@separator,@tmpStr)+1,8000)

	IF DATALENGTH(@tmpStr) = 0
	BREAK
END

RETURN 
END
