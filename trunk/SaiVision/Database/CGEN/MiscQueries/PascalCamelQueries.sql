SELECT dbo.CGEN_fnToPascalCase('PIMW_StepRule_Notification_Id', 'True', 'PIMW', 'PimWorkflow')
SELECT dbo.CGEN_fnToPascalCase('API_NOTIFICATION_NotificationFeedID', 'True', 'API_NOTIFICATION_NotificationFeed', 'ApiNotificationFeed')
SELECT dbo.CGEN_fnToCamelCase('API_NOTIFICATION_NotificationFeedId', 'True', 'API_NOTIFICATION_NotificationFeed', 'apiNotificationFeed')

SELECT dbo.CGEN_fnToPascalCase('API_NOTIFICATION_NotificationFeedId', 'True', 'API_NOTIFICATION', 'api')
SELECT dbo.CGEN_fnToCamelCase('API_NOTIFICATION_NotificationFeedId', 'True', 'API_NOTIFICATION', 'api')

SELECT dbo.CGEN_fnToPascalCase('alert_message_template', 'False', null, null)
SELECT dbo.CGEN_fnToCamelCase('alert_message_template', 'False', null, null)

SELECT dbo.CGEN_fnToPascalCase('PIMW_StepRule_ID', 'True', 'PIMW', 'PimWorkflow')
SELECT dbo.CGEN_fnToCamelCase('PIMW_StepRule_id', 'True', 'PIMW', 'PimWorkflow')

SELECT dbo.CGEN_fnToPascalCase('PROGRAM_Instructions', 'True', 'PROGRAM_Instructions', 'ProgramInstructions')
SELECT dbo.CGEN_fnToCamelCase('PROGRAM_Instructions', 'True', 'PROGRAM_Instructions', 'ProgramInstructions')

SELECT dbo.CGEN_fnToPascalCase('PROGRAM_Instructions', 'False', '', '')
SELECT dbo.CGEN_fnToCamelCase('ProgramID', 'True', 'PROGRAM_Instructions', 'ProgramInstructions')


SELECT dbo.CGEN_fnToPascalCase('API_NOTIFICATION_NotificationFeedId', 'True', 'API_NOTIFICATION', 'Api')
SELECT [dbo].[CGEN_fnTruncatePrefix]('PROGRAM_Instructions', 'False', '', '')
SELECT [dbo].[CGEN_fnTruncatePrefix]('PIMW_StepRule_id', 'True', 'PIMW', 'PimWorkflow')
SELECT [dbo].[CGEN_fnIsAllCaps]('ACTIVITY_TEST')
SELECT [dbo].[CGEN_fnToPascalCaseStrict]('program_instructions')