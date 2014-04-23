USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_DatabaseNamespace_CGEN_MasterDatabase]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_DatabaseNamespace]'))
ALTER TABLE [dbo].[CGEN_DatabaseNamespace] DROP CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_MasterDatabase]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_DatabaseNamespace_CGEN_Namespace]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_DatabaseNamespace]'))
ALTER TABLE [dbo].[CGEN_DatabaseNamespace] DROP CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_Namespace]
GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_DatabaseNamespace]    Script Date: 06/17/2013 14:57:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_DatabaseNamespace]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_DatabaseNamespace]
GO


