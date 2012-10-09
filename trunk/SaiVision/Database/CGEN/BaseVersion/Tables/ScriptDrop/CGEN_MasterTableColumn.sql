USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnPrefixOverride_IsTruncatePrefix]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumn] DROP CONSTRAINT [DF_CGEN_MasterTableColumnPrefixOverride_IsTruncatePrefix]
END

GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTableColumn_CGEN_MasterTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumn]'))
ALTER TABLE [dbo].[CGEN_MasterTableColumn] DROP CONSTRAINT [FK_CGEN_MasterTableColumn_CGEN_MasterTable]
GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTableColumn]    Script Date: 08/07/2012 17:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumn]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTableColumn]
GO

