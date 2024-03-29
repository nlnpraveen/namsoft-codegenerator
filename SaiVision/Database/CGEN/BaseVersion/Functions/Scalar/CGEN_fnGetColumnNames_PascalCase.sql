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


