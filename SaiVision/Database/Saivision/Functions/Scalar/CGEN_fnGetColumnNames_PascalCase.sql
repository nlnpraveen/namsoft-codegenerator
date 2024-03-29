USE [SaiVision]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_PascalCase]    Script Date: 03/12/2012 17:37:21 ******/
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
  
ALTER FUNCTION [dbo].[CGEN_fnGetColumnNames_PascalCase]
( 
	@TableName nvarchar(128), @ColumnNames nvarchar(128)    
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
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + ',', '') + [dbo].CGEN_fnToPascalCase(ct.[ColumnName], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM @ckColumnsTable [ct]
		LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=@TableName AND [co].[ColumnName]=ct.[ColumnName]		
		LEFT JOIN [CGEN_MasterTable] [t] ON [t].[TableName]=@TableName
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END

