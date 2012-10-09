USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 08/20/2012 17:23:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPkColumnsJoinClause]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPkColumnsJoinClause]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 08/20/2012 17:23:40 ******/
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

