USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Database_SaveNamespaces]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Database_SaveNamespaces]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SaveConfiguration]    Script Date: 09/04/2012 18:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2013.06.26
-- Description:		Associates namespace to a database
--					Only one database can be updated at
--					a time
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2013.07.25
-- Description:		Insert new associations
-- =============================================

/*
DatabaseNamespace.cs

DatabaseId
NamespaceId
NamespaceName
EXEC [dbo].[CGEN_DatabaseNamespace_Save] 'False', '<ArrayOfDatabaseNamespace xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><DatabaseNamespace DatabaseId="1" NamespaceId="1" NamespaceName="Saivision.GeneratedObjects" /><DatabaseNamespace DatabaseId="1" NamespaceId="24" NamespaceName="Saivision.GeneratedObjects.Activity" /><DatabaseNamespace DatabaseId="1" NamespaceId="null" NamespaceName="Saivision.GeneratedObjects.ActivityWorkflow" /></ArrayOfDatabaseNamespace>'
*/

CREATE PROCEDURE [dbo].[CGEN_Database_SaveNamespaces] --'True' --''
	@IsTesting Bit = 'False',
	@xmlMetadata xml=null
As
BEGIN
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @DocHandle int,@ErrNo int, @DataBaseId Int,@NamespaceId Int, @NamespaceName varchar(500),@xpathclause nvarchar(2000)

--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

BEGIN TRY
	BEGIN TRANSACTION
	IF @IsTesting='True'
	BEGIN		
		IF @xmlMetadata Is Null
			SET @xmlMetadata = '<ArrayOfDatabaseNamespace xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><DatabaseNamespace DatabaseId="1" NamespaceId="1" NamespaceName="Saivision.GeneratedObjects" /><DatabaseNamespace DatabaseId="1" NamespaceId="null" NamespaceName="Saivision.Platform.Regular" /></ArrayOfDatabaseNamespace>'
		PRINT ''
	END
	
	IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#DatabaseNamespaces]'))AND([type] = 'U')) )	
		DROP TABLE #DatabaseNamespaces
	
	CREATE TABLE #DatabaseNamespaces		
	(
		[DatabaseId] Int,
		[NamespaceId] Int,
		[NamespaceName] [varchar](500)	
	)
	
	EXEC sp_xml_preparedocument @DocHandle OUTPUT, @xmlMetadata
	
	INSERT INTO #DatabaseNamespaces (DatabaseId, NamespaceId, NamespaceName)
	SELECT DatabaseId, CASE WHEN ISNUMERIC(NamespaceId)=1 THEN Convert(int,NamespaceId) ELSE null END, NamespaceName 
	FROM OPENXML (@DocHandle, '//DatabaseNamespace')
	 WITH 
		(
			[DatabaseId] Int,
			[NamespaceId] [varchar](10),
			[NamespaceName] [varchar](500)	
		)

	IF @IsTesting = 'True'	SELECT * FROM #DatabaseNamespaces
	
	-- Insert New Namespaces	
	IF @IsTesting = 'False'
		WHILE EXISTS(SELECT 'X' FROM #DatabaseNamespaces WHERE [NamespaceId] Is Null)
		BEGIN
			SELECT @DataBaseId=Null, @NamespaceId=Null, @NamespaceName=Null
			SELECT TOP 1 @DataBaseId=[DataBaseId], @NamespaceId=[NamespaceId], @NamespaceName=[NamespaceName] 
			FROM #DatabaseNamespaces		
			WHERE [NamespaceId] Is Null
			
			INSERT INTO [CGEN_Namespace](NamespaceName) VALUES (@NamespaceName)
			SELECT @NamespaceId=SCOPE_IDENTITY()
			
			INSERT INTO [CGEN_DatabaseNamespace] VALUES (@DataBaseId, @NamespaceId)
			
			--DELETE TOP (1) #DatabaseNamespaces WHERE [NamespaceId] Is Null
			UPDATE #DatabaseNamespaces SET NamespaceId=@NamespaceId WHERE NamespaceName=@NamespaceName
		END
		
	-- Insert New Associations	
	IF @IsTesting = 'False'
		INSERT INTO [CGEN_DatabaseNamespace]
		SELECT [DatabaseId], [NamespaceId]
		FROM #DatabaseNamespaces tdn
		LEFT JOIN [CGEN_DatabaseNamespace] [dn] ON [tdn].[DatabaseId]=[dn].[CGEN_MasterDatabaseId] AND [tdn].[NamespaceId]=[dn].[CGEN_NamespaceId]
		WHERE [dn].[CGEN_MasterDatabaseId] Is Null
		
		-- Remove namespaces that have been disabled
	IF @IsTesting = 'False'
	BEGIN
		SELECT TOP 1 @DataBaseId=[DataBaseId] FROM #DatabaseNamespaces
		DELETE [dn] FROM CGEN_DatabaseNamespace [dn]
		LEFT JOIN [#DatabaseNamespaces] [dnt] ON [dnt].[DatabaseId]=[dn].[CGEN_MasterDatabaseId] AND [dnt].[NamespaceId]=[dn].[CGEN_NamespaceId]
		WHERE [dn].[CGEN_MasterDatabaseId]=@DataBaseId AND [dnt].[NamespaceId] Is Null
	END
		
	
	COMMIT TRANSACTION
	
	-- remove the xml document
	EXEC sp_xml_removedocument @DocHandle
END TRY
BEGIN CATCH
	IF @@TranCount > 0
	BEGIN
		ROLLBACK TRANSACTION
	END
	
	DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)
	SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())
	SET @ProcName=OBJECT_NAME(@@ProcId)
	SELECT @ErrorInformation=Stuff((
		SELECT
		'EXEC ',
		@ProcName+ ' ',
			@xmlMetadata
			FOR XML PATH ('')
			),1,0,'')
	EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation

END CATCH

END
GO

