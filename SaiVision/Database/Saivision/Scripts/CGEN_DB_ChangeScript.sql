USE [SaiVision]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [IsInsertBulk] Bit Not Null Default(0)
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [IsUpdateBulk] Bit Not Null Default(0)
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [IsDeleteBulk] Bit Not Null Default(0)