USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ErrorLog_ErrorGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [DF_ErrorLog_ErrorGuid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DatabaseExceptionLog_ErrorDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [DF_DatabaseExceptionLog_ErrorDate]
END

GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[ErrorLog]    Script Date: 09/04/2012 18:16:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorLog]') AND type in (N'U'))
DROP TABLE [dbo].[ErrorLog]
GO


