USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_DatabaseNamespace_Get]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Database_GetNamespaces]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Database_GetNamespaces]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Database_GetNamespaces]    Script Date: 09/04/2012 18:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2013.06.26
-- Description:		Gets all the namespaces associated
--					with a particular database
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Database_GetNamespaces]
	@DatabaseId Int
As
BEGIN
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @DocHandle int,@ErrNo int

--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

BEGIN TRY
	SELECT [DatabaseId]=@DatabaseId, [n].[CGEN_NamespaceId], [n].[NamespaceName], [IsSelected]=CASE WHEN [dn].[CGEN_NamespaceId] Is Null THEN 'False' ELSE 'True' END 
	FROM [CGEN_Namespace] [n] WITH(NOLOCK)
	LEFT JOIN [CGEN_DatabaseNamespace] [dn] WITH(NOLOCK) ON [dn].[CGEN_MasterDatabaseId]=@DatabaseId AND [n].[CGEN_NamespaceId]=[dn].[CGEN_NamespaceId] 
	WHERE [n].[IsActive] = 'True'
END TRY
BEGIN CATCH
	
	DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)
	SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())
	SET @ProcName=OBJECT_NAME(@@ProcId)
	SELECT @ErrorInformation=Stuff((
		SELECT
		'EXEC ',
		@ProcName+ ' ',
			'@DatabaseId=', @DatabaseId
			FOR XML PATH ('')
			),1,0,'')
	EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation

END CATCH

END
GO

