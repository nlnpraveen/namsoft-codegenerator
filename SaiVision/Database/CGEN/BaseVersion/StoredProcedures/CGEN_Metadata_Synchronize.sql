USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_Synchronize]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_Synchronize]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2012.09.04
-- Description:		Synchronize metadata from another database
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.09.27
-- Description:		Added column order
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Metadata_Synchronize] --''
	@IsTesting Bit = 'False',
	@xmlMetadata xml=null
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @DocHandle int,@ErrNo int, @DataBaseId Int,@DatabaseName nvarchar(128),@xpathclause nvarchar(2000)

--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

BEGIN TRY
	IF @IsTesting='True'
	BEGIN
		PRINT ''
	END
	
	IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterDatabases]'))AND([type] = 'U')) )	
		DROP TABLE #MasterDatabases	
	IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterTables]'))AND([type] = 'U')) )	
		DROP TABLE #MasterTables
	IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#MasterColumns]'))AND([type] = 'U')) )	
		DROP TABLE #MasterColumns
	
	CREATE TABLE #MasterDatabases		
	(
		[DataBaseId] Int,
		[DatabaseName] [nvarchar](128)	
	)
	CREATE TABLE #MasterTables
	(
		[TableName] [nvarchar](128),
		[PrimaryKeyNames] [nvarchar](128),
		[IsSelect] [bit],
		[IsInsert] [bit],
		[IsInsertBulk] [bit],
		[IsUpdateBulk] [bit],
		[IsDeleteBulk] [bit],
		[IsSelectByPK] [bit],
		[IsUpdateByPK] [bit],
		[IsDeleteByPK] [bit]	
	)
	CREATE TABLE #MasterColumns
	(
		[TableName] [nvarchar](128),
		[ColumnName] [nvarchar](128),
		[IsNullable] Bit,
		[DataType] NVarChar(128),
		[IsIdentity] Bit,
		[IsPrimaryKey] Bit,
		[NumericPrecision] tinyint,
		[NumericScale] Int,
		[CharacterMaximumLength] Int,
		[ColumnDefault] nvarchar(128),
		[ColumnOrder] Int
	)
	
	EXEC sp_xml_preparedocument @DocHandle OUTPUT, @xmlMetadata
	
	INSERT INTO #MasterDatabases ([DataBaseId],[DatabaseName])
	SELECT * FROM OPENXML (@DocHandle, '//DBMetaData')
	 WITH 
		(
			[DataBaseId] Int,
			[DatabaseName] [nvarchar](128)
		)

	IF @IsTesting = 'True'	SELECT * FROM #MasterDatabases
	--DELETE FROM [CGEN_MasterTable] WHERE [IsGenerateCode]='False'
	--DBCC CHECKIDENT (CGEN_MasterTable, reseed, 11)
	--DBCC CHECKIDENT (CGEN_MasterTableColumn, reseed, 75)
	WHILE EXISTS(SELECT 'X' FROM #MasterDatabases)
	BEGIN
		SELECT TOP 1 @DataBaseId=[DataBaseId] FROM #MasterDatabases
		
		DELETE FROM #MasterTables
		DELETE FROM #MasterColumns
		
		SET @xpathclause = '//DBMetaData[@DataBaseId=' + Convert(varchar, @DataBaseId) + ']/Tables/TableMetaData'
		INSERT INTO #MasterTables ([TableName],	[PrimaryKeyNames],[IsSelect],[IsInsert],[IsInsertBulk],[IsUpdateBulk],[IsDeleteBulk],[IsSelectByPK],[IsUpdateByPK],[IsDeleteByPK])
		SELECT * FROM OPENXML (@DocHandle, @xpathclause)
		 WITH 
			(
				[TableName] [nvarchar](128),
				[PrimaryKeyNames] [nvarchar](128),
				[IsSelect] [bit],
				[IsInsert] [bit],
				[IsInsertBulk] [bit],
				[IsUpdateBulk] [bit],
				[IsDeleteBulk] [bit],
				[IsSelectByPK] [bit],
				[IsUpdateByPK] [bit],
				[IsDeleteByPK] [bit]
			)
			
		SET @xpathclause = '//DBMetaData[@DataBaseId=' + Convert(varchar, @DataBaseId) + ']/Tables//TableMetaData//ColumnMetaData'
		INSERT INTO #MasterColumns ([TableName],[ColumnName],[ColumnDefault],[IsNullable],[DataType],[IsIdentity],[IsPrimaryKey],[NumericPrecision],[NumericScale],[CharacterMaximumLength],[ColumnOrder])
		SELECT * FROM OPENXML (@DocHandle, @xpathclause)
		 WITH 
			(
				[TableName] [nvarchar](128),
				[ColumnName] [nvarchar](128),
				[ColumnDefault] [nvarchar](128),
				[IsNullable] Bit,
				[DataType] NVarChar(128),
				[IsIdentity] Bit,
				[IsPrimaryKey] Bit,
				[NumericPrecision] tinyint,
				[NumericScale] Int,
				[CharacterMaximumLength] Int,
				[ColumnOrder] Int
			)	


		IF @IsTesting = 'True'
		BEGIN
			SELECT * FROM #MasterTables
			SELECT * FROM #MasterColumns
		END
			
		IF @IsTesting = 'False'
		BEGIN
			-- Check for deleted tables
			--UPDATE [mt] SET [mt].[IsActive]='False'
			--FROM [CGEN_MasterTable] [mt] 
			--LEFT JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[TableName]=[tt].[TableName]
			--WHERE [tt].[TableName] Is Null
			
			-- Update Primary Key Names
			UPDATE [mt] SET [mt].[PrimaryKeyColumnName]=[tt].[PrimaryKeyNames], [mt].[IsActive]='True'
			FROM [CGEN_MasterTable] [mt] 
			JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[TableName]=[tt].[TableName]
			WHERE [mt].[PrimaryKeyColumnName]<>[tt].[PrimaryKeyNames]
			
			-- Insert new tables
			INSERT INTO [dbo].[CGEN_MasterTable]([CGEN_MasterDatabaseId],[TableName],[TableNamePascal],[TableNameCamel],[PrimaryKeyColumnName])
			SELECT @DataBaseId, [tt].[TableName],[TableNamePascal]='',[TableNameCamel]='', [PrimaryKeyColumnName]=[tt].[PrimaryKeyNames]
			FROM #MasterTables [tt]
			LEFT JOIN [CGEN_MasterTable] [mt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[TableName]=[tt].[TableName]	
			WHERE [mt].[CGEN_MasterTableId] Is Null
			
			-- Update IsPrimaryKey
			UPDATE [tc] SET [IsPrimaryKey]=CASE WHEN [tc1].[ColumnName] Is Null THEN 'False' ELSE 'True' END
			FROM [CGEN_MasterTable] [mt] 
			JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[IsActive]='True' AND [mt].[TableName]=[tt].[TableName]
			JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] 
			CROSS APPLY [dbo].[Split]([tt].[PrimaryKeyNames],',') [v]
			LEFT JOIN #MasterColumns [tc1] ON [tc1].[TableName]=[mt].[TableName] AND [tc1].[ColumnName]=[v].[strval] AND [tc1].[ColumnName]=[tc].[ColumnName]		
			
			UPDATE #MasterColumns SET [IsPrimaryKey]='False' WHERE [IsPrimaryKey] Is Null
			
			-- Check for deleted columns
			DELETE [mc]
			FROM [CGEN_MasterTable] [mt] 
			JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[IsActive]='True' AND [mt].[TableName]=[tt].[TableName]
			JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId]
			LEFT JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] AND [tc].[ColumnName]=[mc].[ColumnName]
			WHERE [tc].[ColumnName] Is Null		
			
			-- Update column changes		
			UPDATE [mc] SET [mc].[IsNullable]=CASE [tc].[IsNullable] WHEN 'True' THEN 'Yes' ELSE 'NO' END
				,[mc].[DataType]=[tc].[DataType], [mc].[IsIdentity]=[tc].[IsIdentity], [mc].[IsPrimaryKey]=[tc].[IsPrimaryKey]
				,[mc].[NumericPrecision]=[tc].[NumericPrecision], [mc].[NumericScale]=[tc].[NumericScale]
				,[mc].[CharacterMaximumLength]=[tc].[CharacterMaximumLength], [mc].[ColumnDefault]=[tc].[ColumnDefault], [mc].[ColumnOrder]=[tc].[ColumnOrder]
			FROM [CGEN_MasterTable] [mt] 
			JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[IsActive]='True' AND [mt].[TableName]=[tt].[TableName]
			JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId]
			JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] AND [tc].[ColumnName]=[mc].[ColumnName]
			
			-- Insert new columns
			INSERT INTO [dbo].[CGEN_MasterTableColumn] ([CGEN_MasterTableId],[TableName],[ColumnName],[ColumnNamePascal],[ColumnNameCamel]
					   ,[ColumnDefault],[IsNullable],[DataType],[IsIdentity],[IsPrimaryKey],[NumericPrecision],[NumericScale]
					   ,[CharacterMaximumLength],[ColumnOrder])
			SELECT [mt].[CGEN_MasterTableId], [mt].[TableName], [tc].[ColumnName], [ColumnNamePascal]='', [ColumnNameCamel]=''
				,[tc].[ColumnDefault], [IsNullable]=CASE [tc].[IsNullable] WHEN 'True' THEN 'Yes' ELSE 'NO' END
				,[tc].[DataType], [tc].[IsIdentity], [tc].[IsPrimaryKey], [tc].[NumericPrecision], [tc].[NumericScale], [tc].[CharacterMaximumLength]
				,[tc].[ColumnOrder]
			FROM [CGEN_MasterTable] [mt] 
			JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[IsActive]='True' AND [mt].[TableName]=[tt].[TableName]
			JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName]
			LEFT JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId] AND [tc].[ColumnName]=[mc].[ColumnName]
			WHERE [mc].[ColumnName] Is Null
			ORDER BY [mt].[TableName], [tc].[ColumnOrder]
		END
		
		UPDATE [CGEN_MasterDatabase] SET [LastSyncDate]=GetDate() WHERE [CGEN_MasterDatabaseId]=@DataBaseId
		
		/*
		SELECT [tc].*, [IsPrKey]=CASE WHEN [tc1].[ColumnName] Is Null THEN 'False' ELSE 'True' END
		FROM [CGEN_MasterTable] [mt] 
		JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[TableName]=[tt].[TableName]
		--JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId]
		JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] --AND [tc].[ColumnName]=[mc].[ColumnName]
		CROSS APPLY [dbo].[Split]([tt].[PrimaryKeyNames],',') [v]
		LEFT JOIN #MasterColumns [tc1] ON [tc1].[TableName]=[mt].[TableName] AND [tc1].[ColumnName]=[v].[strval] AND [tc1].[ColumnName]=[tc].[ColumnName]		
		
		SELECT [tc].*, [IsPrKey]=CASE WHEN [v].[strval] Is Null THEN 'False' ELSE 'True' END
		FROM [CGEN_MasterTable] [mt] 
		JOIN #MasterTables [tt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[TableName]=[tt].[TableName]
		--JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId]
		JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] --AND [tc].[ColumnName]=[mc].[ColumnName]
		LEFT JOIN [dbo].[Split]([tt].[PrimaryKeyNames],',') [v] ON [v].[strval]=[tc].[ColumnName]
		--LEFT JOIN #MasterColumns [tc1] ON [tc1].[TableName]=[mt].[TableName] AND [tc1].[ColumnName]=[v].[strval] AND [tc1].[ColumnName]=[tc].[ColumnName]		
		*/
		
		DELETE TOP (1) #MasterDatabases
	END
	
	-- remove the xml document
	EXEC sp_xml_removedocument @DocHandle
END TRY
BEGIN CATCH
	DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)
	SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())
	SET @ProcName=OBJECT_NAME(@@ProcId)
	SELECT @ErrorInformation=Stuff((
		SELECT
		'EXEC ',
		@ProcName+ ' '
			
			FOR XML PATH ('')
			),1,0,'')
	EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation

END CATCH


GO

