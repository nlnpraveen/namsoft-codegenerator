USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[CGEN_MasterDatabase]    Script Date: 08/04/2012 01:17:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_MasterDatabase](
	[CGEN_MasterDatabaseId] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_CGEN_MasterDatabase] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterDatabaseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


