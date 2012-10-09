USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterTableColumn]    Script Date: 08/03/2012 02:01:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_MasterTableColumn](
	[CGEN_MasterTableColumnId] [int] IDENTITY(1,1) NOT NULL,
	[CGEN_MasterTableId] [int] NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[ColumnName] [nvarchar](128) NOT NULL,
	[ColumnNamePascal] NVarChar(128) Null,
	[ColumnNameCamel] NVarChar(128) Null,
	[NumericPrecision] tinyint Null,
	[NumericScale] int Null,
	[CharacterMaximumLength] int Null,
	[ColumnDefault] NVarChar(128) Null,
	[ColumnOrder] [int] Not Null,
	[IsNullable] VarChar(3) Not Null,
	[DataType] NVarChar(128) Not Null,
	[IsIdentity] Bit Not Null,
	[IsPrimaryKey] Bit Not Null,
	[IsTruncatePrefix] [bit] NULL,
	[PrefixToTruncate] [nvarchar](128) NULL,
	[PrefixToApply] [nchar](10) NULL,
 CONSTRAINT [PK_CGEN_MasterTableColumn] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableColumnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CGEN_MasterTableColumn]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTableColumn_CGEN_MasterTable] FOREIGN KEY([CGEN_MasterTableId])
GO


