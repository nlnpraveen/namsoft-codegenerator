USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTable]    Script Date: 08/04/2012 01:21:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_MasterTable](
	[CGEN_MasterTableId] [int] IDENTITY(1,1) NOT NULL,
	[CGEN_MasterDatabaseId] [int] NOT NULL,
	[SchemaName] [nvarchar](128) NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[TableNamePascal] [nvarchar](128) NULL,
	[TableNameCamel] [nvarchar](128) NULL,
	[PrimaryKeyColumnName] [nvarchar](2000) NULL,
	[IsSelect] [bit] NOT NULL,
	[IsInsert] [bit] NOT NULL,
	[IsInsertBulk] [bit] NOT NULL,
	[IsUpdateBulk] [bit] NOT NULL,
	[IsDeleteBulk] [bit] NOT NULL,
	[IsSelectByPK] [bit] NOT NULL,
	[IsUpdateByPK] [bit] NOT NULL,
	[IsDeleteByPK] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsCompositePrimaryKey] [bit] NOT NULL,
	[IsTruncatePrefix_Table] [bit] NOT NULL,
	[PrefixToTruncate_Table] [nvarchar](128) NULL,
	[PrefixToApply_Table] [nvarchar](128) NULL,
	[IsTruncatePrefix_Column] [bit] NULL,
	[PrefixToTruncate_Column] [nvarchar](128) NULL,
	[PrefixToApply_Column] [nchar](10) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CGEN_MasterTable] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CGEN_MasterTable]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTable_CGEN_MasterDatabase] FOREIGN KEY([CGEN_MasterDatabaseId])
REFERENCES [dbo].[CGEN_MasterDatabase] ([CGEN_MasterDatabaseId])
GO

ALTER TABLE [dbo].[CGEN_MasterTable] CHECK CONSTRAINT [FK_CGEN_MasterTable_CGEN_MasterDatabase]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsSelect]  DEFAULT ((0)) FOR [IsSelect]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_Master_IsInsert]  DEFAULT ((0)) FOR [IsInsert]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF__CGEN_Mast__IsIns__2942188C]  DEFAULT ((0)) FOR [IsInsertBulk]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF__CGEN_Mast__IsUpd__39788055]  DEFAULT ((0)) FOR [IsUpdateBulk]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF__CGEN_Mast__IsDel__3A6CA48E]  DEFAULT ((0)) FOR [IsDeleteBulk]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]  DEFAULT ((0)) FOR [IsSelectByPK]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]  DEFAULT ((0)) FOR [IsUpdateByPK]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsDelete]  DEFAULT ((0)) FOR [IsDeleteByPK]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsCompositePrimaryKey]  DEFAULT ((0)) FOR [IsCompositePrimaryKey]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_Master_IsChangePrefix]  DEFAULT ((0)) FOR [IsTruncatePrefix_Table]
GO

ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

