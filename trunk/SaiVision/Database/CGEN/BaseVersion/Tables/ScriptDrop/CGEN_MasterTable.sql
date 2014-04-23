USE [CodeGenerator]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTable_CGEN_MasterDatabase]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTable]'))
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [FK_CGEN_MasterTable_CGEN_MasterDatabase]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_SchemaName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_SchemaName]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsSelect]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsSelect]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_Master_IsInsert]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_Master_IsInsert]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsIns__2942188C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsIns__2942188C]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsUpd__39788055]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsUpd__39788055]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsDel__3A6CA48E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsDel__3A6CA48E]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsSelectByPK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsUpdateByPK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsActive]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsCompositePrimaryKey]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsCompositePrimaryKey]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_Master_IsChangePrefix]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_Master_IsChangePrefix]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_CreateDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsGenerateCode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsGenerateCode]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsGenerateCodeAlways]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsGenerateCodeAlways]
END

GO

USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTable]    Script Date: 06/18/2013 16:00:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTable]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTable]
GO

