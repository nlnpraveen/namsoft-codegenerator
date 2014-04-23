USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_Namespace]    Script Date: 06/17/2013 14:55:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CGEN_Namespace](
	[CGEN_NamespaceId] [int] IDENTITY(1,1) NOT NULL,
	[NamespaceName] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CGEN_Namespace] PRIMARY KEY CLUSTERED 
(
	[CGEN_NamespaceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[CGEN_Namespace] ADD  CONSTRAINT [DF_CGEN_Namespace_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[CGEN_Namespace] ADD  CONSTRAINT [UNQ_CGEN_Namespace_NamespaceName]  UNIQUE NONCLUSTERED ([NamespaceName])
GO


