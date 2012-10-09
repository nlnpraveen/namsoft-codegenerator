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


