USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnsWhereFilter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnsWhereFilter]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnsWhereFilter]    Script Date: 03/12/2012 17:37:39 ******/
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
  
CREATE FUNCTION [dbo].[CGEN_fnGetColumnsWhereFilter]
( 
	@ColumnNames nvarchar(128)    
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
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + ' AND ', '') + [ColumnName] + ' = @' + [ColumnName]
		FROM @ckColumnsTable
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END

