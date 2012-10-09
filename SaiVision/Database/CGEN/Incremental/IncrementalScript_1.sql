USE [CodeGenerator]
GO

/************* Tables ******************/

/************* BEGIN [CGEN_MasterTable] ******************/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CGEN_MasterDatabase](
	[CGEN_MasterDatabaseId] [int] NOT NULL,
	[DatabaseName] [nvarchar](128) NOT NULL
 CONSTRAINT [PK_CGEN_MasterDatabase] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterDatabaseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CGEN_MasterDatabase] ADD [LastSyncDate] [datetime] Null
GO
/************* END [CGEN_MasterTable] ******************/


/************* BEGIN [CGEN_MasterTable] ******************/
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [CGEN_MasterDatabaseId] Int Not Null
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [SchemaName] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [TableNamePascal] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [TableNameCamel] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [PrimaryKeyColumnName] NVarChar(2000) Null
ALTER TABLE [dbo].[CGEN_MasterTable] ADD [IsGenerateCode] Bit Null
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTable_CGEN_MasterDatabase] FOREIGN KEY([CGEN_MasterDatabaseId])
REFERENCES [dbo].CGEN_MasterDatabase ([CGEN_MasterDatabaseId])
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_SchemaName]  DEFAULT (N'dbo') FOR [SchemaName]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsGenerateCode]  DEFAULT ((0)) FOR [IsGenerateCode]
GO
UPDATE [CGEN_MasterTable] SET [IsGenerateCode]='False'
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ALTER COLUMN [IsGenerateCode] Bit Not Null
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ALTER COLUMN [TableNamePascal] NVarChar(128) Null
ALTER TABLE [dbo].[CGEN_MasterTable] ALTER COLUMN [TableNameCamel] NVarChar(128) Null
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_MasterTable_IsSelect]  
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_Master_IsInsert] 
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsSelect]  DEFAULT ((0)) FOR [IsSelect]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_Master_IsInsert]  DEFAULT ((0)) FOR [IsInsert]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_MasterTable_IsDelete]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]  DEFAULT ((0)) FOR [IsSelectByPK]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]  DEFAULT ((0)) FOR [IsUpdateByPK]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] ADD  CONSTRAINT [DF_CGEN_MasterTable_IsDelete]  DEFAULT ((0)) FOR [IsDeleteByPK]
GO
ALTER TABLE [dbo].[CGEN_MasterTable] DROP  CONSTRAINT [DF_CGEN_MasterTable_IsTruncatePrefix_Column]
GO
/************* END [CGEN_MasterTable] ******************/

/************* BEGIN [CGEN_MasterTableColumn] ******************/
sp_RENAME 'CGEN_MasterTableColumnPrefixOverride' , 'CGEN_MasterTableColumn'
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [CGEN_MasterTableColumnId] Int IDENTITY(1,1) NOT NULL
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] DROP CONSTRAINT [PK_CGEN_MasterTableColumnPrefixOverride]
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn]  ADD  CONSTRAINT [PK_CGEN_MasterTableColumn] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableColumnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [ColumnNamePascal] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [ColumnNameCamel] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [ColumnDefault] NVarChar(128) Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [IsNullable] VarChar(3) Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [DataType] NVarChar(128) Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [IsIdentity] Bit Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [IsPrimaryKey] Bit Not Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [NumericPrecision] TinyInt Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [NumericScale] Int Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [CharacterMaximumLength] Int Null
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [CGEN_MasterTableId] Int Not Null
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ALTER COLUMN [IsTruncatePrefix] Bit Null
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ALTER COLUMN [ColumnNamePascal] NVarChar(128) Null
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ALTER COLUMN [ColumnNameCamel] NVarChar(128) Null
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn] ADD [ColumnOrder] Int Null
GO


IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTableColumn_CGEN_MasterTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumn]'))
ALTER TABLE [dbo].[CGEN_MasterTableColumn] DROP CONSTRAINT [FK_CGEN_MasterTableColumn_CGEN_MasterTable]
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumn]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTableColumn_CGEN_MasterTable] FOREIGN KEY([CGEN_MasterTableId])
REFERENCES [dbo].[CGEN_MasterTable] ([CGEN_MasterTableId])
GO
/************* END [CGEN_MasterTableColumn] ******************/

/************* BEGIN [CGEN_MasterTableColumnFilter] ******************/
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] ADD [CGEN_MasterTableColumnId] Int Not Null
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CGEN_MasterTableColumnFilter_CGEN_MasterTableColumn]') AND parent_object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]'))
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTableColumn]
GO
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter]  WITH CHECK ADD  CONSTRAINT [FK_CGEN_MasterTableColumnFilter_CGEN_MasterTable] FOREIGN KEY([CGEN_MasterTableId])
REFERENCES [dbo].[CGEN_MasterTable] ([CGEN_MasterTableId])
GO
--ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP COLUMN [ColumnNames]
--GO
/************* END [CGEN_MasterTableColumnFilter] ******************/

/************* End Tables ******************/

/************* Stored Procedures ******************/
USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsIdentityColumn]    Script Date: 08/10/2012 17:12:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsIdentityColumn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsIdentityColumn]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsIdentityColumn]    Script Date: 08/10/2012 17:12:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CGEN_fnIsIdentityColumn]
( 
	@TableName nvarchar(128), @ColumnName nvarchar(128)    
)  
RETURNS Bit

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Returns true if it is an identity 
--				  column
-- =============================================

BEGIN
	DECLARE @IsIdentityColumn Bit
	
	SELECT @IsIdentityColumn=COLUMNPROPERTY(OBJECT_ID(@TableName), @ColumnName, 'IsIdentity')

	RETURN @IsIdentityColumn
END

GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 08/10/2012 17:13:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToCamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToCamelCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 08/10/2012 17:13:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CGEN_fnToCamelCase]
	(@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.07
-- Description:   Commented the use of LOWER(@Prefix)
--				  and lower only the first letter instead on the prefix to apply
--				  For Debug purposes
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API', @PrefixToApply='Apicell'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION', @PrefixToApply='Api'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedID', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION_NotificationFeed', @PrefixToApply='ApiNotificationFeed'
-- =============================================

BEGIN
	DECLARE @CamelStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	
	-- Check Emptiness
	IF @Input='_'
		RETURN ''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @CamelStr = ''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps='True' AND LEN(@Input) > 0
	BEGIN
		SET @CamelStr=[dbo].[CGEN_fnToCamelCase](LOWER(@Input), 0, '', '')		
		RETURN @CamelStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, '_')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+1, LEN(@Input)-LEN(@Prefix))
		IF @PrefixToApply Is Not Null AND LEN(@PrefixToApply) > 0
			SET @CamelStr=LOWER(SUBSTRING(@Prefix,1,1)) + SUBSTRING(@Prefix,2,LEN(@Prefix))
		ELSE
			SET @CamelStr=LOWER(@Prefix) -- Previously only this condition was present
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 2
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@CamelStr = @CamelStr + 
					CASE WHEN @Chr='_' THEN '' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr='_' THEN 1 ELSE 0 END, @Index = @Index + 1       
		
	END
	
	RETURN @CamelStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @CamelStr = @CamelStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE '[a-zA-Z]' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END

GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCase]    Script Date: 08/10/2012 17:13:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToPascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToPascalCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCase]    Script Date: 08/10/2012 17:13:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CGEN_fnToPascalCase]
	(@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.07
-- Description:   Commented the use of [CGEN_fnToPascalCaseStrict]
--				  and upper only the first letter instead on the prefix to apply
--				  For Debug purposes
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API', @PrefixToApply='Apicell'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedId', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION', @PrefixToApply='Api'
					--SELECT @Input='API_NOTIFICATION_NotificationFeedID', @IsTruncatePrefix='True', @PrefixToTruncate='API_NOTIFICATION_NotificationFeed', @PrefixToApply='ApiNotificationFeed'
-- =============================================

BEGIN
	DECLARE @PascalStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	-- Check Emptiness
	IF @Input='_'
		RETURN ''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @PascalStr = ''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps='True' AND LEN(@Input) > 0
	BEGIN
		SET @PascalStr=[dbo].[CGEN_fnToPascalCase](LOWER(@Input), 0, '', '')		
		RETURN @PascalStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, '_')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+2, LEN(@Input)-LEN(@Prefix))
		--SET @PascalStr=[dbo].[CGEN_fnToPascalCaseStrict](LOWER(@Prefix))		
		IF @PrefixToApply Is Not Null AND LEN(@PrefixToApply) > 0				
			SET @PascalStr=UPPER(SUBSTRING(@Prefix,1,1)) + SUBSTRING(@Prefix,2,LEN(@Prefix))
		ELSE
			SET @PascalStr=[dbo].[CGEN_fnToPascalCaseStrict](LOWER(@Prefix))
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 1
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@PascalStr = @PascalStr + 
					CASE WHEN @Chr='_' THEN '' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr='_' THEN 1 ELSE 0 END, @Index = @Index + 1
        
        -- For Two Letter Words
        IF @Index=2 AND @StrLen=2
        BEGIN
			SET @Reset=2	 			
		END
		
	END
	
	RETURN @PascalStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @PascalStr = @PascalStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE '[a-zA-Z]' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END


GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 08/15/2012 14:55:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_SelectMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 08/15/2012 14:55:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		01-26-2009
-- Description:		Select all the Nams database metadata
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.02.05
-- Description:		Composite Keys
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.23
-- Description:		Insert, Update, Delete bulk functionality
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.15
-- Description:		Move cgen metadata to its own database
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON


SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [TableName] ORDER BY [TableName]), *
	,[SelectProc]=CASE [mt].[IsSelect] WHEN 'True' THEN [mt].[TableNamePascal]+'_Get' ELSE Null END 
	,[SelectByPKProc]=CASE [mt].[IsSelectByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[UpdateByPKProc]=CASE [mt].[IsUpdateByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[DeleteByPKProc]=CASE [mt].[IsDeleteByPK] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+REPLACE([PrimaryKeyPascal],',','_') ELSE Null END 
	,[InsertBulkProc]=CASE [mt].[IsInsertBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_InsertBulk' ELSE Null END 
	,[UpdateBulkProc]=CASE [mt].[IsUpdateBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBulk' ELSE Null END 
	,[DeleteBulkProc]=CASE [mt].[IsDeleteBulk] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBulk' ELSE Null END 
	,[SelectByColumnsProc]=CASE [mt].[IsSelectByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_GetBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[UpdateByColumnsProc]=CASE [mt].[IsUpdateByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_UpdateBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
	,[DeleteByColumnsProc]=CASE [mt].[IsDeleteByColumns] WHEN 'True' THEN [mt].[TableNamePascal]+'_DeleteBy_'+Replace([QueryColumnsPascal], ',', '_') ELSE Null END 
FROM (
	SELECT [mt].[TableName]
		  ,[TableNamePascal]=IsNull([mt].[TableNamePascal], [dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
		  ,[TableNameCamel]=IsNull([mt].[TableNameCamel], [dbo].[CGEN_fnToCamelCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
		,[mt].[IsSelect]
		,[mt].[IsInsert]
		,[mt].[IsInsertBulk]
		,[mt].[IsUpdateBulk]
		,[mt].[IsDeleteBulk]
		,[mt].[IsSelectByPK]
		,[mt].[IsUpdateByPK]
		,[mt].[IsDeleteByPK]
		,[mtc].[IsSelectByColumns]
		,[mtc].[IsUpdateByColumns]
		,[mtc].[IsDeleteByColumns]
		,[PrimaryKey]=dbo.[CGEN_fnGetPrimaryKeyColumn]([mt].[TableName])
		,[PrimaryKeyPascal]=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[TableName])
		,[PrimaryKeyCamel]=dbo.[CGEN_fnGetPrimaryKeyColumn_CamelCase]([mt].[TableName])
		,[QueryColumns]=[ColumnNames]
		  ,[QueryColumnsPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[TableName], [mtc].[ColumnNames])
		  ,[QueryColumnsCamel]=[dbo].[CGEN_fnGetColumnNames_CamelCase]([mt].[TableName], [mtc].[ColumnNames])
	FROM [CGEN_MasterTable] [mt] WITH(NOLOCK)
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]='True' AND [mt].[TableName]=[mtc].[TableName]
	WHERE [mt].[IsActive]='True'
) [mt]


SELECT TABLE_CATALOG=[db].[DatabaseName], TABLE_SCHEMA=[t].[SchemaName], [t].[TableName], [c].[ColumnName]
	,[ColumnNamePascal]=IsNull([c].[ColumnNamePascal], [dbo].CGEN_fnToPascalCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[ColumnNameCamel]=IsNull([c].[ColumnNameCamel], [dbo].CGEN_fnToCamelCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[c].[ColumnDefault], [c].[IsNullable], [c].[DataType] , [c].[IsIdentity]
FROM [CGEN_MasterTableColumn] [c]
JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
JOIN [CGEN_MasterDatabase] [db] ON [db].[CGEN_MasterDatabaseId]=[t].[CGEN_MasterDatabaseId]


SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]    Script Date: 08/17/2012 12:29:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]
GO

USE [CodeGenerator]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]    Script Date: 03/12/2012 17:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns the primary key column name
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.17
-- Description:   Read from the column table
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]
( 
	@CGEN_MasterTableId Int--, @TableName nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	 DECLARE @PKColumnName NVarChar(128)

	-----------------------------
	SELECT @PKColumnName=COALESCE(@PKColumnName+',', '') + IsNull([c].[ColumnNameCamel], [dbo].CGEN_fnToCamelCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	FROM 
	[CGEN_MasterTable] [t] WITH(NOLOCK)
	JOIN [CGEN_MasterTableColumn] [c] WITH(NOLOCK) ON [t].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	WHERE [c].[IsPrimaryKey]='True'
	
	RETURN @PKColumnName
	-----------------------------

END


USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]    Script Date: 08/16/2012 18:34:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]    Script Date: 08/16/2012 18:34:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns the primary key column name
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.17
-- Description:   Read from the column table
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]
( 
	@CGEN_MasterTableId Int--, @TableName nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 
	 DECLARE @PKColumnName NVarChar(128)

	-----------------------------
	SELECT @PKColumnName=COALESCE(@PKColumnName+',', '') + IsNull([c].[ColumnNamePascal], [dbo].CGEN_fnToPascalCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	FROM 
	[CGEN_MasterTable] [t] WITH(NOLOCK)
	JOIN [CGEN_MasterTableColumn] [c] WITH(NOLOCK) ON [t].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	WHERE [c].[IsPrimaryKey]='True'
	
	RETURN @PKColumnName
	-----------------------------

END
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_PascalCase]    Script Date: 08/18/2012 00:00:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnNames_PascalCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_PascalCase]    Script Date: 08/18/2012 00:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns comma delimited pascal case names
--				  Input: Column Names in a table (comma delimited)
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.17
-- Description:   Read from the column table
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetColumnNames_PascalCase]
( 
	@CGEN_MasterTableId Int, @ColumnNames nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))
	DECLARE @ckPredicates nVarChar(MAX)

	IF @ColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, ',')
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + ',', '') + [dbo].CGEN_fnToPascalCase(ct.[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM [CGEN_MasterTable] [t]
		JOIN [CGEN_MasterTableColumn] [c] ON [t].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[CGEN_MasterTableId]=[c].[CGEN_MasterTableId]		
		JOIN @ckColumnsTable [ct] ON [ct].[ColumnName]=[c].[ColumnName]
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_CamelCase]    Script Date: 08/18/2012 00:19:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnNames_CamelCase]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_CamelCase]    Script Date: 08/18/2012 00:19:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns comma delimited camel case names
--				  Input: Column Names in a table (comma delimited)
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2012.02.05
-- Description:		Composite Keys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.17
-- Description:   Read from the column table
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetColumnNames_CamelCase]
( 
	@CGEN_MasterTableId Int, @ColumnNames nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))
	DECLARE @ckPredicates nVarChar(MAX)

	IF @ColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, ',')
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + ',', '') + [dbo].CGEN_fnToCamelCase(ct.[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM [CGEN_MasterTable] [t]
		JOIN [CGEN_MasterTableColumn] [c] ON [t].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[CGEN_MasterTableId]=[c].[CGEN_MasterTableId]		
		JOIN @ckColumnsTable [ct] ON [ct].[ColumnName]=[c].[ColumnName]
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 08/24/2012 17:44:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScript]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScript]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 08/24/2012 17:44:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates Select, Insert, Update and Delete scripts for a table
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Master Table Configuration
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.05
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.13
-- Description:   IsInsert
-- =============================================  
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.06.21
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle bulk update, bulk delete
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.15
-- Description:		Move cgen metadata to its own database
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.08.20
-- Description:		Pass @MasterTableId
-- =============================================


CREATE PROCEDURE [dbo].[CGEN_GenerateScript]     
	@IsDropOnly Bit='False'
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @SelectByPKProcName VarChar(200), @SelectByColumnsProcName VarChar(200), @UpdateByColumnsProcName VarChar(200), @DeleteByColumnsProcName VarChar(200)
DECLARE @SelectProcName VarChar(200), @InsertProcName VarChar(200), @InsertBulkProcName VarChar(200), @UpdateBulkProcName VarChar(200), @DeleteBulkProcName VarChar(200)
	,@UpdateByPKProcName VarChar(200), @DeleteByPKProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
DECLARE @PrimaryKeyColumnName NVarChar(128), @PrimaryKeyColumnNamePascal NVarChar(128)
DECLARE @ColumnName VarChar(128), @ConstraintName VarChar(128)

DECLARE @CGEN_MasterTableId Int, @DatabaseName nvarchar(128), @TableName nvarchar(128), @TableNamePascal nvarchar(128), @IsSelect Bit, @IsInsert Bit, 
	@IsInsertBulk Bit, @IsUpdateBulk Bit, @IsDeleteBulk Bit, @IsSelectByPK Bit, @IsUpdateByPK Bit, @IsDeleteByPK Bit,
	@IsSelectByColumns Bit, @IsUpdateByColumns Bit, @IsDeleteByColumns Bit, @ColumnNames NVarChar(128), @ColumnNamesPascal NVarChar(128), @RowId Int

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterTableEntries]'))AND([type] = 'U')) )	
	DROP TABLE #MasterTableEntries


SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [mt].[TableName] ORDER BY [mt].[TableName])
	  ,[mt].[CGEN_MasterTableId]
	  ,[d].[DatabaseName]
      ,[mt].[TableName]
		  ,[TableNamePascal]=IsNull([mt].[TableNamePascal], [dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table]))
      ,[PrimaryKeyColumnName]
      ,[PrimaryKeyColumnNamePascal]=[dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[CGEN_MasterTableId])
      ,[mt].[IsSelect]
      ,[mt].[IsInsert]
      ,[mt].[IsInsertBulk]
      ,[mt].[IsUpdateBulk]
      ,[mt].[IsDeleteBulk]
      ,[mt].[IsSelectByPK]
      ,[mt].[IsUpdateByPK]
      ,[mt].[IsDeleteByPK]
      ,[mtc].[IsSelectByColumns]
      ,[mtc].[IsUpdateByColumns]
      ,[mtc].[IsDeleteByColumns]
      ,[mtc].[ColumnNames]
      ,[ColumnNamesPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[CGEN_MasterTableId], [mtc].[ColumnNames])
INTO [#MasterTableEntries]      
FROM [dbo].[CGEN_MasterTable] [mt] WITH(NOLOCK)
	JOIN [CGEN_MasterDatabase] [d] WITH(NOLOCK) ON [mt].[CGEN_MasterDatabaseId]=[d].[CGEN_MasterDatabaseId] 
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]='True' AND [mt].[CGEN_MasterTableId]=[mtc].[CGEN_MasterTableId]
	WHERE [mt].[IsActive]='True'

WHILE EXISTS(SELECT 'X' FROM [#MasterTableEntries])
BEGIN

	SELECT @CGEN_MasterTableId=Null, @TableNamePascal=Null, @DatabaseName=Null, @TableName=Null ,@IsSelect=Null, @IsInsert=Null ,@IsSelectByPK=Null 
		,@IsInsertBulk=Null, @IsUpdateBulk=Null, @IsDeleteBulk=Null, @IsUpdateByPK=Null ,@IsDeleteByPK=Null  ,@IsSelectByColumns=Null ,@IsUpdateByColumns=Null ,@IsDeleteByColumns=Null
		,@ColumnNames=Null, @ColumnNamesPascal=Null, @RowId=Null


	SELECT TOP 1 @CGEN_MasterTableId=[CGEN_MasterTableId], @DatabaseName=[DatabaseName], @TableNamePascal=[TableNamePascal], @TableName=[TableName],@PrimaryKeyColumnName=[PrimaryKeyColumnName],@PrimaryKeyColumnNamePascal=[PrimaryKeyColumnNamePascal],@IsSelect=[IsSelect], @IsInsert=[IsInsert] 
		,@IsInsertBulk=[IsInsertBulk], @IsUpdateBulk=[IsUpdateBulk], @IsDeleteBulk=[IsDeleteBulk], @IsSelectByPK=[IsSelectByPK] 
		,@IsUpdateByPK=[IsUpdateByPK] ,@IsDeleteByPK=[IsDeleteByPK]  ,@IsSelectByColumns=[IsSelectByColumns] ,@IsUpdateByColumns=[IsUpdateByColumns] ,@IsDeleteByColumns=[IsDeleteByColumns]
		,@ColumnNames=[ColumnNames], @ColumnNamesPascal=[ColumnNamesPascal], @RowId=[RowId]
	FROM [#MasterTableEntries]
	
		--Not Required
		--SELECT @PrimaryKeyColumnNamePascal=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase](@TableName)
		SELECT @SelectProcName = @TableNamePascal+'_Get'
			,@SelectByPKProcName = @TableNamePascal+'_GetBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
			,@InsertProcName = @TableNamePascal+'_Insert', @InsertBulkProcName = @TableNamePascal+'_InsertBulk'
			, @UpdateBulkProcName = @TableNamePascal+'_UpdateBulk', @DeleteBulkProcName = @TableNamePascal+'_DeleteBulk'
			,@UpdateByPKProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
			,@DeleteByPKProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@PrimaryKeyColumnNamePascal,',','_')
		SELECT @SelectByColumnsProcName = @TableNamePascal+'_GetBy_'+REPLACE(@ColumnNamesPascal,',','_')
			,@UpdateByColumnsProcName = @TableNamePascal+'_UpdateBy_'+REPLACE(@ColumnNamesPascal,',','_')
			,@DeleteByColumnsProcName = @TableNamePascal+'_DeleteBy_'+REPLACE(@ColumnNamesPascal,',','_')
		
		--PRINT @TableName
		
		IF @IsSelect='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectProcName, 'Select', @IsDropOnly
		IF @IsSelectByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectByPKProcName, 'SelectByPK', @IsDropOnly
		IF @IsUpdateByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateByPKProcName, 'UpdateByPK', @IsDropOnly
		IF @IsDeleteByPK='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteByPKProcName, 'DeleteByPK', @IsDropOnly		
		IF @IsInsert='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @InsertProcName, 'Insert', @IsDropOnly
		IF @IsInsertBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @InsertBulkProcName, 'InsertBulk', @IsDropOnly
		IF @IsUpdateBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateBulkProcName, 'UpdateBulk', @IsDropOnly
		IF @IsDeleteBulk='True' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteBulkProcName, 'DeleteBulk', @IsDropOnly
		
		IF @IsSelectByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @SelectByColumnsProcName, 'SelectByColumns', @IsDropOnly, @ColumnNames
		IF @IsUpdateByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @UpdateByColumnsProcName, 'UpdateByColumns', @IsDropOnly, @ColumnNames		
		IF @IsDeleteByColumns='True'
			EXEC [CGEN_GenerateScriptByActionType] @CGEN_MasterTableId, @DatabaseName, @TableName, @DeleteByColumnsProcName, 'DeleteByColumns', @IsDropOnly, @ColumnNames
		
		
		--SELECT PrimaryKeyColumnName=@PrimaryKeyColumnName, PrimaryKeyColumnNamePascal=@PrimaryKeyColumnNamePascal, SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectByColumnsProcName=@SelectByColumnsProcName, UpdateByColumnsProcName=@UpdateByColumnsProcName, DeleteByColumnsProcName=@DeleteByColumnsProcName
	DELETE TOP (1) [#MasterTableEntries]
END


RETURN 0
--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1

GO


USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 08/24/2012 17:44:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScriptByActionType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 08/24/2012 17:44:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates script for a table based on action type (available actions: Select, SelectByPK, UpdateByPK, DeleteByPK, Insert, InsertBulk, SelectByColumns, UpdateByColumns, DeleteByColumns)
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.10
-- Description:   Changes for InsertBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Pass proc name to body proc
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.19
-- Description:   Changes for UpdateBulk, DeleteBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  


CREATE PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
	@CGEN_MasterTableId Int,
	@DatabaseName nvarchar(128),
	@TableName nvarchar(128),	
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@IsOnlyDrop	bit,
	@fkColumnName nVarchar(128) = Null
	
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @ScriptText NVarChar(MAX)
DECLARE @SelectProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2), @dline char(2)
IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#SqlTable]'))AND([type] = 'U')) )	
	DROP TABLE #SqlTable
CREATE Table #SqlTable(Id Int Identity Primary Key, SqlStr VarChar(MAX))

DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

--SELECT @TableName=[TableName], @DatabaseName=[DatabaseName] FROM [CGEN_MasterTable] [t] WITH(NOLOCK) JOIN [CGEN_MasterDatabase] [d] WITH(NOLOCK) ON [t].[CGEN_MasterDatabaseId]=[d].[CGEN_MasterDatabaseId] WHERE [t].[CGEN_MasterTableId]=@TableId

SET		@cTAB = char(9)
SET		@Indent = '   '
SET 	@nline = char(13) + char(10)
SET 	@dline = char(10) + char(13)

Insert Into #SqlTable VALUES('/****************************************************************************************/' + @dline)

EXEC [dbo].[CGEN_GenerateProcDropStmt] @DatabaseName, @ProcName--
Insert Into #SqlTable VALUES(@dline)


IF @IsOnlyDrop = 0
BEGIN
	Insert Into #SqlTable VALUES('SET ANSI_NULLS ON' + @nline)	
	Insert Into #SqlTable VALUES('SET QUOTED_IDENTIFIER ON' + @nline)
	Insert Into #SqlTable VALUES('GO')
	Insert Into #SqlTable VALUES(@dline)

	EXEC [dbo].[CGEN_GenerateProcHeader] @TableName, @ActionType--
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcCreateStmt] @CGEN_MasterTableId, @TableName, @ProcName, @ActionType, @fkColumnName--
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('-- DECLARE' + @nline)
	
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('DECLARE @ErrNo int' + @nline)
	IF @ActionType IN ('InsertBulk', 'UpdateBulk', 'DeleteBulk')
		Insert Into #SqlTable VALUES('DECLARE @DocHandle int' + @nline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------' + @nline)
	Insert Into #SqlTable VALUES('-- PROCESSING' + @nline)
	Insert Into #SqlTable VALUES('--------------------------------------------------------------------------------')
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('SET NOCOUNT ON' + @nline)
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('BEGIN TRY' + @nline )
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcBodyStmt] @CGEN_MasterTableId, @ProcName, @TableName, @ActionType, @fkColumnName--
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES('END TRY' + @nline)
	Insert Into #SqlTable VALUES('BEGIN CATCH' + @nline)
	--SET @ScriptText = @ScriptText + @cTAB + 'EXEC CME360_DatabaseExceptionLog_Add' + @nline  -- new
	EXEC [dbo].[CGEN_GenerateProcErrorHandlerStmt] @CGEN_MasterTableId, @TableName, @ProcName, @ActionType, @fkColumnName
	Insert Into #SqlTable VALUES('END CATCH' + @nline)
	Insert Into #SqlTable VALUES(@dline)	
	Insert Into #SqlTable VALUES('GO')	
END

--SELECT * FROM #SqlTable
SELECT @SqlStr='', @SqlStrTemp=''
WHILE EXISTS(SELECT 'X' FROM #SqlTable)
BEGIN
	SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable
	
	IF LEN(@SqlStr) > 4000
	BEGIN
		PRINT @SqlStr
		SET @SqlStr = ''
	END
	SET @SqlStr = @SqlStr + @SqlStrTemp

	DELETE FROM #SqlTable WHERE Id=@Id
END	
PRINT @SqlStr

--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1



GO


USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcDropStmt]    Script Date: 08/24/2012 17:45:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcDropStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcDropStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcDropStmt]    Script Date: 08/24/2012 17:45:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the drop statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @DatabaseName
-- =============================================  
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcDropStmt]
(
	@DatabaseName nvarchar(128), 
	@ProcName NVarChar(200)
)  
As

BEGIN 

    DECLARE @DropStmt NVarChar(MAX), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	Insert Into #SqlTable VALUES('IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].['+@ProcName+']'') AND type in (N''P'', N''PC''))' + @nline)
	Insert Into #SqlTable VALUES(@cTAB+ 'DROP PROCEDURE dbo.['+@ProcName+']' + @nline)---
	Insert Into #SqlTable VALUES('GO')
	
	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr	
	*/	
END



GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 08/24/2012 17:45:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcCreateStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 08/24/2012 17:45:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.19
-- Description:   Date datatype should not be assigned a default value
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.20
-- Description:   Default value for small datetime
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Select/Delete by composite PK
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Update by columns
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.10
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle UpdateBulk, DeleteBulk
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
( 
	@CGEN_MasterTableId Int,
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  
AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNameDataTypes VarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength int,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable varchar(10),
	@col_DefaultVal nvarchar(4000)
	DECLARE @TableColumns TABLE
	(	ColumnName nvarchar(128), 
		DataType nvarchar(128), 
		NumericPrecision tinyint, 
		NumericScale int, 
		CharacterMaximumLength int, 
		IsNullable varchar(3), 
		ColumnDefault nvarchar(4000), 
		IsIdentity Bit
	)	

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId

	Insert Into #SqlTable VALUES('CREATE PROCEDURE [dbo].['+ @ProcName +']' + @nline)
	
	SELECT @ckColumnNames = COALESCE(@ckColumnNames, @PrimaryKeyColumnName)
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, ',')
	END

	IF @ActionType = 'Insert'
	BEGIN
		INSERT INTO  @TableColumns (ColumnName, DataType, NumericPrecision, NumericScale, CharacterMaximumLength, IsNullable, ColumnDefault, IsIdentity)		
		SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		WHILE EXISTS(SELECT 'X' FROM @TableColumns)
		BEGIN
		
			SELECT TOP 1 @col_ColumnName=[ColumnName], @col_TypeName=[DataType], @col_Precision=[NumericPrecision], @col_Scale=[NumericScale], 
			@col_MaxLength=[CharacterMaximumLength], @col_IsNullable=[IsNullable], @col_DefaultVal=[ColumnDefault], @col_IsIdentity=[IsIdentity]
			FROM @TableColumns
		
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX('%[()]%',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX('%[()]%', @col_DefaultVal), 1, '')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + CASE @col_TypeName WHEN 'uniqueidentifier' THEN @col_ColumnName + ' ' + 'nvarchar(100)' ELSE @col_ColumnName + ' ' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName='decimal' THEN '(' + CONVERT(VarChar, @col_Precision) + ', ' + CONVERT(VarChar, @col_Scale) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar', 'char', 'nchar') And @col_MaxLength <> -1 THEN '(' + CONVERT(VarChar, @col_MaxLength) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar') And @col_MaxLength = -1 THEN '(MAX)' 
					ELSE '' 
				END +
				CASE 
					WHEN @col_IsNullable='YES' AND( @col_DefaultVal Is Null Or PATINDEX('%getdate%', @col_DefaultVal) > 0) THEN ' = Null' 
					WHEN 
						@col_DefaultVal Is Not Null 
						AND 
							((@col_TypeName IN ('date', 'datetime', 'smalldatetime') AND PATINDEX('%getdate%', @col_DefaultVal)=0)
							Or 
							(@col_TypeName Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier')))
						THEN ' = ' + @col_DefaultVal
					ELSE '' 
				END +
				CASE 
				WHEN (@PrimaryKeyColumnName = @col_ColumnName AND (@col_IsIdentity = 1 Or @col_TypeName = 'uniqueidentifier')) THEN ' OUTPUT'
					ELSE ''
				END
				
			DELETE FROM @TableColumns WHERE [ColumnName]=@col_ColumnName
		END

--		SELECT @ColNameDataTypes = 
--			CASE 
--				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], 'IsIdentity') = '1') THEN
--					COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + col.[COLUMN_NAME] + ' ' + col.[DATA_TYPE] + 
--					CASE 
--						WHEN col.[DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, col.[numeric_precision]) + ', ' + CONVERT(VarChar, col.[numeric_scale]) + ')' 
--						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And col.character_maximum_length <> -1 THEN '(' + CONVERT(VarChar, col.character_maximum_length) + ')' 
--						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar') And col.character_maximum_length = -1 THEN '(MAX)' 
--						ELSE '' 
--					END +
--					CASE 
--						WHEN col.[IS_NULLABLE]='YES' AND col.[COLUMN_DEFAULT] Is Null THEN ' = Null' 
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN ('varchar', 'char', 'money') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN ('datetime', 'smalldatetime') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
--						ELSE '' 
--					END 
--				ELSE '--'
--			END
--		FROM INFORMATION_SCHEMA.COLUMNS col
--		WHERE TABLE_NAME = @TableName
		
		Insert Into #SqlTable VALUES(@ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType IN ('InsertBulk', 'UpdateBulk', 'DeleteBulk')
	BEGIN	
		SET @ColNameDataTypes = '@DataXml VarChar(MAX)'
		Insert Into #SqlTable VALUES(@cTAB + @ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType In ('UpdateByPK', 'UpdateByColumns') 
	BEGIN
		INSERT INTO  @TableColumns (ColumnName, DataType, NumericPrecision, NumericScale, CharacterMaximumLength, IsNullable, ColumnDefault, IsIdentity)		
		SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		WHILE EXISTS(SELECT 'X' FROM @TableColumns)
		BEGIN
		
			SELECT TOP 1 @col_ColumnName=[ColumnName], @col_TypeName=[DataType], @col_Precision=[NumericPrecision], @col_Scale=[NumericScale], 
			@col_MaxLength=[CharacterMaximumLength], @col_IsNullable=[IsNullable], @col_DefaultVal=[ColumnDefault], @col_IsIdentity=[IsIdentity]
			FROM @TableColumns
			
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX('%[()]%',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX('%[()]%', @col_DefaultVal), 1, '')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + ', ' + @nline, '') + @cTAB + '@' + CASE @col_TypeName WHEN 'uniqueidentifier' THEN @col_ColumnName + ' ' + 'nvarchar(100)' ELSE @col_ColumnName + ' ' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName='decimal' THEN '(' + CONVERT(VarChar, @col_Precision) + ', ' + CONVERT(VarChar, @col_Scale) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar', 'char', 'nchar') And @col_MaxLength <> -1 THEN '(' + CONVERT(VarChar, @col_MaxLength) + ')' 
					WHEN @col_TypeName IN ('varchar', 'nvarchar') And @col_MaxLength = -1 THEN '(MAX)' 
					ELSE '' 
				END +
				CASE 
					WHEN @col_IsNullable='YES' AND @col_DefaultVal Is Null THEN ' = Null' 
					WHEN @col_DefaultVal Is Not Null AND @col_TypeName Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + @col_DefaultVal
					ELSE '' 
				END 

			DELETE FROM @TableColumns WHERE [ColumnName]=@col_ColumnName
		END

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	/*
	ELSE IF @ActionType = 'DeleteByPK' Or @ActionType = 'SelectByPK'
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			CASE 
				WHEN (@PrimaryKeyColumnName = col.[COLUMN_NAME]) THEN
					@cTAB + '@' + col.[COLUMN_NAME] + ' ' + CASE col.[DATA_TYPE] WHEN 'uniqueidentifier' THEN 'nvarchar(100)' ELSE col.[DATA_TYPE] END + 
					CASE 
						WHEN col.[DATA_TYPE]='decimal' THEN '(' + CONVERT(VarChar, col.[numeric_precision]) + ', ' + CONVERT(VarChar, col.[numeric_scale]) + ')' 
						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar', 'char', 'nchar') And col.character_maximum_length <> -1 THEN '(' + CONVERT(VarChar, col.character_maximum_length) + ')' 
						WHEN col.[DATA_TYPE] IN ('varchar', 'nvarchar') And col.character_maximum_length = -1 THEN '(MAX)' 
						ELSE '' 
					END +
					CASE 
						WHEN col.[IS_NULLABLE]='YES' AND col.[COLUMN_DEFAULT] Is Null THEN ' = Null' 
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN ('varchar', 'char', 'money') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
						ELSE '' 
					END 
				ELSE ''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	*/
	ELSE IF @ActionType IN ('DeleteByColumns', 'SelectByColumns', 'DeleteByPK', 'SelectByPK')
	BEGIN
		
		SELECT @ColNameDataTypes = 
			COALESCE(@ColNameDataTypes + ', ' + @nline, '') + 
					@cTAB + '@' + [c].[ColumnName] + ' ' + CASE [c].[DataType] WHEN 'uniqueidentifier' THEN 'nvarchar(100)' ELSE [c].[DataType] END + 
					CASE 
						WHEN [c].[DataType]='decimal' THEN '(' + CONVERT(VarChar, [c].[NumericPrecision]) + ', ' + CONVERT(VarChar, [c].[NumericScale]) + ')' 
						WHEN [c].[DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [c].[CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [c].[CharacterMaximumLength]) + ')' 
						WHEN [c].[DataType] IN ('varchar', 'nvarchar') And [c].[CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END +
					CASE 
						WHEN [c].[IsNullable]='YES' AND [c].[ColumnDefault] Is Null THEN ' = Null' 
						WHEN [c].[ColumnDefault] Is Not Null AND [c].[DataType] IN ('varchar', 'char', 'money') THEN ' = ' + Substring([c].[ColumnDefault], 2, LEN([c].[ColumnDefault]) - 2)
						WHEN [c].[ColumnDefault] Is Not Null AND [c].[DataType] Not IN ('date', 'datetime', 'smalldatetime', 'uniqueidentifier') THEN ' = ' + Substring([c].[ColumnDefault], 3, LEN([c].[ColumnDefault]) - 4)
						ELSE '' 
					END
		
		--SELECT [c].[ColumnName], [c].[DataType], [c].[NumericPrecision], [c].[NumericScale], [c].[CharacterMaximumLength], [c].[IsNullable], [c].[ColumnDefault], [c].[IsIdentity]
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		WHERE [c].[ColumnName] IN (SELECT [ColumnName] FROM @ckColumnsTable)
		

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END

	Insert Into #SqlTable VALUES('As')

	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr
	*/	
END



GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 08/24/2012 17:46:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcBodyStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 08/24/2012 17:46:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Changes for InsertBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Pass proc name to body proc
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.19
-- Description:   Changes for UpdateBulk, DeleteBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  

CREATE PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
( 
	@CGEN_MasterTableId Int,
	@ProcName NVarChar(200),
	@TableName nvarchar(128),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  

AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength smallint,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable bit

	DECLARE @PrimaryKeyColumnName NVarChar(128), @insColNames VarChar(MAX), @TableNamePascal nvarchar(128), @selColNames VarChar(MAX), @setColNames VarChar(MAX)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	--CREATE TABLE #SqlTable (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckPredicates nVarChar(MAX), @pkPredicates nVarChar(MAX)

	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId
	
	IF @ckColumnNames Is Not Null
	BEGIN		
		SELECT @ckPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@ckColumnNames)
	END		
	IF @PrimaryKeyColumnName Is Not Null
	BEGIN		
		SELECT @pkPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@PrimaryKeyColumnName)
	END	
	

	SET @Stmt = ''

	IF @ActionType In ('Select', 'SelectByColumns', 'SelectByPK')
	BEGIN
		SELECT @ColNames = COALESCE(@ColNames + ', ' + @nline, '') + 
			@cTAB + @cTAB + '[' + c.[ColumnName] + ']' 
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT ' + @nline + 
									 @ColNames + @nline + 
									 @cTAB + 'FROM ' + 'dbo.[' + @TableName + ']')

		IF @ActionType = 'SelectByColumns'
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @ckPredicates)
			END
		ELSE IF @ActionType = 'SelectByPK'
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)		
			END

	END
	ELSE IF @ActionType = 'Insert'
	BEGIN
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + ']' 
				ELSE '--'
			END
			,@ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '@' + c.[ColumnName]  
				ELSE '--'
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'VALUES' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '('+IsNull(@ColNames, '@ColNames is null') + @nline + @cTAB + ')')
		Insert Into #SqlTable VALUES(@nline)

		IF EXISTS(SELECT 'X' FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
			 AND [c].[IsIdentity]='True')
		BEGIN
			Insert Into #SqlTable VALUES(@cTAB + 'SET @'+ @PrimaryKeyColumnName + ' = scope_identity()')
		END

	END
	ELSE IF @ActionType = 'InsertBulk'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + ']' 
				ELSE '--'
			END
			,@selColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnName] + '] ' + 'nvarchar(100)' ELSE [ColumnName] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnName] + '[not(@i:nil = "true")]''' ELSE '' END
				ELSE '--'
			END			
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will insert a default value and not actually null			
		Insert Into #SqlTable VALUES(@cTAB + 'INSERT INTO ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + '(' + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB + ')' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END
	ELSE IF @ActionType = 'UpdateBulk'
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
	
		Insert Into #SqlTable VALUES(@cTAB + 'IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#' + @TableNamePascal + ']''))AND([type] = ''U'')) )' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'DROP TABLE [#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnNamePascal] + ']' 					
				,@setColNames = 
				CASE 
					WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity] = 1) THEN
						COALESCE(@setColNames + ', ' + @nline, '') + 
						@cTAB + @cTAB + '[bt].[' + [c].[ColumnName] + '] = [tmp].[' + [c].[ColumnNamePascal] + ']'
						ELSE '--' 
					END
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnName] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'INTO ' + '[#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@setColNames, '@setColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'FROM [dbo].[' + @TableName + '] [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@CGEN_MasterTableId, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END	
	ELSE IF @ActionType = 'DeleteBulk'
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, '_')
	
		Insert Into #SqlTable VALUES(@cTAB + 'IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#' + @TableNamePascal + ']''))AND([type] = ''U'')) )' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'DROP TABLE [#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnNamePascal] + ']' 					
				,@selColNames = 
					COALESCE(@selColNames + ', ' + @nline, '') + @cTAB + @cTAB + '[' + CASE [DataType] WHEN 'uniqueidentifier' THEN [ColumnNamePascal] + '] ' + 'nvarchar(100)' ELSE [ColumnNamePascal] + '] ' + [DataType] END + 
					CASE 
						WHEN [DataType]='decimal' THEN '(' + CONVERT(VarChar, [NumericPrecision]) + ', ' + CONVERT(VarChar, [NumericScale]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar', 'char', 'nchar') And [CharacterMaximumLength] <> -1 THEN '(' + CONVERT(VarChar, [CharacterMaximumLength]) + ')' 
						WHEN [DataType] IN ('varchar', 'nvarchar') And [CharacterMaximumLength] = -1 THEN '(MAX)' 
						ELSE '' 
					END + 
					CASE WHEN [IsNullable]='YES' THEN ' ''' + [c].[ColumnName] + '[not(@i:nil = "true")]''' ELSE '' END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + 'SELECT' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, '@insColNames is null') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + 'INTO ' + '[#' + @TableNamePascal + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'FROM OPENXML (@DocHandle, ''/ArrayOf' + @TableNamePascal + '/' + @TableNamePascal +''',2) ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WITH (' + IsNull(@selColNames, '@selColNames is null') + @nline + @cTAB+ ')' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'FROM [dbo].[' + @TableName + '] [bt] ' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'JOIN [#' + @TableNamePascal + '] [tmp] ON ' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@CGEN_MasterTableId, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + '-- remove the xml document' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'EXEC sp_xml_removedocument @DocHandle' + @nline)		

	END		
	ELSE IF @ActionType = 'UpdateByPK'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + @cTAB + '[' + [c].[ColumnName] + '] = @' + [c].[ColumnName]
				ELSE '--'
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @ColNames + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)
	END
	ELSE IF @ActionType = 'UpdateByColumns'
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = [c].[ColumnName] AND [c].[IsIdentity]='True') AND NOT(@ckColumnNames=[c].[ColumnName]) THEN
					COALESCE(@ColNames + ', ' + @nline, '') + 
					@cTAB + '[' + [c].[ColumnName] + '] = @' + [c].[ColumnName]
				ELSE COALESCE(@ColNames + @nline, '--')
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		Insert Into #SqlTable VALUES(@cTAB + 'UPDATE ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SET ' + @ColNames + @nline)
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @ckPredicates)
		
	END
	ELSE IF @ActionType = 'DeleteByPK'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE FROM ' + '[dbo].['+@TableName + ']' + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + 'WHERE ' + @pkPredicates)
	END
	ELSE IF @ActionType = 'DeleteByColumns'
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + 'DELETE FROM ' + '[dbo].['+@TableName + ']' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'WHERE ' + @ckPredicates)
	END
	
	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr	
	*/
END



GO


USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 08/24/2012 17:46:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcErrorHandlerStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 08/24/2012 17:46:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.19
-- Description:   Error handler statement was missing
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
( 
	@CGEN_MasterTableId Int,
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
) 
AS  

SET NOCOUNT ON;

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNameDataTypes VarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength int,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable varchar(10),
	@col_DefaultVal nvarchar(4000)

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))


	SET		@cTAB = char(9)
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=[PrimaryKeyColumnName] FROM [CGEN_MasterTable] WITH(NOLOCK) WHERE [CGEN_MasterTableId]=@CGEN_MasterTableId

		
	Insert Into #SqlTable VALUES(@cTAB + 'DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SET @ProcName=OBJECT_NAME(@@ProcId)'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'SELECT @ErrorInformation=Stuff(('+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + 'SELECT'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + '''EXEC '','+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + '@ProcName+ '' '''+ @nline)
	--SET @Stmt = @Stmt + @cTAB + @cTAB + @cTAB + '''@RoleId='', IsNull(CONVERT(VarChar, @RoleId), + '' '','+ @nline
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, ',')	
	END	
	
	IF @ActionType In ('Insert')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
		
				', ''@' + [c].[ColumnName] + '='', @' + [c].[ColumnName]
			
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
	END
	ELSE IF @ActionType In ('DeleteByPK', 'SelectByPK', 'UpdateByPK')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			CASE 
				--WHEN (@PrimaryKeyColumnName = [c].[ColumnName]) THEN
				WHEN PATINDEX('%'+[c].[ColumnName]+'%', @PrimaryKeyColumnName) > 0 THEN
					', ''@' + [c].[ColumnName] + '='', @' + [c].[ColumnName]					
				ELSE ''
			END
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	ELSE IF @ActionType In ('DeleteByColumns', 'SelectByColumns', 'UpdateByColumns')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '') + 
			', ''@' + [ColumnName] + '='', @' + [ColumnName]					
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + IsNull(@ColNameDataTypes, '') + @nline)
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + 'FOR XML PATH ('''')'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + '),1,0,'''')'+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + 'EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation'+ @nline)
	
	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr
	*/	

END



GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 08/24/2012 17:47:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPkColumnsJoinClause]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPkColumnsJoinClause]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 08/24/2012 17:47:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.07.20
-- Description:   Bulk Operations (Insert, Update, Delete)
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Pass @CGEN_MasterTableId
-- =============================================  
  
CREATE FUNCTION [dbo].[CGEN_fnGetPkColumnsJoinClause]
( 
	@CGEN_MasterTableId Int, @ColumnNames nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))
	DECLARE @joinClause nVarChar(MAX)

	IF @ColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, ',')
		
		SELECT @joinClause = COALESCE(@joinClause + ' AND ', '') + '[bt].[' + [c].[ColumnName] + '] = [tmp].[' + [c].[ColumnNamePascal] + ']'
		FROM [CGEN_MasterTableColumn] [c] WITH(NOLOCK)
		JOIN [CGEN_MasterTable] [t] WITH(NOLOCK) ON [c].[CGEN_MasterTableId]=@CGEN_MasterTableId AND [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
		JOIN @ckColumnsTable [ct] ON [c].[ColumnName]=ct.[ColumnName]			
		RETURN @joinClause
	END	
	RETURN Null
	-----------------------------

END



GO

USE [CodeGenerator]
GO

/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 08/24/2012 17:48:28 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns]'))
DROP VIEW [dbo].[vwCGEN_Columns]
GO

USE [CodeGenerator]
GO

/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 08/24/2012 17:48:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO






-- =======================================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.07.20
-- Description:   Replaces the information_schema.columns view
--				  to return a list of columns with supported datatypes 
--				  for code generation
-- =======================================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.08.20
-- Description:   Use table [CGEN_MasterTableColumn]
-- =======================================================

CREATE VIEW [dbo].[vwCGEN_Columns]
AS

SELECT TABLE_CATALOG=[db].[DatabaseName], TABLE_SCHEMA=[t].[SchemaName], [t].[TableName], [c].[ColumnName]
	,[ColumnNamePascal]=IsNull([c].[ColumnNamePascal], [dbo].CGEN_fnToPascalCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[ColumnNameCamel]=IsNull([c].[ColumnNameCamel], [dbo].CGEN_fnToCamelCase([c].[ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])))
	,[c].[ColumnDefault], [c].[IsNullable], [c].[DataType] , [c].[IsIdentity]
FROM [CGEN_MasterTableColumn] [c]
JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]
JOIN [CGEN_MasterDatabase] [db] ON [db].[CGEN_MasterDatabaseId]=[t].[CGEN_MasterDatabaseId]


/*
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME='JOB_Job'
*/



GO



/************* End Stored Procedures ******************/
