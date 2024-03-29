USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorLog_Add1]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ErrorLog_Add1]
GO

/****** Object:  StoredProcedure [dbo].[ErrorLog_Add1]    Script Date: 03/12/2012 17:31:23 ******/
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

CREATE PROCEDURE [dbo].[ErrorLog_Add1]
	@ErrorLogId Int = Null,
	@CallingProcedure NVarChar(500) = Null,
	@AdditionalInfo		nvarchar(max) = Null
AS
BEGIN
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
			@ErrId Int
	

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
		   ([ParentErrorLogId]
		   ,[ErrorGuid]
		   ,[ErrorProcedure]
		   ,[ErrorLine]
		   ,[ErrorNumber]
		   ,[ErrorMessage]
		   ,[ErrorSeverity]
		   ,[ErrorState]
		   ,[ErrorInformation])
	 VALUES
		   (@ErrorLogId
		   ,NEWID()
		   ,@ErrorProcedure
		   ,@ErrorLine
		   ,@ErrorNumber
		   ,@ErrorMessage
		   ,@ErrorSeverity
		   ,@ErrorState
		   ,@AdditionalInfo)
	SELECT @ErrId=SCOPE_IDENTITY()
	IF @ErrorLogId is Null
		SET @ErrorLogId=@ErrId
	/* Raise error */
	SET @CustomError = ISNULL(@ErrorMessage,'None') + '; Number = ' + ISNULL(@ErrorNumber ,'None') + '; Line = ' + ISNULL(@ErrorLine, 'None') + '; Severity = ' + @ErrorSeverity + '; State = ' + @ErrorState + '; Procedure = ' + ISNULL(@ErrorProcedure, 'None')	
	--RAISERROR (@CustomError, @ErrorSeverity, @ErrorState)
	RETURN @ErrorLogId
END



