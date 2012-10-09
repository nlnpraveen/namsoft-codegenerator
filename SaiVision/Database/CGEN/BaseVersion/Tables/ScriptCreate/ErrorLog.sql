USE [CodeGenerator]
GO

/****** Object:  Table [dbo].[ErrorLog]    Script Date: 09/04/2012 18:15:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ErrorLog](
	[ErrorGuid] [uniqueidentifier] NOT NULL,
	[ParentErrorGuid] [uniqueidentifier] NULL,
	[ErrorLogId] [int] IDENTITY(1,1) NOT NULL,
	[ParentErrorLogId] [int] NULL,
	[ErrorProcedure] [nvarchar](500) NULL,
	[ErrorLine] [nvarchar](100) NULL,
	[ErrorNumber] [nvarchar](100) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[ErrorSeverity] [nvarchar](100) NULL,
	[ErrorState] [nvarchar](100) NULL,
	[ErrorDate] [datetime] NOT NULL,
	[ErrorInformation] [nvarchar](max) NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[ErrorGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_ErrorGuid]  DEFAULT (newsequentialid()) FOR [ErrorGuid]
GO

ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_DatabaseExceptionLog_ErrorDate]  DEFAULT (getdate()) FOR [ErrorDate]
GO


