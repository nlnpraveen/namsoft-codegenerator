USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 03/12/2012 17:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2011.06.27
-- Description:   Return the ErrorGuid found in the
--				  error message. If none exists then
--				  return null. Guid should be appended in the
--				  format - ERRORGUID|||{Guid}
-- =============================================
  
ALTER FUNCTION [dbo].[ERRORLOG_fnGetIdentifier]
( 
	@ErrorMessage nvarchar(MAX)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

    DECLARE @Index Int, @ErrorGuid NVarChar(100)
    
    SELECT @ErrorGuid=Null
    SELECT @Index=PATINDEX('%ERRORGUID|||%', @ErrorMessage)

	IF @Index > 1
		SELECT @ErrorGuid=SUBSTRING(@ErrorMessage, @Index+12, (LEN(@ErrorMessage)-@Index))	

	-----------------------------

	RETURN @ErrorGuid
	-----------------------------

END

