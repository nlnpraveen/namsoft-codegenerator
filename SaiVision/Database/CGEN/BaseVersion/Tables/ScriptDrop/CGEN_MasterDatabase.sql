USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterDatabase]    Script Date: 08/04/2012 01:17:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterDatabase]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterDatabase]
GO


