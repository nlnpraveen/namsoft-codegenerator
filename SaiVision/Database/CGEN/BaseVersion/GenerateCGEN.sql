USE [master]
GO
/****** Object:  Database [CodeGenerator]    Script Date: 07/26/2012 16:10:25 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'CodeGenerator')
BEGIN
CREATE DATABASE [CodeGenerator] ON  PRIMARY 
( NAME = N'CodeGenerator', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CodeGenerator.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CodeGenerator_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CodeGenerator_log.ldf' , SIZE = 15040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END
GO
ALTER DATABASE [CodeGenerator] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CodeGenerator].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CodeGenerator] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CodeGenerator] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CodeGenerator] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CodeGenerator] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CodeGenerator] SET ARITHABORT OFF
GO
ALTER DATABASE [CodeGenerator] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CodeGenerator] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CodeGenerator] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CodeGenerator] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CodeGenerator] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CodeGenerator] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CodeGenerator] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CodeGenerator] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CodeGenerator] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CodeGenerator] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CodeGenerator] SET  DISABLE_BROKER
GO
ALTER DATABASE [CodeGenerator] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CodeGenerator] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CodeGenerator] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CodeGenerator] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CodeGenerator] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CodeGenerator] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CodeGenerator] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [CodeGenerator] SET  READ_WRITE
GO
ALTER DATABASE [CodeGenerator] SET RECOVERY FULL
GO
ALTER DATABASE [CodeGenerator] SET  MULTI_USER
GO
ALTER DATABASE [CodeGenerator] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CodeGenerator] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'CodeGenerator', N'ON'
GO
USE [CodeGenerator]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScript]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScript]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScriptByActionType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcBodyStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_SelectMaster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPkColumnsJoinClause]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPkColumnsJoinClause]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_CamelCase]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnNames_CamelCase]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_PascalCase]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnNames_PascalCase]
GO
/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns]'))
DROP VIEW [dbo].[vwCGEN_Columns]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToCamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToCamelCase]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCase]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToPascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToPascalCase]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnsWhereFilter]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnsWhereFilter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetColumnsWhereFilter]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTruncatePrefix]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnTruncatePrefix]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnTruncatePrefix]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcCreateStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcErrorHandlerStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetPrimaryKeyColumn]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetPrimaryKeyColumn]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetPrimaryKeyColumn]
GO
/****** Object:  View [dbo].[vwCGEN_Columns_DataTypesSupported]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns_DataTypesSupported]'))
DROP VIEW [dbo].[vwCGEN_Columns_DataTypesSupported]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Select]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_Metadata_Select]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetForeignKeyColumns]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetForeignKeyColumns]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetForeignKeyColumns]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetUniqueConstraintColumns]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetUniqueConstraintColumns]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetUniqueConstraintColumns]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetUniqueConstraintNames]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetUniqueConstraintNames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GetUniqueConstraintNames]
GO
/****** Object:  Table [dbo].[CGEN_MasterTable]    Script Date: 07/26/2012 16:19:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsSelect]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsSelect]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_Master_IsInsert]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_Master_IsInsert]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsIns__2942188C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsIns__2942188C]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsUpd__39788055]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsUpd__39788055]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CGEN_Mast__IsDel__3A6CA48E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF__CGEN_Mast__IsDel__3A6CA48E]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsSelectByPK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsUpdateByPK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsDelete]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsActive]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsCompositePrimaryKey]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsCompositePrimaryKey]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_Master_IsChangePrefix]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_Master_IsChangePrefix]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_IsTruncatePrefix_Column]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_IsTruncatePrefix_Column]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTable_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTable] DROP CONSTRAINT [DF_CGEN_MasterTable_CreateDate]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTable]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTable]
GO
/****** Object:  Table [dbo].[CGEN_MasterTableColumnFilter]    Script Date: 07/26/2012 16:19:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnOperation_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnFilter] DROP CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsActive]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTableColumnFilter]
GO
/****** Object:  Table [dbo].[CGEN_MasterTableColumnPrefixOverride]    Script Date: 07/26/2012 16:19:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CGEN_MasterTableColumnPrefixOverride_IsTruncatePrefix]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CGEN_MasterTableColumnPrefixOverride] DROP CONSTRAINT [DF_CGEN_MasterTableColumnPrefixOverride_IsTruncatePrefix]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnPrefixOverride]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_MasterTableColumnPrefixOverride]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcHeader]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcHeader]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcHeader]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcDropStmt]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcDropStmt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcDropStmt]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Split]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_SearchReferences]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udf_SearchReferences]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[udf_SearchReferences]
GO
/****** Object:  StoredProcedure [dbo].[udp_PrintIndexes]    Script Date: 07/26/2012 16:19:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udp_PrintIndexes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[udp_PrintIndexes]
GO
/****** Object:  Table [dbo].[CGEN_DataTypes]    Script Date: 07/26/2012 16:19:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_DataTypes]') AND type in (N'U'))
DROP TABLE [dbo].[CGEN_DataTypes]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCaseStrict]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToPascalCaseStrict]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnToPascalCaseStrict]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTrimUnderscores]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnTrimUnderscores]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnTrimUnderscores]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsAllCaps]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsAllCaps]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsAllCaps]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsTablePrimaryKeyPresent]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsTablePrimaryKeyPresent]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnIsTablePrimaryKeyPresent]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn]    Script Date: 07/26/2012 16:19:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn]
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
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
		SELECT @PKColumnName=COALESCE(@PKColumnName+'','', '''') + sc.[name] 
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

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsTablePrimaryKeyPresent]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsTablePrimaryKeyPresent]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Retunrs true if the table has a primary key
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnIsTablePrimaryKeyPresent]
( 
	@TableName nvarchar(128)    
)  

RETURNS BIT 
AS  

BEGIN 

    DECLARE @IndId Int

	SELECT 	@IndId=indid 
	FROM 	sysindexes
	WHERE 	id = OBJECT_ID(@TableName)
	AND 	indid BETWEEN 1 AND 254 
	AND 	(status & 2048) = 2048


	-----------------------------
	IF @IndId Is Null
		RETURN 0
	RETURN 1
	-----------------------------

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnIsAllCaps]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnIsAllCaps]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[CGEN_fnIsAllCaps]
	(@Input nVarChar(128))
RETURNS Bit

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @IsAllCaps Bit
	
	SELECT @IsAllCaps=
		CASE 
			WHEN @Input = UPPER(@Input) COLLATE Latin1_General_CS_AI  
			THEN ''True'' ELSE ''False''
		END 

	RETURN @IsAllCaps
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTrimUnderscores]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnTrimUnderscores]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.25  
-- Description:   Trims the left and right underscores if present
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnTrimUnderscores]
( 
	@Input nVarChar(128)
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @uIndex Int
	SELECT @uIndex = PATINDEX(''[_]%'', @Input)
	IF @uIndex > 0
	SELECT @Input=SUBSTRING(@Input, 2, LEN(@Input)-1)
	SELECT @uIndex = PATINDEX(''%[_]'', @Input)
	IF @uIndex > 0
	SELECT @Input=SUBSTRING(@Input, 1, LEN(@Input)-1)

	RETURN @Input

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCaseStrict]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToPascalCaseStrict]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[CGEN_fnToPascalCaseStrict]
	(@Input nVarChar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @PascalStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	
	SELECT @PascalStr='''', @StrLen=LEN(@Input), @Index=1, @Reset = 1
	
	-- Check Emptiness
	IF @Input=''_''
		RETURN ''''
	
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @PascalStr = @PascalStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
		   @Reset = CASE WHEN @Chr LIKE ''[a-zA-Z]'' THEN 0 ELSE 1 END, @Index = @Index + 1				
	END
	
	RETURN @PascalStr	
END' 
END
GO
/****** Object:  Table [dbo].[CGEN_DataTypes]    Script Date: 07/26/2012 16:19:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_DataTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CGEN_DataTypes](
	[DataTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CGEN_DataTypes_1] PRIMARY KEY CLUSTERED 
(
	[DataTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[udp_PrintIndexes]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udp_PrintIndexes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[udp_PrintIndexes] 
	@TableName As VarChar(255)

-- ==========================================================================
-- Username:    pnamburi
-- Action:      Create
-- Action date: 2011.02.17
-- Usage:       Prints all the indexes that are present on a table
-- ==========================================================================
-- Username:    pnamburi
-- Action:      Update
-- Action date: 2011.04.11
-- Usage:       Resolved varchar(max) length issues
-- ==========================================================================

As

BEGIN
	SET NOCOUNT ON;

	DECLARE @IndexSqlTable Table (Id Int Identity Primary Key, IndexSql VarChar(MAX))
	--DECLARE @TableName VarChar(255)
	DECLARE @Id Int, @ISql VarChar(MAX)

	--SELECT @TableName=''RKG_Recognition''

	DECLARE cIX CURSOR FOR
		SELECT OBJECT_NAME(SI.Object_ID), SI.Object_ID, SI.Name, SI.Index_ID
		FROM Sys.Indexes SI 
		 LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC ON SI.Name = TC.CONSTRAINT_NAME AND OBJECT_NAME(SI.Object_ID) = TC.TABLE_NAME
		WHERE TC.CONSTRAINT_NAME IS NULL
		 AND OBJECTPROPERTY(SI.Object_ID, ''IsUserTable'') = 1 		 
		 AND OBJECT_NAME(SI.Object_ID)=@TableName
		ORDER BY OBJECT_NAME(SI.Object_ID), SI.Index_ID 

	DECLARE @IxTable SYSNAME, @IxTableID INT, @IxName SYSNAME, @IxID INT, @nLine Char(2), @cTAB char(1)
	DECLARE @IndexSql VARCHAR(MAX) 

	SELECT @nline = char(13) + char(10), @cTAB = char(9)

	-- Loop through all indexes
	OPEN cIX
	FETCH NEXT FROM cIX INTO @IxTable, @IxTableID, @IxName, @IxID
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @IndexSql = ''CREATE ''
		Insert Into @IndexSqlTable VALUES(''CREATE '')

		-- Check if the index is unique
		IF (INDEXPROPERTY(@IxTableID, @IxName, ''IsUnique'') = 1)
		BEGIN
			SET @IndexSql = @IndexSql + ''UNIQUE ''
			Insert Into @IndexSqlTable VALUES(''UNIQUE '')

		END
		-- Check if the index is clustered
		IF (INDEXPROPERTY(@IxTableID, @IxName, ''IsClustered'') = 1)
		BEGIN
			SET @IndexSql = @IndexSql + ''CLUSTERED ''
			Insert Into @IndexSqlTable VALUES(''CLUSTERED '')
			
		END		
		ELSE
		BEGIN 
			SET @IndexSql = @IndexSql + ''NONCLUSTERED ''
			Insert Into @IndexSqlTable VALUES(''NONCLUSTERED '')
		END

		SET @IndexSql = @IndexSql + ''INDEX ['' + @IxName + ''] ON [dbo].['' + @IxTable + ''] '' + @nline + ''(''
		Insert Into @IndexSqlTable VALUES( ''INDEX ['' + @IxName + ''] ON [dbo].['' + @IxTable + ''] '' + @nline + ''('')

		-- Get all columns of the index
		DECLARE cIxColumn CURSOR FOR 
			SELECT SC.Name, IC.[is_descending_key]
			FROM Sys.Index_Columns IC
			 JOIN Sys.Columns SC ON IC.Object_ID = SC.Object_ID AND IC.Column_ID = SC.Column_ID
			WHERE IC.Object_ID = @IxTableID AND Index_ID = @IxID AND IC.[is_included_column]=0
			ORDER BY IC.Index_Column_ID

		DECLARE @IxColumn SYSNAME, @IsDescendingKey Bit, @HasIncludedColumns Bit
		DECLARE @IxFirstColumn BIT SET @IxFirstColumn = 1
		SET @HasIncludedColumns=''False''
		-- Loop throug all columns of the index and append them to the CREATE statement
		OPEN cIxColumn
		FETCH NEXT FROM cIxColumn INTO @IxColumn, @IsDescendingKey
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
		  IF (@IxFirstColumn = 1)
			 SET @IxFirstColumn = 0
		  ELSE
			BEGIN
				 SET @IndexSql = @IndexSql + '', ''
				Insert Into @IndexSqlTable VALUES('', '')
			END

		  SET @IndexSql = @IndexSql + @nline + @cTAB + ''['' + @IxColumn + '']'' + CASE @IsDescendingKey WHEN 1 THEN '' DESC'' ELSE '' ASC'' END
				Insert Into @IndexSqlTable VALUES(@nline + @cTAB + ''['' + @IxColumn + '']'' + CASE @IsDescendingKey WHEN 1 THEN '' DESC'' ELSE '' ASC'' END)

		  FETCH NEXT FROM cIxColumn INTO @IxColumn, @IsDescendingKey
		END
		CLOSE cIxColumn
		DEALLOCATE cIxColumn

		SET @IndexSql = @IndexSql + @nline + '')''
		Insert Into @IndexSqlTable VALUES(@nline + '')'')

		DECLARE cIxColumn CURSOR STATIC FOR 
			SELECT SC.Name
			FROM Sys.Index_Columns IC
			 JOIN Sys.Columns SC ON IC.Object_ID = SC.Object_ID AND IC.Column_ID = SC.Column_ID
			WHERE IC.Object_ID = @IxTableID AND Index_ID = @IxID AND IC.[is_included_column]=1
			ORDER BY IC.Index_Column_ID
		SET @IxFirstColumn = 1

		OPEN cIxColumn
		
		IF @@CURSOR_ROWS > 0
		BEGIN
			SET @IndexSql = @IndexSql + @nline + ''INCLUDE ''+ @nline + ''(''
			Insert Into @IndexSqlTable VALUES(@nline + ''INCLUDE ''+ @nline + ''('')
			SET @HasIncludedColumns=''True''
		END

		FETCH NEXT FROM cIxColumn INTO @IxColumn
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF (@IxFirstColumn = 1)
				SET @IxFirstColumn = 0
			ELSE
			BEGIN
				SET @IndexSql = @IndexSql + '', ''
				Insert Into @IndexSqlTable VALUES('', '')
			END

			SET @IndexSql = @IndexSql + @nline + @cTAB + ''['' + @IxColumn + '']'' 
			Insert Into @IndexSqlTable VALUES(@nline + @cTAB + ''['' + @IxColumn + '']'')

			FETCH NEXT FROM cIxColumn INTO @IxColumn
		END
		CLOSE cIxColumn
		DEALLOCATE cIxColumn

		IF @HasIncludedColumns=''True''
		BEGIN
			SET @IndexSql = @IndexSql + @nline + '') ''
			Insert Into @IndexSqlTable VALUES(@nline + '') '')
		END

		SET @IndexSql = @IndexSql + @nline + ''WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]''
			Insert Into @IndexSqlTable VALUES(@nline + ''WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMAR
Y]'')
		SET @IndexSql = @IndexSql + @nline 
			Insert Into @IndexSqlTable VALUES(@nline)
		SET @IndexSql = @IndexSql + @nline + ''---------------------------------------------------------------------------------''
			Insert Into @IndexSqlTable VALUES(@nline + ''---------------------------------------------------------------------------------'')
			Insert Into @IndexSqlTable VALUES(@nline)

		-- Print out the CREATE statement for the index
		--PRINT @IndexSql

		FETCH NEXT FROM cIX INTO @IxTable, @IxTableID, @IxName, @IxID
	END

	CLOSE cIX
	DEALLOCATE cIX

	/*SET @IndexSql=''''
	SELECT @IndexSql=Convert(VarChar(MAX), @IndexSql)+Convert(VarChar(MAX), IndexSql) FROM @IndexSqlTable ORDER BY Id
	SELECT @IndexSql = @IndexSql + N''Hello''
	PRINT @IndexSql*/

	SELECT @ISql='''', @IndexSql=''''
	WHILE EXISTS(SELECT ''X'' FROM @IndexSqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @ISql=IndexSql FROM @IndexSqlTable

		IF LEN(@IndexSql) > 4000
		BEGIN
			PRINT @IndexSql
			SET @IndexSql = ''''
		END
		SET @IndexSql = @IndexSql + @ISql

		DELETE FROM @IndexSqlTable WHERE Id=@Id
	END
	PRINT @IndexSql
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[udf_SearchReferences]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udf_SearchReferences]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[udf_SearchReferences] ( @SearchString As VarChar(255) )

-- ==========================================================================
-- Username:    pnamburi
-- Action:      Create
-- Action date: 2011.08.20
-- Usage:       SELECT * FROM [dbo].[udf_SearchReferences](''<search_string>'')
--              Input: Search String (ex: Name of Table, SP, etc...)
--              Output: All Objects that reference the search string
-- ==========================================================================

RETURNS @SearchResults TABLE ( [object_name] VarChar(255), [object_type] VarChar(255), [number_of_occurrences] Int )

BEGIN

  SELECT @SearchString = ''%'' + @SearchString + ''%''

  INSERT INTO @SearchResults ( [object_name], [object_type], [number_of_occurrences] )
  SELECT      [object_name] = [name]
             ,[object_type] = CASE 
                                WHEN ObjectProperty([syso].[id], ''IsProcedure'') = 1 THEN ''Stored Procedure''
                                WHEN ObjectProperty([syso].[id], ''IsView'') = 1 THEN ''View''
                                WHEN ObjectProperty([syso].[id], ''IsInlineFunction'') = 1 THEN ''Inline Function''
                                WHEN ObjectProperty([syso].[id], ''IsScalarFunction'') = 1 THEN ''Scalar Function''
                                WHEN ObjectProperty([syso].[id], ''IsTableFunction'') = 1 THEN ''Table Function''
                                WHEN ObjectProperty([syso].[id], ''IsTrigger'') = 1 THEN ''Trigger''
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

END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[Split] (
@str_in VARCHAR(8000),
@separator VARCHAR(4) )
RETURNS @strtable TABLE (strval VARCHAR(8000))

AS
/*******************************************************************************
* Stored Procedure Name: Split
*                                               
* Creation Date: 8/20/2007
*	
* Praveen Namburi
*
*******************************************************************************/

BEGIN
DECLARE @Occurrences INT, @Counter INT, @tmpStr VARCHAR(8000)

SET @Counter = 0
IF SUBSTRING(@str_in,LEN(@str_in),1) <> @separator
	SET @str_in = @str_in + @separator

SET @Occurrences = (DATALENGTH(REPLACE(@str_in,@separator,@separator+''#'')) - DATALENGTH(@str_in))/ DATALENGTH(@separator)
SET @tmpStr = @str_in

WHILE @Counter <= @Occurrences 

BEGIN
	SET @Counter = @Counter + 1
	INSERT INTO @strtable VALUES ( SUBSTRING(@tmpStr,1,CHARINDEX(@separator,@tmpStr)-1))
	SET @tmpStr = SUBSTRING(@tmpStr,CHARINDEX(@separator,@tmpStr)+1,8000)

	IF DATALENGTH(@tmpStr) = 0
	BREAK
END

RETURN 
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcDropStmt]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcDropStmt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the drop statement for a procedure
-- =============================================
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcDropStmt]
( 
	@ProcName NVarChar(200)
)  
As

BEGIN 

    DECLARE @DropStmt NVarChar(MAX), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	

	SET		@cTAB = char(9)
	SET		@Indent = ''   ''
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	Insert Into #SqlTable VALUES(''IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''''[dbo].[''+@ProcName+'']'''') AND type in (N''''P'''', N''''PC''''))'' + @nline)
	Insert Into #SqlTable VALUES(@cTAB+ ''DROP PROCEDURE dbo.[''+@ProcName+'']'' + @nline)---
	Insert Into #SqlTable VALUES(''GO'')
	
	/*
	SELECT @SqlStr='''', @SqlStrTemp=''''
	WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr	
	*/	
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcHeader]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcHeader]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the header text for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.06.28
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.20
-- Description:		Handle bulk update, delete
-- =============================================
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcHeader]
( 
	@TableName NVarChar(128),
	@ActionType VarChar(100)	    
)  

AS  

BEGIN 

    DECLARE @Header NVarChar(MAX), @Date varchar(50), @Description NVarChar(2000)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)	

	SET		@cTAB = char(9)
	SET		@Indent = ''   ''
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	IF @ActionType = ''Select''
		SET @Description = ''Selects all records from the '' + @TableName + '' table''
	ELSE IF @ActionType IN (''SelectByColumns'' , ''SelectByPK'')
		SET @Description = ''Selects records from the '' + @TableName + '' table filtered by the parameters passed''
	ELSE IF @ActionType = ''Insert''
		SET @Description = ''Inserts a record into the '' + @TableName + '' table''
	ELSE IF @ActionType = ''InsertBulk''
		SET @Description = ''Inserts a recordset into the '' + @TableName + '' table''
	ELSE IF @ActionType = ''UpdateBulk''
		SET @Description = ''Updates a set of records in '' + @TableName + '' table''
	ELSE IF @ActionType = ''DeleteBulk''
		SET @Description = ''Deletes a set of records in the  '' + @TableName + '' table''
	ELSE IF @ActionType = ''UpdateByPK''
		SET @Description = ''Updates a record in the '' + @TableName + '' table''
	ELSE IF @ActionType = ''UpdateByColumns'' 
		SET @Description = ''Updates a record in the '' + @TableName + '' table based on the parameters passed''
	ELSE IF @ActionType = ''DeleteByPK''
		SET @Description = ''Deletes a record in the '' + @TableName + '' table''
	ELSE IF @ActionType = ''DeleteByColumns'' 
		SET @Description = ''Deletes a record in the '' + @TableName + '' table based on the parameters passed''


	Insert Into #SqlTable VALUES(''-- ============================================='' + @nline)
	Insert Into #SqlTable VALUES(''-- Username:'' + @cTAB + @cTAB + ''pnamburi'' + @nline)	
	Insert Into #SqlTable VALUES(''-- Action:'' + @cTAB + @cTAB + @cTAB + ''Create'' + @nline)
	Insert Into #SqlTable VALUES(''-- Action Date:'' + @cTAB + @cTAB + @date + @nline)
	Insert Into #SqlTable VALUES(''-- Description:'' + @cTAB + @cTAB + @Description + @nline)	
	Insert Into #SqlTable VALUES(''-- ============================================='' )
	/*
	SELECT @SqlStr='''', @SqlStrTemp=''''
	WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr		
	*/	
END

' 
END
GO
/****** Object:  Table [dbo].[CGEN_MasterTableColumnPrefixOverride]    Script Date: 07/26/2012 16:19:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnPrefixOverride]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CGEN_MasterTableColumnPrefixOverride](
	[TableName] [nvarchar](128) NOT NULL,
	[ColumnName] [nvarchar](128) NOT NULL,
	[IsTruncatePrefix] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTableColumnPrefixOverride_IsTruncatePrefix]  DEFAULT ((0)),
	[PrefixToTruncate] [nvarchar](128) NULL,
	[PrefixToApply] [nchar](10) NULL,
 CONSTRAINT [PK_CGEN_MasterTableColumnPrefixOverride] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC,
	[ColumnName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CGEN_MasterTableColumnFilter]    Script Date: 07/26/2012 16:19:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTableColumnFilter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CGEN_MasterTableColumnFilter](
	[CGEN_MasterTableColumnFilterId] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[IsSelectByColumns] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsSelectByColumns]  DEFAULT ((0)),
	[IsUpdateByColumns] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsUpdateByColumns]  DEFAULT ((0)),
	[IsDeleteByColumns] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsDeleteByColumns]  DEFAULT ((0)),
	[ColumnNames] [nvarchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTableColumnOperation_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_CGEN_MasterTableColumnOperation] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableColumnFilterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CGEN_MasterTable]    Script Date: 07/26/2012 16:19:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_MasterTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CGEN_MasterTable](
	[CGEN_MasterTableId] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[IsSelect] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsSelect]  DEFAULT ((1)),
	[IsInsert] [bit] NOT NULL CONSTRAINT [DF_CGEN_Master_IsInsert]  DEFAULT ((1)),
	[IsInsertBulk] [bit] NOT NULL CONSTRAINT [DF__CGEN_Mast__IsIns__2942188C]  DEFAULT ((0)),
	[IsUpdateBulk] [bit] NOT NULL CONSTRAINT [DF__CGEN_Mast__IsUpd__39788055]  DEFAULT ((0)),
	[IsDeleteBulk] [bit] NOT NULL CONSTRAINT [DF__CGEN_Mast__IsDel__3A6CA48E]  DEFAULT ((0)),
	[IsSelectByPK] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsSelectByPK]  DEFAULT ((1)),
	[IsUpdateByPK] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsUpdateByPK]  DEFAULT ((1)),
	[IsDeleteByPK] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsDelete]  DEFAULT ((1)),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsActive]  DEFAULT ((1)),
	[IsCompositePrimaryKey] [bit] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_IsCompositePrimaryKey]  DEFAULT ((0)),
	[IsTruncatePrefix_Table] [bit] NOT NULL CONSTRAINT [DF_CGEN_Master_IsChangePrefix]  DEFAULT ((0)),
	[PrefixToTruncate_Table] [nvarchar](128) NULL,
	[PrefixToApply_Table] [nvarchar](128) NULL,
	[IsTruncatePrefix_Column] [bit] NULL CONSTRAINT [DF_CGEN_MasterTable_IsTruncatePrefix_Column]  DEFAULT ((0)),
	[PrefixToTruncate_Column] [nvarchar](128) NULL,
	[PrefixToApply_Column] [nchar](10) NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_CGEN_MasterTable_CreateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_CGEN_MasterTable] PRIMARY KEY CLUSTERED 
(
	[CGEN_MasterTableId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetUniqueConstraintNames]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetUniqueConstraintNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get Unique Constraint Names for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetUniqueConstraintNames]
	@TableName nvarchar(128)
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT DISTINCT RK.Constraint_Name
FROM       
INFORMATION_SCHEMA.TABLE_CONSTRAINTS RK 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RK.Constraint_Type=''Unique'' AND RK.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE RK.TABLE_NAME=@TableName 

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetUniqueConstraintColumns]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetUniqueConstraintColumns]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get Unique Constraint Columns for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetUniqueConstraintColumns]
	@TableName nvarchar(128)
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT DISTINCT RK.Constraint_Name
FROM       
INFORMATION_SCHEMA.TABLE_CONSTRAINTS RK 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RK.Constraint_Type=''Unique'' AND RK.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE RK.TABLE_NAME=@TableName 


SELECT RK.TABLE_NAME, CU.Column_name, RK.Constraint_Name, RK.Constraint_Type
FROM       
INFORMATION_SCHEMA.TABLE_CONSTRAINTS RK 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RK.Constraint_Type=''Unique'' AND RK.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE      RK.TABLE_NAME=@TableName

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetForeignKeyColumns]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetForeignKeyColumns]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get the foreign key columns for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetForeignKeyColumns]
	@TableName nvarchar(128)
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT
       FK.Table_Name, CU.Column_Name, FK.Constraint_Name, FK.Constraint_Type 
FROM       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
WHERE      FK.TABLE_NAME=@TableName AND cu.Column_Name Not In (''LastUpdateUserId'')

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Select]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		01-26-2009
-- Description:		Select all the Nams database metadata
-- =============================================
CREATE PROCEDURE [dbo].[CGEN_Metadata_Select]
As
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------
SET NOCOUNT ON
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, dbo.[CGEN_fnGetPrimaryKeyColumn](TABLE_NAME) As ''PrimaryKey''
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''RM_Role''

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE , COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], ''IsIdentity'') ''IsIdentity''
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ''RM_Role''SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0
--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1
' 
END
GO
/****** Object:  View [dbo].[vwCGEN_Columns_DataTypesSupported]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns_DataTypesSupported]'))
EXEC dbo.sp_executesql @statement = N'


-- =======================================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.03.19
-- Description:   Replaces the information_schema.columns view
--				  to return a list of columns with supported datatypes 
--				  for code generation
-- =======================================================

CREATE VIEW [dbo].[vwCGEN_Columns_DataTypesSupported]
AS


SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME=''JOB_Job''


'
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GetPrimaryKeyColumn]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GetPrimaryKeyColumn]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2009.02.02
-- Description:		Get the foreign key columns for a table
-- =============================================

CREATE PROCEDURE [dbo].[CGEN_GetPrimaryKeyColumn]
	@TableName nvarchar(128),
	@ColumnName nvarchar(128) OUTPUT
As

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------

SET NOCOUNT ON

SELECT @ColumnName=IsNull(dbo.CGEN_fnGetPrimaryKeyColumn(@TableName), '''')

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0

--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcErrorHandlerStmt]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcErrorHandlerStmt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.19
-- Description:   Error handler statement was missing
-- =============================================
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcErrorHandlerStmt]
( 
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
) 
AS  

SET NOCOUNT ON;

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNameDataTypes VarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength int,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable varchar(10),
	@col_DefaultVal nvarchar(4000)

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))


	SET		@cTAB = char(9)
	SET		@Indent = ''   ''
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName)

		
	Insert Into #SqlTable VALUES(@cTAB + ''DECLARE @ErrorInformation NVarChar(MAX), @ProcName VarChar(100), @ErrorLogId NVarChar(100)''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + ''SELECT @ErrorLogId=[dbo].[ERRORLOG_fnGetIdentifier](ERROR_MESSAGE())''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + ''SET @ProcName=OBJECT_NAME(@@ProcId)''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + ''SELECT @ErrorInformation=Stuff((''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''SELECT''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''''''EXEC '''',''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''@ProcName+ '''' ''''''+ @nline)
	--SET @Stmt = @Stmt + @cTAB + @cTAB + @cTAB + ''''''@RoleId='''', IsNull(CONVERT(VarChar, @RoleId), + '''' '''',''+ @nline
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, '','')	
	END	
	
	IF @ActionType In (''Insert'')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '''') + 
		
				'', ''''@'' + col.[COLUMN_NAME] + ''='''', @'' + col.[COLUMN_NAME]
			
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName		
	END
	ELSE IF @ActionType In (''DeleteByPK'', ''SelectByPK'', ''UpdateByPK'')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '''') + 
			CASE 
				--WHEN (@PrimaryKeyColumnName = col.[COLUMN_NAME]) THEN
				WHEN PATINDEX(''%''+col.[COLUMN_NAME]+''%'', @PrimaryKeyColumnName) > 0 THEN
					'', ''''@'' + col.[COLUMN_NAME] + ''='''', @'' + col.[COLUMN_NAME]					
				ELSE ''''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	ELSE IF @ActionType In (''DeleteByColumns'', ''SelectByColumns'', ''UpdateByColumns'')
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '''') + 
			'', ''''@'' + [COLUMN_NAME] + ''='''', @'' + [COLUMN_NAME]					
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName AND col.COLUMN_NAME IN (SELECT [ColumnName] FROM @ckColumnsTable)

		SET @Stmt = @Stmt + @ColNameDataTypes + @nline
	END
	
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + IsNull(@ColNameDataTypes, '''') + @nline)
	
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + ''FOR XML PATH ('''''''')''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + @cTAB + @cTAB + ''),1,0,'''''''')''+ @nline)
	Insert Into #SqlTable VALUES(@cTAB + ''EXEC [ErrorLog_Add] @ErrorLogId, @ProcName, @ErrorInformation''+ @nline)
	
	/*
	SELECT @SqlStr='''', @SqlStrTemp=''''
	WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr
	*/	

END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcCreateStmt]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcCreateStmt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.19
-- Description:   Date datatype should not be assigned a default value
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.20
-- Description:   Default value for small datetime
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Select/Delete by composite PK
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.04.05
-- Description:   Update by columns
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.10
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle UpdateBulk, DeleteBulk
-- =============================================
  
CREATE PROCEDURE [dbo].[CGEN_GenerateProcCreateStmt]
( 
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  
AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNameDataTypes VarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength int,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable varchar(10),
	@col_DefaultVal nvarchar(4000)

	DECLARE @PrimaryKeyColumnName NVarChar(128)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))

	SET		@cTAB = char(9)
	SET		@Indent = ''   ''
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName)

	Insert Into #SqlTable VALUES(''CREATE PROCEDURE [dbo].[''+ @ProcName +'']'' + @nline)
	
	SELECT @ckColumnNames = COALESCE(@ckColumnNames, @PrimaryKeyColumnName)
	
	IF @ckColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ckColumnNames, '','')
	END

	IF @ActionType = ''Insert''
	BEGIN
		DECLARE Columns_Cursor CURSOR FOR 
		SELECT col.[COLUMN_NAME], col.[DATA_TYPE], col.[numeric_precision], col.[numeric_scale], 
		col.[character_maximum_length], col.[IS_NULLABLE], col.[COLUMN_DEFAULT], COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') 
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		OPEN Columns_Cursor
		FETCH NEXT FROM Columns_Cursor INTO @col_ColumnName, @col_TypeName, @col_Precision, @col_Scale, 
		@col_MaxLength, @col_IsNullable, @col_DefaultVal, @col_IsIdentity
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX(''%[()]%'',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX(''%[()]%'', @col_DefaultVal), 1, '''')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + '', '' + @nline, '''') + @cTAB + ''@'' + CASE @col_TypeName WHEN ''uniqueidentifier'' THEN @col_ColumnName + '' '' + ''nvarchar(100)'' ELSE @col_ColumnName + '' '' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName=''decimal'' THEN ''('' + CONVERT(VarChar, @col_Precision) + '', '' + CONVERT(VarChar, @col_Scale) + '')'' 
					WHEN @col_TypeName IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And @col_MaxLength <> -1 THEN ''('' + CONVERT(VarChar, @col_MaxLength) + '')'' 
					WHEN @col_TypeName IN (''varchar'', ''nvarchar'') And @col_MaxLength = -1 THEN ''(MAX)'' 
					ELSE '''' 
				END +
				CASE 
					WHEN @col_IsNullable=''YES'' AND( @col_DefaultVal Is Null Or PATINDEX(''%getdate%'', @col_DefaultVal) > 0) THEN '' = Null'' 
					WHEN 
						@col_DefaultVal Is Not Null 
						AND 
							((@col_TypeName IN (''date'', ''datetime'', ''smalldatetime'') AND PATINDEX(''%getdate%'', @col_DefaultVal)=0)
							Or 
							(@col_TypeName Not IN (''date'', ''datetime'', ''smalldatetime'', ''uniqueidentifier'')))
						THEN '' = '' + @col_DefaultVal
					ELSE '''' 
				END +
				CASE 
				WHEN (@PrimaryKeyColumnName = @col_ColumnName AND (@col_IsIdentity = 1 Or @col_TypeName = ''uniqueidentifier'')) THEN '' OUTPUT''
					ELSE ''''
				END

			FETCH NEXT FROM Columns_Cursor INTO @col_ColumnName, @col_TypeName, @col_Precision, @col_Scale, 
			@col_MaxLength, @col_IsNullable, @col_DefaultVal, @col_IsIdentity
		END

		CLOSE Columns_Cursor
		DEALLOCATE Columns_Cursor

--		SELECT @ColNameDataTypes = 
--			CASE 
--				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
--					COALESCE(@ColNameDataTypes + '', '' + @nline, '''') + @cTAB + ''@'' + col.[COLUMN_NAME] + '' '' + col.[DATA_TYPE] + 
--					CASE 
--						WHEN col.[DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, col.[numeric_precision]) + '', '' + CONVERT(VarChar, col.[numeric_scale]) + '')'' 
--						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And col.character_maximum_length <> -1 THEN ''('' + CONVERT(VarChar, col.character_maximum_length) + '')'' 
--						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'') And col.character_maximum_length = -1 THEN ''(MAX)'' 
--						ELSE '''' 
--					END +
--					CASE 
--						WHEN col.[IS_NULLABLE]=''YES'' AND col.[COLUMN_DEFAULT] Is Null THEN '' = Null'' 
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN (''varchar'', ''char'', ''money'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
--						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN (''datetime'', ''smalldatetime'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
--						ELSE '''' 
--					END 
--				ELSE ''--''
--			END
--		FROM INFORMATION_SCHEMA.COLUMNS col
--		WHERE TABLE_NAME = @TableName
		
		Insert Into #SqlTable VALUES(@ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType IN (''InsertBulk'', ''UpdateBulk'', ''DeleteBulk'')
	BEGIN	
		SET @ColNameDataTypes = ''@DataXml VarChar(MAX)''
		Insert Into #SqlTable VALUES(@cTAB + @ColNameDataTypes)
		Insert Into #SqlTable VALUES(@nline)		
	END
	ELSE IF @ActionType In (''UpdateByPK'', ''UpdateByColumns'') 
	BEGIN
		DECLARE Columns_Cursor CURSOR FOR 
		SELECT col.[COLUMN_NAME], col.[DATA_TYPE], col.[numeric_precision], col.[numeric_scale], 
		col.[character_maximum_length], col.[IS_NULLABLE], col.[COLUMN_DEFAULT], COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') 
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		OPEN Columns_Cursor
		FETCH NEXT FROM Columns_Cursor INTO @col_ColumnName, @col_TypeName, @col_Precision, @col_Scale, 
		@col_MaxLength, @col_IsNullable, @col_DefaultVal, @col_IsIdentity
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @col_DefaultVal Is Not Null
			BEGIN
				WHILE PATINDEX(''%[()]%'',@col_DefaultVal) > 0
					SET @col_DefaultVal = STUFF(@col_DefaultVal, PATINDEX(''%[()]%'', @col_DefaultVal), 1, '''')
			END

			SET @ColNameDataTypes = 
				COALESCE(@ColNameDataTypes + '', '' + @nline, '''') + @cTAB + ''@'' + CASE @col_TypeName WHEN ''uniqueidentifier'' THEN @col_ColumnName + '' '' + ''nvarchar(100)'' ELSE @col_ColumnName + '' '' + @col_TypeName END + 
				CASE 
					WHEN @col_TypeName=''decimal'' THEN ''('' + CONVERT(VarChar, @col_Precision) + '', '' + CONVERT(VarChar, @col_Scale) + '')'' 
					WHEN @col_TypeName IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And @col_MaxLength <> -1 THEN ''('' + CONVERT(VarChar, @col_MaxLength) + '')'' 
					WHEN @col_TypeName IN (''varchar'', ''nvarchar'') And @col_MaxLength = -1 THEN ''(MAX)'' 
					ELSE '''' 
				END +
				CASE 
					WHEN @col_IsNullable=''YES'' AND @col_DefaultVal Is Null THEN '' = Null'' 
					WHEN @col_DefaultVal Is Not Null AND @col_TypeName Not IN (''date'', ''datetime'', ''smalldatetime'', ''uniqueidentifier'') THEN '' = '' + @col_DefaultVal
					ELSE '''' 
				END 

			FETCH NEXT FROM Columns_Cursor INTO @col_ColumnName, @col_TypeName, @col_Precision, @col_Scale, 
			@col_MaxLength, @col_IsNullable, @col_DefaultVal, @col_IsIdentity
		END

		CLOSE Columns_Cursor
		DEALLOCATE Columns_Cursor

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	/*
	ELSE IF @ActionType = ''DeleteByPK'' Or @ActionType = ''SelectByPK''
	BEGIN
		SELECT @ColNameDataTypes = COALESCE(@ColNameDataTypes, '''') + 
			CASE 
				WHEN (@PrimaryKeyColumnName = col.[COLUMN_NAME]) THEN
					@cTAB + ''@'' + col.[COLUMN_NAME] + '' '' + CASE col.[DATA_TYPE] WHEN ''uniqueidentifier'' THEN ''nvarchar(100)'' ELSE col.[DATA_TYPE] END + 
					CASE 
						WHEN col.[DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, col.[numeric_precision]) + '', '' + CONVERT(VarChar, col.[numeric_scale]) + '')'' 
						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And col.character_maximum_length <> -1 THEN ''('' + CONVERT(VarChar, col.character_maximum_length) + '')'' 
						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'') And col.character_maximum_length = -1 THEN ''(MAX)'' 
						ELSE '''' 
					END +
					CASE 
						WHEN col.[IS_NULLABLE]=''YES'' AND col.[COLUMN_DEFAULT] Is Null THEN '' = Null'' 
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN (''varchar'', ''char'', ''money'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN (''date'', ''datetime'', ''smalldatetime'', ''uniqueidentifier'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
						ELSE '''' 
					END 
				ELSE ''''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END
	*/
	ELSE IF @ActionType IN (''DeleteByColumns'', ''SelectByColumns'', ''DeleteByPK'', ''SelectByPK'')
	BEGIN
		SELECT @ColNameDataTypes = 
			COALESCE(@ColNameDataTypes + '', '' + @nline, '''') + 
					@cTAB + ''@'' + col.[COLUMN_NAME] + '' '' + CASE col.[DATA_TYPE] WHEN ''uniqueidentifier'' THEN ''nvarchar(100)'' ELSE col.[DATA_TYPE] END + 
					CASE 
						WHEN col.[DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, col.[numeric_precision]) + '', '' + CONVERT(VarChar, col.[numeric_scale]) + '')'' 
						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And col.character_maximum_length <> -1 THEN ''('' + CONVERT(VarChar, col.character_maximum_length) + '')'' 
						WHEN col.[DATA_TYPE] IN (''varchar'', ''nvarchar'') And col.character_maximum_length = -1 THEN ''(MAX)'' 
						ELSE '''' 
					END +
					CASE 
						WHEN col.[IS_NULLABLE]=''YES'' AND col.[COLUMN_DEFAULT] Is Null THEN '' = Null'' 
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] IN (''varchar'', ''char'', ''money'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 2, LEN(col.[COLUMN_DEFAULT]) - 2)
						WHEN col.[COLUMN_DEFAULT] Is Not Null AND col.[DATA_TYPE] Not IN (''date'', ''datetime'', ''smalldatetime'', ''uniqueidentifier'') THEN '' = '' + Substring(col.[COLUMN_DEFAULT], 3, LEN(col.[COLUMN_DEFAULT]) - 4)
						ELSE '''' 
					END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName AND (col.[COLUMN_NAME] IN (SELECT [ColumnName] FROM @ckColumnsTable))

		Insert Into #SqlTable VALUES(@ColNameDataTypes + @nline)		
	END

	Insert Into #SqlTable VALUES(''As'')

	/*
	SELECT @SqlStr='''', @SqlStrTemp=''''
	WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr
	*/	
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnTruncatePrefix]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnTruncatePrefix]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Removes the prefix appropriately from the string
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnTruncatePrefix]
( 
	@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128)
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

DECLARE @Prefix nVarchar(128), @Str nVarChar(128)
DECLARE @prefixesTable TABLE ([prefix] VARCHAR(8000))

	--Check if required to truncate
	IF ((PATINDEX(''[_]%'', @PrefixToTruncate) > 0 AND LEN(@PrefixToTruncate)=1) Or (@IsTruncatePrefix=''False''))
		RETURN @Input
	
	IF (@PrefixToTruncate Is Not Null) AND (@IsTruncatePrefix=''True'')
	BEGIN
		Insert INTo @prefixesTable([prefix])
		SELECT [strval] FROM [dbo].[Split](@PrefixToTruncate, '','')
		
		--SELECT * FROM @prefixesTable
		
		WHILE EXISTS(SELECT * FROM @prefixesTable)
		BEGIN
			SELECT TOP 1 @Prefix=[prefix] FROM @prefixesTable
			
			IF PATINDEX(@Prefix+''%'', @Input)=1
			BEGIN
				SET @Input=SUBSTRING(@Input, LEN(@Prefix)+1, LEN(@Input)-LEN(@Prefix))
				SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)
				IF @PrefixToApply Is Not Null
				BEGIN
					SET @PrefixToApply = [dbo].[CGEN_fnTrimUnderscores](@PrefixToApply)
					SET @Input=@PrefixToApply + ''_'' + @Input
				END
				BREAK
			END
			DELETE TOP (1) @prefixesTable
		END	
	END
	ELSE IF @IsTruncatePrefix=''True''
	BEGIN
		SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, ''_'')
		IF @Prefix <> @Input
		BEGIN
			SET @Str=SUBSTRING(@Input, LEN(@Prefix)+2, LEN(@Input)-LEN(@Prefix))				
			IF LEN(@Str) > 0		
				SET @Input=@Str
			ELSE
				SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)
		END		
	END
	SET @Input = [dbo].[CGEN_fnTrimUnderscores](@Input)

	RETURN @Input

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnsWhereFilter]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnsWhereFilter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
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
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, '','')
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + '' AND '', '''') + [ColumnName] + '' = @'' + [ColumnName]
		FROM @ckColumnsTable
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToPascalCase]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToPascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[CGEN_fnToPascalCase]
	(@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @PascalStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	-- Check Emptiness
	IF @Input=''_''
		RETURN ''''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @PascalStr = ''''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps=''True'' AND LEN(@Input) > 0
	BEGIN
		SET @PascalStr=[dbo].[CGEN_fnToPascalCase](LOWER(@Input), 0, '''', '''')		
		RETURN @PascalStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, ''_'')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+2, LEN(@Input)-LEN(@Prefix))
		SET @PascalStr=[dbo].[CGEN_fnToPascalCaseStrict](LOWER(@Prefix))				
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 1
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@PascalStr = @PascalStr + 
					CASE WHEN @Chr=''_'' THEN '''' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr=''_'' THEN 1 ELSE 0 END, @Index = @Index + 1
        
        -- For Two Letter Words
        IF @Index=2 AND @StrLen=2
        BEGIN
			SET @Reset=2	 			
		END
		
	END
	
	RETURN @PascalStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @PascalStr = @PascalStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE ''[a-zA-Z]'' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnToCamelCase]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnToCamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[CGEN_fnToCamelCase]
	(@Input nVarChar(128), @IsTruncatePrefix Bit, @PrefixToTruncate nVarchar(128), @PrefixToApply nVarchar(128))
RETURNS Nvarchar(4000)

As

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.01.21  
-- Description:   Retunrs true if all the characters
--				  in this string are upper case
-- =============================================

BEGIN
	DECLARE @CamelStr NVarChar(4000), @StrLen Int, @Index Int, @Chr Char(1), @Reset Int, @Prefix NVarChar(128), @IsAllCaps Bit
	
	-- Check Emptiness
	IF @Input=''_''
		RETURN ''''
	
	-- Remove Prefix
	SELECT @Input=[dbo].[CGEN_fnTruncatePrefix](@Input, @IsTruncatePrefix, @PrefixToTruncate, @PrefixToApply)
	
	SELECT @CamelStr = ''''
	SELECT @IsAllCaps=[dbo].[CGEN_fnIsAllCaps](@Input)
	IF @IsAllCaps=''True'' AND LEN(@Input) > 0
	BEGIN
		SET @CamelStr=[dbo].[CGEN_fnToCamelCase](LOWER(@Input), 0, '''', '''')		
		RETURN @CamelStr	
	END
		
	
	-- Check if the first word is all caps
	SELECT TOP 1 @Prefix=[strval] FROM [dbo].[Split](@Input, ''_'')
	IF @Prefix <> @Input
	BEGIN
		SET @Input=SUBSTRING(@Input, LEN(@Prefix)+1, LEN(@Input)-LEN(@Prefix))
		SET @CamelStr=LOWER(@Prefix)
	END
	
	SELECT @StrLen=LEN(@Input), @Index=1, @Reset = 2
	
	WHILE @Index<=@StrLen
	BEGIN
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), 
				@CamelStr = @CamelStr + 
					CASE WHEN @Chr=''_'' THEN '''' 
						ELSE 
							 CASE WHEN @Reset=1 THEN UPPER(@Chr) WHEN @Reset=2 THEN LOWER(@Chr) ELSE @Chr END
						END,
               @Reset = CASE WHEN @Chr=''_'' THEN 1 ELSE 0 END, @Index = @Index + 1       
		
	END
	
	RETURN @CamelStr
	
	/*
		SELECT @Chr=SUBSTRING(@Input, @Index, 1), @CamelStr = @CamelStr + CASE WHEN @Reset=1 THEN UPPER(@Chr) ELSE LOWER(@Chr) END,
           @Reset = CASE WHEN @Chr LIKE ''[a-zA-Z]'' THEN 0 ELSE 1 END, @Index = @Index + 1		
	*/
END' 
END
GO
/****** Object:  View [dbo].[vwCGEN_Columns]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCGEN_Columns]'))
EXEC dbo.sp_executesql @statement = N'



-- =======================================================
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.07.20
-- Description:   Replaces the information_schema.columns view
--				  to return a list of columns with supported datatypes 
--				  for code generation
-- =======================================================

CREATE VIEW [dbo].[vwCGEN_Columns]
AS

SELECT [c].TABLE_CATALOG, [c].TABLE_SCHEMA, [c].TABLE_NAME, [c].COLUMN_NAME
	,[ColumnNamePascal]=[dbo].CGEN_fnToPascalCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnNameCamel]=[dbo].CGEN_fnToCamelCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[c].COLUMN_DEFAULT, [c].IS_NULLABLE, [c].DATA_TYPE , [c].[character_maximum_length], [c].[numeric_precision], [c].[numeric_scale], [IsIdentity]=COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], ''IsIdentity'') 
FROM INFORMATION_SCHEMA.COLUMNS [c]JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]=''True'' AND [c].[TABLE_NAME]=[t].[TableName]LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		

/*
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, 
	CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE, DATETIME_PRECISION, CHARACTER_SET_CATALOG, CHARACTER_SET_SCHEMA, 
	CHARACTER_SET_NAME, COLLATION_CATALOG, COLLATION_SCHEMA, COLLATION_NAME, DOMAIN_CATALOG, DOMAIN_SCHEMA, DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS [c] 
JOIN [CGEN_DataTypes] [dt] ON [dt].[DataTypeName]=[c].[DATA_TYPE]
--WHERE [c].TABLE_NAME=''JOB_Job''
*/

'
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_PascalCase]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns comma delimited pascal case names
--				  Input: Column Names in a table (comma delimited)
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetColumnNames_PascalCase]
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
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, '','')
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + '','', '''') + [dbo].CGEN_fnToPascalCase(ct.[ColumnName], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM @ckColumnsTable [ct]
		LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=@TableName AND [co].[ColumnName]=ct.[ColumnName]		
		LEFT JOIN [CGEN_MasterTable] [t] ON [t].[TableName]=@TableName
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetColumnNames_CamelCase]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetColumnNames_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Returns comma delimited camel case names
--				  Input: Column Names in a table (comma delimited)
-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		2012.02.05
-- Description:		Composite Keys
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetColumnNames_CamelCase]
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
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, '','')
		
		SELECT @ckPredicates = COALESCE(@ckPredicates + '','', '''') + [dbo].CGEN_fnToCamelCase(ct.[ColumnName], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
		FROM @ckColumnsTable [ct]
		LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=@TableName AND [co].[ColumnName]=ct.[ColumnName]		
		LEFT JOIN [CGEN_MasterTable] [t] ON [t].[TableName]=@TableName
		
		RETURN @ckPredicates
	END	
	RETURN Null
	-----------------------------

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
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
  
CREATE FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_PascalCase]
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
		SELECT @PKColumnName=COALESCE(@PKColumnName+'','', '''') + [dbo].CGEN_fnToPascalCase(sc.[name], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
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

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]    Script Date: 07/26/2012 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
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
  
CREATE FUNCTION [dbo].[CGEN_fnGetPrimaryKeyColumn_CamelCase]
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
		SELECT @PKColumnName=COALESCE(@PKColumnName+'','', '''') + [dbo].CGEN_fnToCamelCase(sc.[name], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
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

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CGEN_fnGetPkColumnsJoinClause]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_fnGetPkColumnsJoinClause]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2012.07.20
-- Description:   Bulk Operations (Insert, Update, Delete)
-- =============================================
  
CREATE FUNCTION [dbo].[CGEN_fnGetPkColumnsJoinClause]
( 
	@TableName nvarchar(128), @ColumnNames nvarchar(128)    
)  

RETURNS nvarchar(128) 
AS  

BEGIN 

	DECLARE @ckColumnsTable TABLE ([ColumnName] VARCHAR(8000))
	DECLARE @joinClause nVarChar(MAX)

	IF @ColumnNames Is Not Null
	BEGIN
		Insert INTo @ckColumnsTable([ColumnName])
		SELECT [strval] FROM [dbo].[Split](@ColumnNames, '','')
		
		SELECT @joinClause = COALESCE(@joinClause + '' AND '', '''') + ''[bt].['' + [co].[Column_Name] + ''] = [tmp].['' + [ColumnNamePascal] + '']''
		FROM @ckColumnsTable [ct]
		JOIN [vwCGEN_Columns] [co] ON [co].[Table_Name]=@TableName AND [co].[Column_Name]=ct.[ColumnName]				
				
		RETURN @joinClause
	END	
	RETURN Null
	-----------------------------

END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_SelectMaster]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_Metadata_SelectMaster]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Username:		pnamburi
-- Action:			Create
-- Action Date:		01-26-2009
-- Description:		Select all the Nams database metadata
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.02.05
-- Description:		Composite Keys
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.23
-- Description:		Insert, Update, Delete bulk functionality
-- =============================================
CREATE PROCEDURE [dbo].[CGEN_Metadata_SelectMaster]
As
--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
--------------------------------------------------------------------------------
-- PROCESSING
--------------------------------------------------------------------------------
SET NOCOUNT ON
SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [TableName] ORDER BY [TableName]), *	,[SelectProc]=CASE [mt].[IsSelect] WHEN ''True'' THEN [mt].[TableNamePascal]+''_Get'' ELSE Null END 
	,[SelectByPKProc]=CASE [mt].[IsSelectByPK] WHEN ''True'' THEN [mt].[TableNamePascal]+''_GetBy_''+REPLACE([PrimaryKeyPascal],'','',''_'') ELSE Null END 
	,[UpdateByPKProc]=CASE [mt].[IsUpdateByPK] WHEN ''True'' THEN [mt].[TableNamePascal]+''_UpdateBy_''+REPLACE([PrimaryKeyPascal],'','',''_'') ELSE Null END 
	,[DeleteByPKProc]=CASE [mt].[IsDeleteByPK] WHEN ''True'' THEN [mt].[TableNamePascal]+''_DeleteBy_''+REPLACE([PrimaryKeyPascal],'','',''_'') ELSE Null END 
	,[InsertBulkProc]=CASE [mt].[IsInsertBulk] WHEN ''True'' THEN [mt].[TableNamePascal]+''_InsertBulk'' ELSE Null END 
	,[UpdateBulkProc]=CASE [mt].[IsUpdateBulk] WHEN ''True'' THEN [mt].[TableNamePascal]+''_UpdateBulk'' ELSE Null END 
	,[DeleteBulkProc]=CASE [mt].[IsDeleteBulk] WHEN ''True'' THEN [mt].[TableNamePascal]+''_DeleteBulk'' ELSE Null END 
	,[SelectByColumnsProc]=CASE [mt].[IsSelectByColumns] WHEN ''True'' THEN [mt].[TableNamePascal]+''_GetBy_''+Replace([QueryColumnsPascal], '','', ''_'') ELSE Null END 
	,[UpdateByColumnsProc]=CASE [mt].[IsUpdateByColumns] WHEN ''True'' THEN [mt].[TableNamePascal]+''_UpdateBy_''+Replace([QueryColumnsPascal], '','', ''_'') ELSE Null END 
	,[DeleteByColumnsProc]=CASE [mt].[IsDeleteByColumns] WHEN ''True'' THEN [mt].[TableNamePascal]+''_DeleteBy_''+Replace([QueryColumnsPascal], '','', ''_'') ELSE Null END 
FROM (	SELECT [mt].[TableName]
		  ,[TableNamePascal]=[dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
		  ,[TableNameCamel]=[dbo].[CGEN_fnToCamelCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
		,[mt].[IsSelect]
		,[mt].[IsInsert]
		,[mt].[IsInsertBulk]
		,[mt].[IsUpdateBulk]
		,[mt].[IsDeleteBulk]
		,[mt].[IsSelectByPK]
		,[mt].[IsUpdateByPK]
		,[mt].[IsDeleteByPK]
		,[mtc].[IsSelectByColumns]
		,[mtc].[IsUpdateByColumns]
		,[mtc].[IsDeleteByColumns]
		,[PrimaryKey]=dbo.[CGEN_fnGetPrimaryKeyColumn]([mt].[TableName])
		,[PrimaryKeyPascal]=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase]([mt].[TableName])
		,[PrimaryKeyCamel]=dbo.[CGEN_fnGetPrimaryKeyColumn_CamelCase]([mt].[TableName])
		,[QueryColumns]=[ColumnNames]
		  ,[QueryColumnsPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[TableName], [mtc].[ColumnNames])
		  ,[QueryColumnsCamel]=[dbo].[CGEN_fnGetColumnNames_CamelCase]([mt].[TableName], [mtc].[ColumnNames])
	FROM [CGEN_MasterTable] [mt] WITH(NOLOCK)
	LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] WITH(NOLOCK) ON [mtc].[IsActive]=''True'' AND [mt].[TableName]=[mtc].[TableName]
	WHERE [mt].[IsActive]=''True''
) [mt]

SELECT [c].TABLE_CATALOG, [c].TABLE_SCHEMA, [TableName]=[c].TABLE_NAME, [ColumnName]=[c].COLUMN_NAME
	,[ColumnNamePascal]=[dbo].CGEN_fnToPascalCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnNameCamel]=[dbo].CGEN_fnToCamelCase([c].[COLUMN_NAME], COALESCE([co].[IsTruncatePrefix], [t].[IsTruncatePrefix_Column], [t].[IsTruncatePrefix_Table]), COALESCE([co].[PrefixToTruncate], [t].[PrefixToTruncate_Column], [t].[PrefixToTruncate_Table]), COALESCE([co].[PrefixToApply], [t].[PrefixToApply_Column], [t].[PrefixToApply_Table]))
	,[ColumnDefault]=[c].COLUMN_DEFAULT, [IsNullable]=[c].IS_NULLABLE, [DataType]=[c].DATA_TYPE , [IsIdentity]=COLUMNPROPERTY( OBJECT_ID(TABLE_NAME), [COLUMN_NAME], ''IsIdentity'') 
FROM INFORMATION_SCHEMA.COLUMNS [c]JOIN [CGEN_MasterTable] [t] ON [t].[IsActive]=''True'' AND [c].[TABLE_NAME]=[t].[TableName]LEFT JOIN [CGEN_MasterTableColumnPrefixOverride] [co] ON [co].[TableName]=[c].[TABLE_NAME] AND [co].[ColumnName]=[c].[COLUMN_NAME]		

SELECT @ErrNo = @@ERROR
IF @ErrNo <> 0  GOTO  ErrHandler
RETURN 0
--------------------------------------------------------------------------------
-- Error Handling
--------------------------------------------------------------------------------
ErrHandler:
	RETURN -1
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcBodyStmt]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcBodyStmt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates the create statement for a procedure
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Handle columns
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29  
-- Description:   CompositeKeys
-- =============================================
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Changes for InsertBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Pass proc name to body proc
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.19
-- Description:   Changes for UpdateBulk, DeleteBulk
-- =============================================  

CREATE PROCEDURE [dbo].[CGEN_GenerateProcBodyStmt]
( 
	@ProcName NVarChar(200),
	@TableName nvarchar(128),
	@ActionType VarChar(100),
	@ckColumnNames nVarchar(128) = Null	    
)  

AS  

BEGIN 

    DECLARE @Stmt NVarChar(MAX), @ColNames VarChar(4000), @Date varchar(50)
	DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
	DECLARE 	@col_oid int,
	@col_ColumnName nvarchar(128),
	@col_MaxLength smallint,
	@col_Precision tinyint,
	@col_Scale tinyint,
	@col_IsIdentity bit,
	@col_TypeName nvarchar(128),
	@col_IsNullable bit

	DECLARE @PrimaryKeyColumnName NVarChar(128), @insColNames VarChar(MAX), @TableNamePascal nvarchar(128), @selColNames VarChar(MAX), @setColNames VarChar(MAX)
	--DECLARE #SqlTable Table (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	--CREATE TABLE #SqlTable (Id Int Identity Primary Key, SqlStr VarChar(MAX))
	DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
	DECLARE @ckPredicates nVarChar(MAX), @pkPredicates nVarChar(MAX)

	SET		@cTAB = char(9)
	SET		@Indent = ''   ''
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName)
	
	IF @ckColumnNames Is Not Null
	BEGIN		
		SELECT @ckPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@ckColumnNames)
	END		
	IF @PrimaryKeyColumnName Is Not Null
	BEGIN		
		SELECT @pkPredicates = [dbo].[CGEN_fnGetColumnsWhereFilter](@PrimaryKeyColumnName)
	END	
	

	SET @Stmt = ''''

	IF @ActionType In (''Select'', ''SelectByColumns'', ''SelectByPK'')
	BEGIN
		SELECT @ColNames = COALESCE(@ColNames + '', '' + @nline, '''') + 
			@cTAB + @cTAB + ''['' + col.[COLUMN_NAME] + '']'' 
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
		Insert Into #SqlTable VALUES(@cTAB + ''SELECT '' + @nline + 
									 @ColNames + @nline + 
									 @cTAB + ''FROM '' + ''dbo.['' + @TableName + '']'')

		IF @ActionType = ''SelectByColumns''
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + ''WHERE '' + @ckPredicates)
			END
		ELSE IF @ActionType = ''SelectByPK''
			BEGIN 
				Insert Into #SqlTable VALUES(@cTAB + ''WHERE '' + @pkPredicates)		
			END

	END
	ELSE IF @ActionType = ''Insert''
	BEGIN
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
					COALESCE(@insColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''['' + col.[COLUMN_NAME] + '']'' 
				ELSE ''--''
			END
			,@ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
					COALESCE(@ColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''@'' + col.[COLUMN_NAME]  
				ELSE ''--''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
	
		Insert Into #SqlTable VALUES(@cTAB + ''INSERT INTO '' + ''[dbo].[''+@TableName + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''('' + IsNull(@insColNames, ''@insColNames is null'') + @nline + @cTAB + '')'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''VALUES'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''(''+IsNull(@ColNames, ''@ColNames is null'') + @nline + @cTAB + '')'')
		Insert Into #SqlTable VALUES(@nline)

		IF EXISTS(SELECT ''X'' FROM INFORMATION_SCHEMA.COLUMNS col
			WHERE TABLE_NAME = @TableName AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'')
		BEGIN
			Insert Into #SqlTable VALUES(@cTAB + ''SET @''+ @PrimaryKeyColumnName + '' = scope_identity()'')
		END

	END
	ELSE IF @ActionType = ''InsertBulk''
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>'''''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
					COALESCE(@insColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''['' + col.[COLUMN_NAME] + '']'' 
				ELSE ''--''
			END
			,@selColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
					COALESCE(@selColNames + '', '' + @nline, '''') + @cTAB + @cTAB + ''['' + CASE [DATA_TYPE] WHEN ''uniqueidentifier'' THEN [COLUMN_NAME] + ''] '' + ''nvarchar(100)'' ELSE [COLUMN_NAME] + ''] '' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, [numeric_precision]) + '', '' + CONVERT(VarChar, [numeric_scale]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And [character_maximum_length] <> -1 THEN ''('' + CONVERT(VarChar, [character_maximum_length]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'') And [character_maximum_length] = -1 THEN ''(MAX)'' 
						ELSE '''' 
					END + 
					CASE WHEN [IS_NULLABLE]=''YES'' THEN '' '''''' + col.[COLUMN_NAME] + ''[not(@i:nil = "true")]'''''' ELSE '''' END
				ELSE ''--''
			END			
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName
		
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, ''_'')
		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will insert a default value and not actually null			
		Insert Into #SqlTable VALUES(@cTAB + ''INSERT INTO '' + ''[dbo].[''+@TableName + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''('' + IsNull(@insColNames, ''@insColNames is null'') + @nline + @cTAB + '')'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''SELECT'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, ''@insColNames is null'') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + ''FROM OPENXML (@DocHandle, ''''/ArrayOf'' + @TableNamePascal + ''/'' + @TableNamePascal +'''''',2) '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''WITH ('' + IsNull(@selColNames, ''@selColNames is null'') + @nline + @cTAB+ '')'' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + ''-- remove the xml document'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_removedocument @DocHandle'' + @nline)		

	END
	ELSE IF @ActionType = ''UpdateBulk''
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, ''_'')
	
		Insert Into #SqlTable VALUES(@cTAB + ''IF EXISTS ( SELECT ''''X'''' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''''[tempdb].[dbo].[#'' + @TableNamePascal + '']''''))AND([type] = ''''U'''')) )'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''DROP TABLE [#'' + @TableNamePascal + '']'' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>'''''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''['' + col.[ColumnNamePascal] + '']'' 					
				,@setColNames = 
				CASE 
					WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND col.[IsIdentity] = 1) THEN
						COALESCE(@setColNames + '', '' + @nline, '''') + 
						@cTAB + @cTAB + ''[bt].['' + col.[COLUMN_NAME] + ''] = [tmp].['' + col.[ColumnNamePascal] + '']''
						ELSE ''--'' 
					END
				,@selColNames = 
					COALESCE(@selColNames + '', '' + @nline, '''') + @cTAB + @cTAB + ''['' + CASE [DATA_TYPE] WHEN ''uniqueidentifier'' THEN [ColumnNamePascal] + ''] '' + ''nvarchar(100)'' ELSE [ColumnNamePascal] + ''] '' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, [numeric_precision]) + '', '' + CONVERT(VarChar, [numeric_scale]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And [character_maximum_length] <> -1 THEN ''('' + CONVERT(VarChar, [character_maximum_length]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'') And [character_maximum_length] = -1 THEN ''(MAX)'' 
						ELSE '''' 
					END + 
					CASE WHEN [IS_NULLABLE]=''YES'' THEN '' '''''' + col.[COLUMN_NAME] + ''[not(@i:nil = "true")]'''''' ELSE '''' END
		FROM [vwCGEN_Columns] col
		WHERE TABLE_NAME = @TableName		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + ''SELECT'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, ''@insColNames is null'') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + ''INTO '' + ''[#'' + @TableNamePascal + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''FROM OPENXML (@DocHandle, ''''/ArrayOf'' + @TableNamePascal + ''/'' + @TableNamePascal +'''''',2) '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''WITH ('' + IsNull(@selColNames, ''@selColNames is null'') + @nline + @cTAB+ '')'' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + ''UPDATE [bt] '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''SET '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@setColNames, ''@setColNames is null'') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''FROM [dbo].['' + @TableName + ''] [bt] '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''JOIN [#'' + @TableNamePascal + ''] [tmp] ON '' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@TableName, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + ''-- remove the xml document'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_removedocument @DocHandle'' + @nline)		

	END	
	ELSE IF @ActionType = ''DeleteBulk''
	BEGIN
		SELECT TOP 1 @TableNamePascal=[strval] FROM [dbo].[Split](@ProcName, ''_'')
	
		Insert Into #SqlTable VALUES(@cTAB + ''IF EXISTS ( SELECT ''''X'''' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''''[tempdb].[dbo].[#'' + @TableNamePascal + '']''''))AND([type] = ''''U'''')) )'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''DROP TABLE [#'' + @TableNamePascal + '']'' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_preparedocument @DocHandle OUTPUT, @DataXml, ''''<root xmlns:i="http://www.w3.org/2001/XMLSchema-instance"/>'''''' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		SELECT @insColNames = 			
					COALESCE(@insColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''['' + col.[ColumnNamePascal] + '']'' 					
				,@selColNames = 
					COALESCE(@selColNames + '', '' + @nline, '''') + @cTAB + @cTAB + ''['' + CASE [DATA_TYPE] WHEN ''uniqueidentifier'' THEN [ColumnNamePascal] + ''] '' + ''nvarchar(100)'' ELSE [ColumnNamePascal] + ''] '' + [DATA_TYPE] END + 
					CASE 
						WHEN [DATA_TYPE]=''decimal'' THEN ''('' + CONVERT(VarChar, [numeric_precision]) + '', '' + CONVERT(VarChar, [numeric_scale]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'', ''char'', ''nchar'') And [character_maximum_length] <> -1 THEN ''('' + CONVERT(VarChar, [character_maximum_length]) + '')'' 
						WHEN [DATA_TYPE] IN (''varchar'', ''nvarchar'') And [character_maximum_length] = -1 THEN ''(MAX)'' 
						ELSE '''' 
					END + 
					CASE WHEN [IS_NULLABLE]=''YES'' THEN '' '''''' + col.[COLUMN_NAME] + ''[not(@i:nil = "true")]'''''' ELSE '''' END
		FROM [vwCGEN_Columns] col
		WHERE TABLE_NAME = @TableName		
		
		--Note: Looks like if x:nil from the serialization xml is not handled, then it will update a default value and not actually null				
		Insert Into #SqlTable VALUES(@cTAB + ''SELECT'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + IsNull(@insColNames, ''@insColNames is null'') + @nline + @cTAB)
		Insert Into #SqlTable VALUES(@cTAB + ''INTO '' + ''[#'' + @TableNamePascal + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''FROM OPENXML (@DocHandle, ''''/ArrayOf'' + @TableNamePascal + ''/'' + @TableNamePascal +'''''',2) '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''WITH ('' + IsNull(@selColNames, ''@selColNames is null'') + @nline + @cTAB+ '')'' + @nline)
		Insert Into #SqlTable VALUES(@nline)
		Insert Into #SqlTable VALUES(@cTAB + ''DELETE [bt] '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''FROM [dbo].['' + @TableName + ''] [bt] '' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''JOIN [#'' + @TableNamePascal + ''] [tmp] ON '' + [dbo].[CGEN_fnGetPkColumnsJoinClause](@TableName, @PrimaryKeyColumnName) + @nline)
		Insert Into #SqlTable VALUES(@nline)
		
		Insert Into #SqlTable VALUES(@cTAB + ''-- remove the xml document'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''EXEC sp_xml_removedocument @DocHandle'' + @nline)		

	END		
	ELSE IF @ActionType = ''UpdateByPK''
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') THEN
					COALESCE(@ColNames + '', '' + @nline, '''') + 
					@cTAB + @cTAB + ''['' + col.[COLUMN_NAME] + ''] = @'' + col.[COLUMN_NAME]
				ELSE ''--''
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@cTAB + ''UPDATE '' + ''[dbo].[''+@TableName + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''SET '' + @ColNames + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + ''WHERE '' + @pkPredicates)
	END
	ELSE IF @ActionType = ''UpdateByColumns''
	BEGIN
		SELECT @ColNames = 
			CASE 
				WHEN NOT (@PrimaryKeyColumnName = col.[COLUMN_NAME] AND COLUMNPROPERTY( OBJECT_ID(@TableName), col.[COLUMN_NAME], ''IsIdentity'') = ''1'') AND NOT(@ckColumnNames=col.[COLUMN_NAME]) THEN
					COALESCE(@ColNames + '', '' + @nline, '''') + 
					@cTAB + ''['' + col.[COLUMN_NAME] + ''] = @'' + col.[COLUMN_NAME]
				ELSE COALESCE(@ColNames + @nline, ''--'')
			END
		FROM INFORMATION_SCHEMA.COLUMNS col
		WHERE TABLE_NAME = @TableName

		Insert Into #SqlTable VALUES(@cTAB + ''UPDATE '' + ''[dbo].[''+@TableName + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''SET '' + @ColNames + @nline)
		Insert Into #SqlTable VALUES(@cTAB + ''WHERE '' + @ckPredicates)
		
	END
	ELSE IF @ActionType = ''DeleteByPK''
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + ''DELETE FROM '' + ''[dbo].[''+@TableName + '']'' + @nline)		
		Insert Into #SqlTable VALUES(@cTAB + ''WHERE '' + @pkPredicates)
	END
	ELSE IF @ActionType = ''DeleteByColumns''
	BEGIN
		Insert Into #SqlTable VALUES(@cTAB + ''DELETE FROM '' + ''[dbo].[''+@TableName + '']'' + @nline)
		Insert Into #SqlTable VALUES(@cTAB + @cTAB + ''WHERE '' + @ckPredicates)
	END
	
	/*
	SELECT @SqlStr='''', @SqlStrTemp=''''
	WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr	
	*/
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScriptByActionType]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScriptByActionType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates script for a table based on action type (available actions: Select, SelectByPK, UpdateByPK, DeleteByPK, Insert, InsertBulk, SelectByColumns, UpdateByColumns, DeleteByColumns)
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.10
-- Description:   Changes for InsertBulk
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.17
-- Description:   Pass proc name to body proc
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.07.19
-- Description:   Changes for UpdateBulk, DeleteBulk
-- =============================================  


CREATE PROCEDURE [dbo].[CGEN_GenerateScriptByActionType]
	@TableName nvarchar(128),
	@ProcName NVarChar(200),
	@ActionType VarChar(100),
	@IsOnlyDrop	bit,
	@fkColumnName nVarchar(128) = Null
	
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @ScriptText NVarChar(MAX)
DECLARE @SelectProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2), @dline char(2)
IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#SqlTable]''))AND([type] = ''U'')) )	
	DROP TABLE #SqlTable
CREATE Table #SqlTable(Id Int Identity Primary Key, SqlStr VarChar(MAX))

DECLARE @Id Int, @SqlStr VarChar(MAX), @SqlStrTemp VarChar(MAX)
--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

SET		@cTAB = char(9)
SET		@Indent = ''   ''
SET 	@nline = char(13) + char(10)
SET 	@dline = char(10) + char(13)

Insert Into #SqlTable VALUES(''/****************************************************************************************/'' + @dline)

EXEC [dbo].[CGEN_GenerateProcDropStmt] @ProcName
Insert Into #SqlTable VALUES(@dline)


IF @IsOnlyDrop = 0
BEGIN
	Insert Into #SqlTable VALUES(''SET ANSI_NULLS ON'' + @nline)	
	Insert Into #SqlTable VALUES(''SET QUOTED_IDENTIFIER ON'' + @nline)
	Insert Into #SqlTable VALUES(''GO'')
	Insert Into #SqlTable VALUES(@dline)

	EXEC [dbo].[CGEN_GenerateProcHeader] @TableName, @ActionType
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcCreateStmt] @TableName, @ProcName, @ActionType, @fkColumnName
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES(''--------------------------------------------------------------------------------'' + @nline)
	Insert Into #SqlTable VALUES(''-- DECLARE'' + @nline)
	
	Insert Into #SqlTable VALUES(''--------------------------------------------------------------------------------'' + @nline)
	Insert Into #SqlTable VALUES(''DECLARE @ErrNo int'' + @nline)
	IF @ActionType IN (''InsertBulk'', ''UpdateBulk'', ''DeleteBulk'')
		Insert Into #SqlTable VALUES(''DECLARE @DocHandle int'' + @nline)
	Insert Into #SqlTable VALUES(''--------------------------------------------------------------------------------'' + @nline)
	Insert Into #SqlTable VALUES(''-- PROCESSING'' + @nline)
	Insert Into #SqlTable VALUES(''--------------------------------------------------------------------------------'')
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES(''SET NOCOUNT ON'' + @nline)
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES(''BEGIN TRY'' + @nline )
	Insert Into #SqlTable VALUES(@dline)
	EXEC [dbo].[CGEN_GenerateProcBodyStmt] @ProcName, @TableName, @ActionType, @fkColumnName
	Insert Into #SqlTable VALUES(@dline)
	Insert Into #SqlTable VALUES(''END TRY'' + @nline)
	Insert Into #SqlTable VALUES(''BEGIN CATCH'' + @nline)
	--SET @ScriptText = @ScriptText + @cTAB + ''EXEC CME360_DatabaseExceptionLog_Add'' + @nline  -- new
	EXEC [dbo].[CGEN_GenerateProcErrorHandlerStmt] @TableName, @ProcName, @ActionType, @fkColumnName
	Insert Into #SqlTable VALUES(''END CATCH'' + @nline)
	Insert Into #SqlTable VALUES(@dline)	
	Insert Into #SqlTable VALUES(''GO'')	
END

--SELECT * FROM #SqlTable
SELECT @SqlStr='''', @SqlStrTemp=''''
WHILE EXISTS(SELECT ''X'' FROM #SqlTable)
BEGIN
	SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable
	
	IF LEN(@SqlStr) > 4000
	BEGIN
		PRINT @SqlStr
		SET @SqlStr = ''''
	END
	SET @SqlStr = @SqlStr + @SqlStrTemp

	DELETE FROM #SqlTable WHERE Id=@Id
END	
PRINT @SqlStr

--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1

' 
END
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateScript]    Script Date: 07/26/2012 16:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateScript]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generates Select, Insert, Update and Delete scripts for a table
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2011.08.18
-- Description:   Master Table Configuration
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.01.29
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.05
-- Description:   Composite Keys
-- =============================================  
-- Username:      pnamburi
-- Action:        Update
-- Action date:   2012.02.13
-- Description:   IsInsert
-- =============================================  
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.04.04
-- Description:		Added RowId to the query
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.06.21
-- Description:		Handle bulk insert
-- =============================================
-- Username:		pnamburi
-- Action:			Update
-- Action Date:		2012.07.19
-- Description:		Handle bulk update, bulk delete
-- =============================================


CREATE PROCEDURE [dbo].[CGEN_GenerateScript]     
	@IsDropOnly Bit=''False''
AS

--------------------------------------------------------------------------------
-- DECLARE
--------------------------------------------------------------------------------
DECLARE @ErrNo int
DECLARE @SelectByPKProcName VarChar(200), @SelectByColumnsProcName VarChar(200), @UpdateByColumnsProcName VarChar(200), @DeleteByColumnsProcName VarChar(200)
DECLARE @SelectProcName VarChar(200), @InsertProcName VarChar(200), @InsertBulkProcName VarChar(200), @UpdateBulkProcName VarChar(200), @DeleteBulkProcName VarChar(200)
	,@UpdateByPKProcName VarChar(200), @DeleteByPKProcName VarChar(200)
DECLARE @cTAB char(1), @Indent char(3), @nline char(2)
DECLARE @PrimaryKeyColumnName NVarChar(128), @PrimaryKeyColumnNamePascal NVarChar(128)
DECLARE @ColumnName VarChar(128), @ConstraintName VarChar(128)

DECLARE @CGEN_MasterTableId Int, @TableName nvarchar(128), @TableNamePascal nvarchar(128), @IsSelect Bit, @IsInsert Bit, 
	@IsInsertBulk Bit, @IsUpdateBulk Bit, @IsDeleteBulk Bit, @IsSelectByPK Bit, @IsUpdateByPK Bit, @IsDeleteByPK Bit,
	@IsSelectByColumns Bit, @IsUpdateByColumns Bit, @IsDeleteByColumns Bit, @ColumnNames NVarChar(128), @ColumnNamesPascal NVarChar(128), @RowId Int

--------------------------------------------------------------------------------
-- PROCESSING 
--------------------------------------------------------------------------------
SET NOCOUNT ON

IF EXISTS ( SELECT ''X'' FROM [tempdb].[sys].[objects] WHERE (([object_id] = Object_Id(N''[tempdb].[dbo].[#MasterTableEntries]''))AND([type] = ''U'')) )	
	DROP TABLE #MasterTableEntries


SELECT [RowId]=ROW_NUMBER() OVER(PARTITION BY [mt].[TableName] ORDER BY [mt].[TableName])
	  ,[mt].[CGEN_MasterTableId]
      ,[mt].[TableName]
      ,[TableNamePascal]=[dbo].[CGEN_fnToPascalCase]([mt].[TableName], [mt].[IsTruncatePrefix_Table], [mt].[PrefixToTruncate_Table], [mt].[PrefixToApply_Table])
      ,[mt].[IsSelect]
      ,[mt].[IsInsert]
      ,[mt].[IsInsertBulk]
      ,[mt].[IsUpdateBulk]
      ,[mt].[IsDeleteBulk]
      ,[mt].[IsSelectByPK]
      ,[mt].[IsUpdateByPK]
      ,[mt].[IsDeleteByPK]
      ,[mtc].[IsSelectByColumns]
      ,[mtc].[IsUpdateByColumns]
      ,[mtc].[IsDeleteByColumns]
      ,[mtc].[ColumnNames]
      ,[ColumnNamesPascal]=[dbo].[CGEN_fnGetColumnNames_PascalCase]([mt].[TableName], [mtc].[ColumnNames])
INTO [#MasterTableEntries]      
FROM [dbo].[CGEN_MasterTable] [mt]
LEFT JOIN [dbo].[CGEN_MasterTableColumnFilter] [mtc] ON [mtc].[IsActive]=''True'' AND [mt].[TableName]=[mtc].[TableName]
WHERE [mt].[IsActive]=''True''

WHILE EXISTS(SELECT ''X'' FROM [#MasterTableEntries])
BEGIN

	SELECT @CGEN_MasterTableId=Null, @TableNamePascal=Null, @TableName=Null ,@IsSelect=Null, @IsInsert=Null ,@IsSelectByPK=Null 
		,@IsInsertBulk=Null, @IsUpdateBulk=Null, @IsDeleteBulk=Null, @IsUpdateByPK=Null ,@IsDeleteByPK=Null  ,@IsSelectByColumns=Null ,@IsUpdateByColumns=Null ,@IsDeleteByColumns=Null
		,@ColumnNames=Null, @ColumnNamesPascal=Null, @RowId=Null


	SELECT TOP 1 @CGEN_MasterTableId=[CGEN_MasterTableId], @TableNamePascal=[TableNamePascal], @TableName=[TableName] ,@IsSelect=[IsSelect], @IsInsert=[IsInsert] 
		,@IsInsertBulk=[IsInsertBulk], @IsUpdateBulk=[IsUpdateBulk], @IsDeleteBulk=[IsDeleteBulk], @IsSelectByPK=[IsSelectByPK] 
		,@IsUpdateByPK=[IsUpdateByPK] ,@IsDeleteByPK=[IsDeleteByPK]  ,@IsSelectByColumns=[IsSelectByColumns] ,@IsUpdateByColumns=[IsUpdateByColumns] ,@IsDeleteByColumns=[IsDeleteByColumns]
		,@ColumnNames=[ColumnNames], @ColumnNamesPascal=[ColumnNamesPascal], @RowId=[RowId]
	FROM [#MasterTableEntries]
	

		SELECT @PrimaryKeyColumnName=dbo.[CGEN_fnGetPrimaryKeyColumn](@TableName), @PrimaryKeyColumnNamePascal=dbo.[CGEN_fnGetPrimaryKeyColumn_PascalCase](@TableName)
		SELECT @SelectProcName = @TableNamePascal+''_Get''
			,@SelectByPKProcName = @TableNamePascal+''_GetBy_''+REPLACE(@PrimaryKeyColumnNamePascal,'','',''_'')
			,@InsertProcName = @TableNamePascal+''_Insert'', @InsertBulkProcName = @TableNamePascal+''_InsertBulk''
			, @UpdateBulkProcName = @TableNamePascal+''_UpdateBulk'', @DeleteBulkProcName = @TableNamePascal+''_DeleteBulk''
			,@UpdateByPKProcName = @TableNamePascal+''_UpdateBy_''+REPLACE(@PrimaryKeyColumnNamePascal,'','',''_'')
			,@DeleteByPKProcName = @TableNamePascal+''_DeleteBy_''+REPLACE(@PrimaryKeyColumnNamePascal,'','',''_'')
		SELECT @SelectByColumnsProcName = @TableNamePascal+''_GetBy_''+REPLACE(@ColumnNamesPascal,'','',''_'')
			,@UpdateByColumnsProcName = @TableNamePascal+''_UpdateBy_''+REPLACE(@ColumnNamesPascal,'','',''_'')
			,@DeleteByColumnsProcName = @TableNamePascal+''_DeleteBy_''+REPLACE(@ColumnNamesPascal,'','',''_'')
		
		
		IF @IsSelect=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectProcName, ''Select'', @IsDropOnly
		IF @IsSelectByPK=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectByPKProcName, ''SelectByPK'', @IsDropOnly
		IF @IsUpdateByPK=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @UpdateByPKProcName, ''UpdateByPK'', @IsDropOnly
		IF @IsDeleteByPK=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @DeleteByPKProcName, ''DeleteByPK'', @IsDropOnly		
		IF @IsInsert=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @InsertProcName, ''Insert'', @IsDropOnly
		IF @IsInsertBulk=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @InsertBulkProcName, ''InsertBulk'', @IsDropOnly
		IF @IsUpdateBulk=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @UpdateBulkProcName, ''UpdateBulk'', @IsDropOnly
		IF @IsDeleteBulk=''True'' AND @RowId=1
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @DeleteBulkProcName, ''DeleteBulk'', @IsDropOnly
		
		IF @IsSelectByColumns=''True''
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @SelectByColumnsProcName, ''SelectByColumns'', @IsDropOnly, @ColumnNames
		IF @IsUpdateByColumns=''True''
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @UpdateByColumnsProcName, ''UpdateByColumns'', @IsDropOnly, @ColumnNames		
		IF @IsDeleteByColumns=''True''
			EXEC [CGEN_GenerateScriptByActionType] @TableName, @DeleteByColumnsProcName, ''DeleteByColumns'', @IsDropOnly, @ColumnNames
		
		
		--SELECT PrimaryKeyColumnName=@PrimaryKeyColumnName, PrimaryKeyColumnNamePascal=@PrimaryKeyColumnNamePascal, SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectProcName=@SelectProcName, SelectByPKProcName=@SelectByPKProcName, InsertProcName=@InsertProcName, UpdateByPKProcName=@UpdateByPKProcName, DeleteByPKProcName=@DeleteByPKProcName,
		--	SelectByColumnsProcName=@SelectByColumnsProcName, UpdateByColumnsProcName=@UpdateByColumnsProcName, DeleteByColumnsProcName=@DeleteByColumnsProcName
	DELETE TOP (1) [#MasterTableEntries]
END


RETURN 0
--------------------------------------------------------------------------------
-- Error Handling 
--------------------------------------------------------------------------------
ErrHandler:
   RETURN -1
' 
END
GO
