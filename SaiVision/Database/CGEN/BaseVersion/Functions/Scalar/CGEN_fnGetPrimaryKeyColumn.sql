USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[ERRORLOG_fnGetIdentifier]    Script Date: 09/04/2012 18:14:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn]    Script Date: 03/12/2012 17:38:11 ******/
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
  
CREATE FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn]
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
		SELECT @PKColumnName=COALESCE(@PKColumnName+',', '') + sc.[name] 
		FROM 
		syscolumns sc
		INNER JOIN sysindexkeys sik ON sc.colid=sik.colid AND sc.id=sik.id AND sc.id = OBJECT_ID(@TableName) AND sik.indid=@IndId
	
		/*
		SELECT @PKColumnName=sc.[name]
		FROM 
		syscolumns sc
		INNER JOIN sysindexkeys sik ON sc.colid=sik.colid AND sc.id=sik.id AND sc.id = OBJECT_ID(@TableName) AND sik.indid=@IndId
		*/
		RETURN @PKColumnName
	END
	RETURN Null
	-----------------------------

END

