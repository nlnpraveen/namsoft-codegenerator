USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_DatabaseNamespace]    Script Date: 06/17/2013 14:57:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_DatabaseNamespace](
	[CGEN_MasterDatabaseId] [int] NOT NULL,
	[CGEN_NamespaceId] [int] NOT NULL,
 CONSTRAINT [PK_CGEN_DatabaseNamespace] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterDatabaseId] ASC,
	[CGEN_NamespaceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CGEN_DatabaseNamespace]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_MasterDatabase] FOREIGN KEY([CGEN_MasterDatabaseId])
REFERENCES [dbo].[CGEN_MasterDatabase] ([CGEN_MasterDatabaseId])
GO

ALTER TABLE [dbo].[CGEN_DatabaseNamespace] CHECK CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_MasterDatabase]
GO

ALTER TABLE [dbo].[CGEN_DatabaseNamespace]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_Namespace] FOREIGN KEY([CGEN_NamespaceId])
REFERENCES [dbo].[CGEN_Namespace] ([CGEN_NamespaceId])
GO

ALTER TABLE [dbo].[CGEN_DatabaseNamespace] CHECK CONSTRAINT [FK_CGEN_DatabaseNamespace_CGEN_Namespace]
GO


