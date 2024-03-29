USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[ErrorLog_Add]    Script Date: 03/12/2012 17:30:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2011.02.17 
-- Description:   Logs the exception
--
--www.sommarskog.se/error-handling-I.html
--www.sommarskog.se/error-handling-II.html
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.06.27
-- Description:   Return ErrorGuid in the message
-- =============================================  

ALTER PROCEDURE [dbo].[ErrorLog_Add]
	@ErrorLogId UniqueIdentifier = Null,
	@CallingProcedure NVarChar(500) = Null,
	@AdditionalInfo		nvarchar(max) = Null
AS
--http://jwwishart.wordpress.com/2009/08/05/returning-the-newsequentialid-after-insert-using-the-output-clause/
SET NOCOUNT ON;

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE	@ErrorMessage	nvarchar(max),
		@ErrorNumber	nvarchar(100),
		@ErrorLine		nvarchar(100),
		@ErrorSeverity	nvarchar(100),
		@ErrorState		nvarchar(100),
		@ErrorProcedure	nvarchar(500),
		@CustomError	nvarchar(max),
		@ErrId UniqueIdentifier
	
DECLARE @ErrorGuidTable Table
(
	ErrorGuid UniqueIdentifier
)
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------
SELECT @ErrorMessage = ERROR_MESSAGE(), 
		@ErrorNumber = ERROR_NUMBER(), 
		@ErrorLine = ERROR_LINE(), 
		@ErrorSeverity = ERROR_SEVERITY(), 
		@ErrorState = ERROR_STATE(), 
		@ErrorProcedure = IsNull(@CallingProcedure, Error_Procedure())
/* Log the exception */
INSERT INTO [dbo].[ErrorLog]
	   ([ParentErrorGuid]
	   ,[ErrorProcedure]
	   ,[ErrorLine]
	   ,[ErrorNumber]
	   ,[ErrorMessage]
	   ,[ErrorSeverity]
	   ,[ErrorState]
	   ,[ErrorInformation])
	   OUTPUT INSERTED.ErrorGuid Into @ErrorGuidTable
 VALUES
	   (@ErrorLogId
	   ,@ErrorProcedure
	   ,@ErrorLine
	   ,@ErrorNumber
	   ,@ErrorMessage
	   ,@ErrorSeverity
	   ,@ErrorState
	   ,@AdditionalInfo)
SELECT @ErrId=[ErrorGuid] FROM @ErrorGuidTable
IF @ErrorLogId is Null
BEGIN
	SET @ErrorLogId=@ErrId
	SET @CustomError = ISNULL(@ErrorMessage,'None') + '; Number = ' + ISNULL(@ErrorNumber ,'None') + '; Line = ' + ISNULL(@ErrorLine, 'None') + '; Severity = ' + @ErrorSeverity + '; State = ' + @ErrorState + '; Procedure = ' + ISNULL(@ErrorProcedure, 'None') + 'ERRORGUID|||' + IsNull(Convert(varchar(100), @ErrorLogId), 'Empty')
	PRINT @CustomError
END
ELSE
	SET @CustomError=@ErrorMessage
/* Raise error */
RAISERROR (@CustomError, @ErrorSeverity, @ErrorState)

