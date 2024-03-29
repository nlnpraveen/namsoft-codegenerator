USE [SaiVision]
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
  
ALTER FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]
( 
	@TableName nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

    DECLARE @IndId Int, @PKColumnName NVarChar(128)

	SELECT 	@IndId=indid 
	FROM 	sysindexes
	WHERE 	id = OBJECT_ID(@TableName)
	AND 	indid BETWEEN 1 AND 254 
	AND 	(status & 2048) = 2048	

	-----------------------------
	IF @IndId Is Not Null
	BEGIN
		SELECT @PKColumnName=COALESCE(@PKColumnName+',', '') + [dbo].CGEN_fnToCamelCase(sc.[name], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM 
		syscolumns sc
		JOIN sysindexkeys sik ON sc.colid=sik.colid AND sc.id=sik.id AND sc.id = OBJECT_ID(@TableName) AND sik.indid=@IndId
		JOIN [CGEN_MasterTable] [t] ON [t].[TableName]=OBJECT_NAME(sc.id)
		LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[t].[TableName] AND [co].[ColumnName]=sc.[name]
	
		RETURN @PKColumnName
	END
	RETURN Null
	-----------------------------

END

