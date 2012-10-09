USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTableColumnFilter]    Script Date: 08/03/2012 02:13:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_MasterTableColumnFilter](
	[CGEN_MasterTableColumnFilterId] [int] IDENTITY(1,1) NOT NULL,
	[CGEN_MasterTableId] [int] NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[IsSelectByColumns] [bit] NOT NULL,
	[IsUpdateByColumns] [bit] NOT NULL,
	[IsDeleteByColumns] [bit] NOT NULL,
	[ColumnNames] [nvarchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CGEN_MasterTableColumnOperation] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableColumnFilterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTable] FOREIGN KEY([CGEN_MasterTableId])
REFERENCES [dbo].[CGEN_MasterTable] ([CGEN_MasterTableId])
GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] CHECK CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTable]
GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] ADD  CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]  DEFAULT ((0)) FOR [IsSelectByColumns]
GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] ADD  CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]  DEFAULT ((0)) FOR [IsUpdateByColumns]
GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] ADD  CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]  DEFAULT ((0)) FOR [IsDeleteByColumns]
GO

ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] ADD  CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO


