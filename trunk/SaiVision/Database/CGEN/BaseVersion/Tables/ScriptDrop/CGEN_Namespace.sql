USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_Namespace_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_Namespace] DROP CONSTRAINT [DF_CGEN_Namespace_IsActive]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[UNQ_CGEN_Namespace_NamespaceName]') AND type = 'UQ')
BEGIN
ALTER TABLE [dbo].[CGEN_Namespace] DROP CONSTRAINT [UNQ_CGEN_Namespace_Namespace]
END

GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_Namespace]    Script Date: 06/17/2013 14:58:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Namespace]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_Namespace]
GO


