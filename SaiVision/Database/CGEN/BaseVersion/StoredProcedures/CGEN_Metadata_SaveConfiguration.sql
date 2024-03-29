USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_SaveConfiguration]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_SaveConfiguration]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SaveConfiguration]    Script Date: 09/04/2012 18:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2012.09.23
-- Description:		Saves the user configuration
--					on the metadata
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2013.07.02
-- Description:		Save namespace
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_Metadata_SaveConfiguration] --''
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
		SET @xmlMetadata='<DBMetaData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" DataBaseId="1" DatabaseName="CommandCenter"><Tables><TableMetaData TableId="1" TableName="alert_message_template" TableNamePascal="AlertMessageTemplate" TableNameCamel="alertMessageTemplate" PrimaryKeyNames="alert_message_seq" PrimaryKeyNamesPascal="AlertMessageSeq" PrimaryKeyNamesCamel="alertMessageSeq" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="alert_message_template" ColumnName="alert_message_seq" ColumnNamePascal="AlertMessageSeq" ColumnNameCamel="alertMessageSeq" IsNullable="false" DataType="int" IsIdentity="true" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="alert_seq" ColumnNamePascal="AlertSeq" ColumnNameCamel="alertSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="message_template_seq" ColumnNamePascal="MessageTemplateSeq" ColumnNameCamel="messageTemplateSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="create_user_id" ColumnNamePascal="CreateUserId" ColumnNameCamel="createUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="last_user_id" ColumnNamePascal="LastUserId" ColumnNameCamel="lastUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="create_date" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="last_update_date" ColumnNamePascal="LastUpdateDate" ColumnNameCamel="lastUpdateDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="alert_message_template" ColumnName="alert_message_name1" ColumnNamePascal="" ColumnNameCamel="" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="2" TableName="API_NOTIFICATION_NotificationFeed" TableNamePascal="ApiNotificationFeed" TableNameCamel="apiNotificationFeed" PrimaryKeyNames="API_NOTIFICATION_NotificationFeedId" PrimaryKeyNamesPascal="ApiNotificationFeedId" PrimaryKeyNamesCamel="apiNotificationFeedId" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="API_NOTIFICATION_NotificationFeedId" ColumnNamePascal="ApiNotificationFeedId" ColumnNameCamel="apiNotificationFeedId" IsNullable="false" DataType="uniqueidentifier" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="OrganizationId" ColumnNamePascal="OrganizationId" ColumnNameCamel="organizationId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="SiteId" ColumnNamePascal="SiteId" ColumnNameCamel="siteId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="FeedXML" ColumnNamePascal="FeedXML" ColumnNameCamel="feedXML" IsNullable="true" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="StatusCodeId" ColumnNamePascal="StatusCodeId" ColumnNameCamel="statusCodeId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="RetryCount" ColumnNamePascal="RetryCount" ColumnNameCamel="retryCount" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="IsRetryMaxed" ColumnNamePascal="IsRetryMaxed" ColumnNameCamel="isRetryMaxed" IsNullable="false" DataType="bit" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="CreateDate" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="CreateUserId" ColumnNamePascal="CreateUserId" ColumnNameCamel="createUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="ProcessedDate" ColumnNamePascal="ProcessedDate" ColumnNameCamel="processedDate" IsNullable="true" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="API_NOTIFICATION_NotificationFeed" ColumnName="LastRetryDate" ColumnNamePascal="LastRetryDate" ColumnNameCamel="lastRetryDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="3" TableName="BitFlags" TableNamePascal="BitFlags" TableNameCamel="bitFlags" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="false" IsDeleteBulk="false" IsSelectByPK="false" IsUpdateByPK="false" IsDeleteByPK="false" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="BitFlags" ColumnName="id" ColumnNamePascal="Id" ColumnNameCamel="id" IsNullable="false" DataType="int" IsIdentity="true" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="table_object_sys_id" ColumnNamePascal="TableObjectSysId" ColumnNameCamel="tableObjectSysId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="column_name" ColumnNamePascal="ColumnName" ColumnNameCamel="columnName" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="bit_value" ColumnNamePascal="BitValue" ColumnNameCamel="bitValue" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="bit_description" ColumnNamePascal="BitDescription" ColumnNameCamel="bitDescription" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="default_setting" ColumnNamePascal="DefaultSetting" ColumnNameCamel="defaultSetting" IsNullable="true" DataType="bit" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="BitFlags" ColumnName="comments" ColumnNamePascal="Comments" ColumnNameCamel="comments" IsNullable="true" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="4" TableName="def_form_question_type" TableNamePascal="DefaultFormQuestionType" TableNameCamel="defaultFormQuestionType" PrimaryKeyNames="form_type_seq,question_type_seq" PrimaryKeyNamesPascal="FormTypeSeq,QuestionTypeSeq" PrimaryKeyNamesCamel="formTypeSeq,questionTypeSeq" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="def_form_question_type" ColumnName="form_type_seq" ColumnNamePascal="FormTypeSeq" ColumnNameCamel="formTypeSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="def_form_question_type" ColumnName="question_type_seq" ColumnNamePascal="QuestionTypeSeq" ColumnNameCamel="questionTypeSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="def_form_question_type" ColumnName="active_ind" ColumnNamePascal="ActiveInd" ColumnNameCamel="activeInd" IsNullable="false" DataType="char" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="5" TableName="DEFINITION_DefinitionTemplateDisplay" TableNamePascal="DefinitionTemplateDisplay" TableNameCamel="definitionTemplateDisplay" PrimaryKeyNames="DefinitionId,language_seq" PrimaryKeyNamesPascal="DefinitionId,LanguageSeq" PrimaryKeyNamesCamel="definitionId,languageSeq" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="DefinitionId" ColumnNamePascal="DefinitionId" ColumnNameCamel="definitionId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="language_seq" ColumnNamePascal="LanguageSeq" ColumnNameCamel="languageSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="Word" ColumnNamePascal="Word" ColumnNameCamel="word" IsNullable="false" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="Description" ColumnNamePascal="Description" ColumnNameCamel="description" IsNullable="false" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="DescriptionPlainText" ColumnNamePascal="DescriptionPlainText" ColumnNameCamel="descriptionPlainText" IsNullable="true" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="CreateDate" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="CreateUserId" ColumnNamePascal="CreateUserId" ColumnNameCamel="createUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="LastModifiedDate" ColumnNamePascal="LastModifiedDate" ColumnNameCamel="lastModifiedDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="DEFINITION_DefinitionTemplateDisplay" ColumnName="LastModifiedUserId" ColumnNamePascal="LastModifiedUserId" ColumnNameCamel="lastModifiedUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="6" TableName="faculty_attribute" TableNamePascal="FacultyAttribute" TableNameCamel="facultyAttribute" PrimaryKeyNames="faculty_seq,faculty_attribute_seq" PrimaryKeyNamesPascal="FacultySeq,FacultyAttributeSeq" PrimaryKeyNamesCamel="facultySeq,facultyAttributeSeq" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="faculty_attribute" ColumnName="faculty_seq" ColumnNamePascal="FacultySeq" ColumnNameCamel="facultySeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="faculty_attribute_seq" ColumnNamePascal="FacultyAttributeSeq" ColumnNameCamel="facultyAttributeSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="attribute_value" ColumnNamePascal="AttributeValue" ColumnNameCamel="attributeValue" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="create_date" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="create_user_id" ColumnNamePascal="CreateUserId" ColumnNameCamel="createUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="last_update_date" ColumnNamePascal="LastUpdateDate" ColumnNameCamel="lastUpdateDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="faculty_attribute" ColumnName="last_user_id" ColumnNamePascal="LastUserId" ColumnNameCamel="lastUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="7" TableName="LOCK_Entity" TableNamePascal="LockEntity" TableNameCamel="lockEntity" PrimaryKeyNames="LOCK_EntityID" PrimaryKeyNamesPascal="LockEntityID" PrimaryKeyNamesCamel="lockEntityID" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="LOCK_Entity" ColumnName="LOCK_EntityID" ColumnNamePascal="LockEntityID" ColumnNameCamel="lockEntityID" IsNullable="false" DataType="int" IsIdentity="true" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="LOCK_EntityTypeID" ColumnNamePascal="LockEntityTypeID" ColumnNameCamel="lockEntityTypeID" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="LockKey" ColumnNamePascal="LockKey" ColumnNameCamel="lockKey" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="CreateDate" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="CreateUserId" ColumnNamePascal="CreateUserId" ColumnNameCamel="createUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="LastModifiedDate" ColumnNamePascal="LastModifiedDate" ColumnNameCamel="lastModifiedDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="LOCK_Entity" ColumnName="LastModifiedUserId" ColumnNamePascal="LastModifiedUserId" ColumnNameCamel="lastModifiedUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="9" TableName="plan_type" TableNamePascal="PlanType" TableNameCamel="planType" PrimaryKeyNames="plan_type_seq,name" PrimaryKeyNamesPascal="PlanTypeSeq,Name" PrimaryKeyNamesCamel="planTypeSeq,name" IsGenerateCode="true" IsSelect="true" IsInsert="true" IsInsertBulk="true" IsUpdateBulk="true" IsDeleteBulk="true" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="plan_type" ColumnName="plan_type_seq" ColumnNamePascal="PlanTypeSeq" ColumnNameCamel="planTypeSeq" IsNullable="false" DataType="int" IsIdentity="true" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="plan_type" ColumnName="name" ColumnNamePascal="Name" ColumnNameCamel="name" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="plan_type" ColumnName="description" ColumnNamePascal="Description" ColumnNameCamel="description" IsNullable="true" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="plan_type" ColumnName="active_ind" ColumnNamePascal="ActiveInd" ColumnNameCamel="activeInd" IsNullable="false" DataType="char" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="32" TableName="abt_scenario_accreditation" TableNamePascal="AbtScenarioAccreditation" TableNameCamel="abtScenarioAccreditation" PrimaryKeyNames="abt_scenario_seq,accreditation_id" PrimaryKeyNamesPascal="AbtScenarioSeq,AccreditationId" PrimaryKeyNamesCamel="abtScenarioSeq,accreditationId" IsGenerateCode="false" IsSelect="false" IsInsert="true" IsInsertBulk="false" IsUpdateBulk="false" IsDeleteBulk="false" IsSelectByPK="true" IsUpdateByPK="true" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="deleted_ind" ColumnNamePascal="IsDeleted" ColumnNameCamel="isDeleted" IsNullable="false" DataType="char" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="expiration_date" ColumnNamePascal="ExpirationDate" ColumnNameCamel="expirationDate" IsNullable="true" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="create_date" ColumnNamePascal="CreateDate" ColumnNameCamel="createDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="abt_scenario_seq" ColumnNamePascal="AbtScenarioSeq" ColumnNameCamel="abtScenarioSeq" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="accreditation_id" ColumnNamePascal="AccreditationId" ColumnNameCamel="accreditationId" IsNullable="false" DataType="varchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="last_update_date" ColumnNamePascal="LastUpdateDate" ColumnNameCamel="lastUpdateDate" IsNullable="false" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="last_user_id" ColumnNamePascal="LastUserId" ColumnNameCamel="lastUserId" IsNullable="false" DataType="int" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="abt_scenario_accreditation" ColumnName="release_date" ColumnNamePascal="ReleaseDate" ColumnNameCamel="releaseDate" IsNullable="true" DataType="datetime" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData><TableMetaData TableId="61" TableName="activity_activitycontenttype" TableNamePascal="ActivityContentType" TableNameCamel="activityContentType" PrimaryKeyNames="ActivityContentTypeId" PrimaryKeyNamesPascal="ActivityContentTypeId" PrimaryKeyNamesCamel="activityContentTypeId" IsGenerateCode="false" IsSelect="true" IsInsert="true" IsInsertBulk="false" IsUpdateBulk="true" IsDeleteBulk="false" IsSelectByPK="false" IsUpdateByPK="false" IsDeleteByPK="true" IsSelectByColumns="false" IsUpdateByColumns="false" IsDeleteByColumns="false"><Columns><ColumnMetaData TableName="activity_activitycontenttype" ColumnName="Name" ColumnNamePascal="Name" ColumnNameCamel="name" IsNullable="false" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="activity_activitycontenttype" ColumnName="IsActive" ColumnNamePascal="IsActive" ColumnNameCamel="isActive" IsNullable="false" DataType="bit" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="activity_activitycontenttype" ColumnName="IsDeleted" ColumnNamePascal="IsDeleted" ColumnNameCamel="isDeleted" IsNullable="false" DataType="bit" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="activity_activitycontenttype" ColumnName="Description" ColumnNamePascal="Description" ColumnNameCamel="description" IsNullable="true" DataType="nvarchar" IsIdentity="false" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /><ColumnMetaData TableName="activity_activitycontenttype" ColumnName="ActivityContentTypeId" ColumnNamePascal="ActivityContentTypeId" ColumnNameCamel="activityContentTypeId" IsNullable="false" DataType="int" IsIdentity="true" NumericPrecision="0" NumericScale="0" CharacterMaximumLength="0" /></Columns></TableMetaData></Tables></DBMetaData>'
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
		[TableId] Int,
		[TableName] [nvarchar](128),
		[PrimaryKeyNames] [nvarchar](128),
		[NamespaceId] [int],
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
		[ColumnNamePascal] [nvarchar](128),
		[ColumnNameCamel] [nvarchar](128)		
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
		INSERT INTO #MasterTables ([TableId], [TableName],	[PrimaryKeyNames],[NamespaceId],[IsSelect],[IsInsert],[IsInsertBulk],[IsUpdateBulk],[IsDeleteBulk],[IsSelectByPK],[IsUpdateByPK],[IsDeleteByPK])
		SELECT * FROM OPENXML (@DocHandle, @xpathclause)
		 WITH 
			(
				[TableId] Int,
				[TableName] [nvarchar](128),
				[PrimaryKeyNames] [nvarchar](128),
				[NamespaceId] [int],
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
		INSERT INTO #MasterColumns ([TableName],[ColumnName],[ColumnNamePascal],[ColumnNameCamel])
		SELECT * FROM OPENXML (@DocHandle, @xpathclause)
		 WITH 
			(
				[TableName] [nvarchar](128),
				[ColumnName] [nvarchar](128),
				[ColumnNamePascal] [nvarchar](128),
				[ColumnNameCamel] [nvarchar](128)
			)	

		IF @IsTesting = 'True'
		BEGIN
			SELECT * FROM #MasterTables
			SELECT * FROM #MasterColumns
		END
			
		IF @IsTesting = 'False'
		BEGIN
			
			UPDATE [mt] SET [mt].[CGEN_NamespaceId]=[tt].[NamespaceId], [mt].[IsSelect]=[tt].[IsSelect], [mt].[IsInsert]=[tt].[IsInsert], [mt].[IsUpdateByPK]=[tt].[IsUpdateByPK]
				, [mt].[IsSelectByPK]=[tt].[IsSelectByPK], [mt].[IsDeleteByPK]=[tt].[IsDeleteByPK]
				,[mt].[IsInsertBulk]=[tt].[IsInsertBulk], [mt].[IsUpdateBulk]=[tt].[IsUpdateBulk], [mt].[IsDeleteBulk]=[tt].[IsDeleteBulk]
				,[mt].[IsGenerateCode]='True'
			FROM [#MasterTables] [tt]
			JOIN [CGEN_MasterTable] [mt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[CGEN_MasterTableId]=[tt].[TableId]
			
			UPDATE [mc] SET [mc].[ColumnNamePascal]=[tc].[ColumnNamePascal], [mc].[ColumnNameCamel]=[tc].[ColumnNameCamel]				
			FROM [#MasterTables] [tt]
			JOIN [CGEN_MasterTable] [mt] ON [mt].[CGEN_MasterDatabaseId]=@DataBaseId AND [mt].[CGEN_MasterTableId]=[tt].[TableId]
			JOIN [CGEN_MasterTableColumn] [mc] ON [mc].[CGEN_MasterTableId]=[mt].[CGEN_MasterTableId]
			JOIN #MasterColumns [tc] ON [tc].[TableName]=[mt].[TableName] AND [tc].[ColumnName]=[mc].[ColumnName]
			
		END
		
		
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
		@ProcName+ ' ',
			@xmlMetadata
			FOR XML PATH ('')
			),1,0,'')
	EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation

END CATCH


GO

