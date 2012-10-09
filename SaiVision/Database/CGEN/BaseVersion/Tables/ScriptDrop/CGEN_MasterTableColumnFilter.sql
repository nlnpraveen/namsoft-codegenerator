USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTableColumnFilter_CGEN_MasterTableColumn]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]'))
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTableColumn]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTableColumnFilter_CGEN_MasterTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]'))
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTable]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsActive]
END

GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTableColumnFilter]    Script Date: 08/03/2012 02:32:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTableColumnFilter]
GO

