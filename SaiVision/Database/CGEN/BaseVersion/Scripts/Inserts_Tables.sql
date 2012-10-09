USE [CodeGenerator]
GO

DELETE FROM [CGEN_MasterTableColumn]
DBCC CHECKIDENT (CGEN_MasterTableColumn, reseed, 0)
DELETE FROM [CGEN_MasterTable]
DBCC CHECKIDENT (CGEN_MasterTable, reseed, 0)
DELETE FROM [CGEN_MasterDatabase]
DBCC CHECKIDENT (CGEN_MasterDatabase, reseed, 0)

INSERT INTO [dbo].[CGEN_MasterDatabase]([DatabaseName])
VALUES('CommandCenter')
INSERT INTO [dbo].[CGEN_MasterDatabase]([DatabaseName])
VALUES('Lifetime')
GO
--SELECT * FROM [CGEN_MasterDatabase]

IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#DatabaseTables]'))AND([type] = 'U')) )	
	DROP TABLE #DatabaseTables
	
/*
IF EXISTS ( SELECT 'X' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N'[tempdb].[dbo].[#DatabaseTables_Excluded]'))AND([type] = 'U')) )	
	DROP TABLE #DatabaseTables_Excluded

CREATE TABLE #DatabaseTables_Excluded
(
	[TableName] NVarChar(128)
)
INSERT INTO #DatabaseTables_Excluded([TableName]) VALUES ('JOB_JobActivityLog')
INSERT INTO #DatabaseTables_Excluded([TableName]) VALUES ('JOB_SchedulerActivityLog')
*/


SELECT [CGEN_MasterDatabaseId]=1, [SchemaName]='dbo', [TableName]=[TABLE_NAME], [PrimaryKey]=[SaiVision].dbo.[CGEN_fnGetPrimaryKeyColumn](TABLE_NAME)
INTO #DatabaseTables
FROM [SaiVision].INFORMATION_SCHEMA.TABLES 
WHERE [TABLE_NAME] IN ('def_form_question_type','alert_message_template','plan_type','LOCK_Entity','BitFlags','API_NOTIFICATION_NotificationFeed','PROGRAM_Instructions','PIMW_StepRule','provider','faculty_attribute','DEFINITION_DefinitionTemplateDisplay')

DECLARE @TableName NVarChar(128), @PrimaryKey NVarChar(128), @TableId Int
DECLARE @PrimaryKeys TABLE (ColumnName VARCHAR(8000))

WHILE EXISTS(SELECT 'X' FROM #DatabaseTables)
BEGIN
	SELECT TOP 1 @TableName=[TableName], @PrimaryKey=[PrimaryKey] FROM #DatabaseTables
	
	DELETE FROM @PrimaryKeys
	INSERT INTO @PrimaryKeys
	SELECT [strval] FROM [dbo].[Split](@PrimaryKey, ',')
	
	INSERT INTO [dbo].[CGEN_MasterTable]
		   ([CGEN_MasterDatabaseId]
		   ,[SchemaName]
		   ,[TableName]
		   ,[PrimaryKeyColumnName]
		   ,[IsSelect]
		   ,[IsInsert]
		   ,[IsInsertBulk]
		   ,[IsUpdateBulk]
		   ,[IsDeleteBulk]
		   ,[IsSelectByPK]
		   ,[IsUpdateByPK]
		   ,[IsDeleteByPK]
		   ,[IsActive]
		   ,[TableNamePascal]
		   ,[TableNameCamel]
		   ,[IsTruncatePrefix_Table]
		   ,[PrefixToTruncate_Table]
		   ,[PrefixToApply_Table]
		   ,[IsTruncatePrefix_Column]
		   ,[PrefixToTruncate_Column]
		   ,[PrefixToApply_Column]
		   ,[CreateDate])
	SELECT [CGEN_MasterDatabaseId],[SchemaName],[TableName] 
		,[PrimaryKey]
		,[IsSelect]='True' 
		,[IsInsert]='True'
	   ,[IsInsertBulk]='true'
	   ,[IsUpdateBulk]=CASE WHEN [PrimaryKey] Is Null THEN 'False' ELSE 'True' END
	   ,[IsDeleteBulk]=CASE WHEN [PrimaryKey] Is Null THEN 'False' ELSE 'True' END
	   ,[IsSelectByPK]=CASE WHEN [PrimaryKey] Is Null THEN 'False' ELSE 'True' END
	   ,[IsUpdateByPK]=CASE WHEN [PrimaryKey] Is Null THEN 'False' ELSE 'True' END
	   ,[IsDeleteByPK]=CASE WHEN [PrimaryKey] Is Null THEN 'False' ELSE 'True' END
	   ,[IsActive]='True'
	   ,''
	   ,''
	   ,[IsTruncatePrefix_Table]=
			CASE 
			WHEN [TableName]='def_form_question_type' THEN 'True'
			WHEN [TableName]='alert_message_template' THEN 'False'
			WHEN [TableName]='plan_type' THEN 'False'
			WHEN [TableName]='LOCK_Entity' THEN 'False'
			WHEN [TableName]='API_NOTIFICATION_NotificationFeed' THEN 'True'
			WHEN [TableName]='PROGRAM_Instructions' THEN 'False'
			WHEN [TableName]='PIMW_StepRule' THEN 'True'
			WHEN [TableName]='provider' THEN 'False'
			WHEN [TableName]='faculty_attribute' THEN 'False'
			WHEN [TableName]='DEFINITION_DefinitionTemplateDisplay' THEN 'True' ELSE 'False' END
	   ,[PrefixToTruncate_Table]=
			CASE 
			WHEN [TableName]='def_form_question_type' THEN 'def_form_question_type'
			WHEN [TableName]='alert_message_template' THEN Null
			WHEN [TableName]='plan_type' THEN Null
			WHEN [TableName]='LOCK_Entity' THEN Null
			WHEN [TableName]='API_NOTIFICATION_NotificationFeed' THEN 'API_NOTIFICATION_NotificationFeed'
			WHEN [TableName]='PROGRAM_Instructions' THEN Null
			WHEN [TableName]='PIMW_StepRule' THEN 'PIMW'
			WHEN [TableName]='provider' THEN null
			WHEN [TableName]='faculty_attribute' THEN Null
			WHEN [TableName]='DEFINITION_DefinitionTemplateDisplay' THEN 'DEFINITION_DefinitionTemplateDisplay' ELSE Null END
	   ,[PrefixToApply_Table]=
			CASE 
			WHEN [TableName]='def_form_question_type' THEN 'DefaultFormQuestionType'
			WHEN [TableName]='alert_message_template' THEN Null
			WHEN [TableName]='plan_type' THEN Null
			WHEN [TableName]='LOCK_Entity' THEN Null
			WHEN [TableName]='API_NOTIFICATION_NotificationFeed' THEN 'ApiNotificationFeed'
			WHEN [TableName]='PROGRAM_Instructions' THEN Null
			WHEN [TableName]='PIMW_StepRule' THEN 'PimWorkflow'
			WHEN [TableName]='provider' THEN null
			WHEN [TableName]='faculty_attribute' THEN Null
			WHEN [TableName]='DEFINITION_DefinitionTemplateDisplay' THEN 'DefinitionTemplateDisplay' ELSE Null END
	   ,[IsTruncatePrefix_Column]=Null
	   ,[PrefixToTruncate_Column]=Null
	   ,[PrefixToApply_Column]=Null
	   ,GetDate()
	   FROM #DatabaseTables WHERE [TableName]=@TableName
	   
	   SELECT @TableId= SCOPE_IDENTITY()
	   UPDATE [CGEN_MasterTable] SET 		 
			[TableNamePascal]=dbo.CGEN_fnToPascalCase([TableName], [IsTruncatePrefix_Table], [PrefixToTruncate_Table], [PrefixToApply_Table]), 
			[TableNameCamel]=dbo.CGEN_fnToCamelCase([TableName], [IsTruncatePrefix_Table], [PrefixToTruncate_Table], [PrefixToApply_Table])
		WHERE [CGEN_MasterTableId]=@TableId
	   
	   /************* Inserting Columns **************/
	   INSERT INTO [dbo].[CGEN_MasterTableColumn]
           ([CGEN_MasterTableId]
           ,[TableName]
           ,[ColumnName]
           ,[ColumnNamePascal]
           ,[ColumnNameCamel]
           ,[ColumnDefault]
           ,[IsNullable]
           ,[DataType]
           ,[IsIdentity]
           ,[IsPrimaryKey]
           ,[IsTruncatePrefix]
           ,[PrefixToTruncate]
           ,[PrefixToApply])
		SELECT
           @TableId
           ,@TableName
           ,[COLUMN_NAME]
           ,''
           ,''
           ,[COLUMN_DEFAULT]
           ,[IS_NULLABLE]
           ,[DATA_TYPE]
           ,[IsIdentity]=[SaiVision].[dbo].[CGEN_fnIsIdentityColumn](@TableName, [COLUMN_NAME])
           ,[IsPrimaryKey]=CASE WHEN [pk].[ColumnName] Is Not Null THEN 'True' ELSE 'False' END
           ,Null
           ,Null
           ,Null
	   FROM [SaiVision].INFORMATION_SCHEMA.COLUMNS [c]
	   LEFT JOIN @PrimaryKeys [pk] ON [c].[Column_Name]=[pk].[ColumnName]
	   WHERE [c].[TABLE_NAME]=@TableName
	    
	   DELETE FROM #DatabaseTables WHERE [TableName]=@TableName
END

UPDATE [c] SET
	[ColumnNamePascal]=dbo.CGEN_fnToPascalCase([ColumnName], 
			COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), 
			COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), 
			COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table])), 
	[ColumnNameCamel]=dbo.CGEN_fnToCamelCase([ColumnName], COALESCE([c].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), 
			COALESCE([c].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), 
			COALESCE([c].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
FROM [CGEN_MasterTableColumn] [c]
JOIN [CGEN_MasterTable] [t] ON [c].[CGEN_MasterTableId]=[t].[CGEN_MasterTableId]

----


/*
SELECT 
FROM INFORMATION_SCHEMA.Tables [c]--JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[TABLE_NAME]=[t].[TableName]--LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		
WHERE [c].COLUMN_DEFAULT Is Null

SELECT [c].TABLE_CATALOG, [c].TABLE_SCHEMA, [TableName]=[c].TABLE_NAME, [ColumnName]=[c].COLUMN_NAME
	,[ColumnDefault]=[c].COLUMN_DEFAULT, [IsNullable]=[c].IS_NULLABLE, [DataType]=[c].DATA_TYPE , [IsIdentity]=COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], 'IsIdentity') 
FROM INFORMATION_SCHEMA.COLUMNS [c]--JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]='True' AND [c].[TABLE_NAME]=[t].[TableName]--LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		
WHERE [c].COLUMN_DEFAULT Is Null
*/
