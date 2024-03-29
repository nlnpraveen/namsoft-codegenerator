USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udf_SearchReferences]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[udf_SearchReferences]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_SearchReferences]    Script Date: 03/12/2012 17:34:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_SearchReferences] ( @SearchString As VarChar(255) )

-- ==========================================================================
-- Username:    pnamburi
-- Action:      Create
-- Action date: 2011.08.20
-- Usage:       SELECT * FROM [dbo].[udf_SearchReferences]('<search_string>')
--              Input: Search String (ex: Name of Table, SP, etc...)
--              Output: All Objects that reference the search string
-- ==========================================================================

RETURNS @SearchResults TABLE ( [object_name] VarChar(255), [object_type] VarChar(255), [number_of_occurrences] Int )

BEGIN

  SELECT @SearchString = '%' + @SearchString + '%'

  INSERT INTO @SearchResults ( [object_name], [object_type], [number_of_occurrences] )
  SELECT      [object_name] = [name]
             ,[object_type] = CASE 
                                WHEN ObjectProperty([syso].[id], 'IsProcedure') = 1 THEN 'Stored Procedure'
                                WHEN ObjectProperty([syso].[id], 'IsView') = 1 THEN 'View'
                                WHEN ObjectProperty([syso].[id], 'IsInlineFunction') = 1 THEN 'Inline Function'
                                WHEN ObjectProperty([syso].[id], 'IsScalarFunction') = 1 THEN 'Scalar Function'
                                WHEN ObjectProperty([syso].[id], 'IsTableFunction') = 1 THEN 'Table Function'
                                WHEN ObjectProperty([syso].[id], 'IsTrigger') = 1 THEN 'Trigger'
                              END
             ,[number_of_occurrences] = Count(*)
  FROM        [syscomments] [sysc]
  INNER JOIN  [sysobjects] [syso] ON [sysc].[id] = [syso].[id]
  WHERE       PatIndex(@SearchString, [sysc].[text]) > 0
  GROUP BY    [syso].[name], [syso].[id]
  ORDER BY    [object_name], [object_type]

  ------
  RETURN
  ------

END