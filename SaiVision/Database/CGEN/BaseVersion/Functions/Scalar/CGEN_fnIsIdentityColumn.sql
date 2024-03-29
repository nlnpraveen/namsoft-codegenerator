USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsIdentityColumn]    Script Date: 08/10/2012 17:07:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsIdentityColumn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsIdentityColumn]
GO

USE [CodeGenerator]
GO

/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsIdentityColumn]    Script Date: 08/10/2012 17:07:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[CGEN_fnIsIdentityColumn]
( 
	@TableName nvarchar(128), @ColumnName nvarchar(128)    
)  
RETURNS Bit

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Returns true if it is an identity 
--				  column
-- =============================================

BEGIN
	DECLARE @IsIdentityColumn Bit
	
	SELECT @IsIdentityColumn=COLUMNPROPERTY(OBJECT_ID(@TableName), @ColumnName, 'IsIdentity')

	RETURN @IsIdentityColumn
END
GO

