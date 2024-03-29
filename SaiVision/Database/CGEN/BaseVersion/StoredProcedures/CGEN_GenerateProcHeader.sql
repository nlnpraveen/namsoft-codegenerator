USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcHeader]    Script Date: 08/18/2012 01:19:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CGEN_GenerateProcHeader]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CGEN_GenerateProcHeader]
GO

USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcHeader]    Script Date: 08/18/2012 01:19:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	IF @ActionType = 'Select'
		SET @Description = 'Selects all records from the ' + @TableName + ' table'
	ELSE IF @ActionType IN ('SelectByColumns' , 'SelectByPK')
		SET @Description = 'Selects records from the ' + @TableName + ' table filtered by the parameters passed'
	ELSE IF @ActionType = 'Insert'
		SET @Description = 'Inserts a record into the ' + @TableName + ' table'
	ELSE IF @ActionType = 'InsertBulk'
		SET @Description = 'Inserts a recordset into the ' + @TableName + ' table'
	ELSE IF @ActionType = 'UpdateBulk'
		SET @Description = 'Updates a set of records in ' + @TableName + ' table'
	ELSE IF @ActionType = 'DeleteBulk'
		SET @Description = 'Deletes a set of records in the  ' + @TableName + ' table'
	ELSE IF @ActionType = 'UpdateByPK'
		SET @Description = 'Updates a record in the ' + @TableName + ' table'
	ELSE IF @ActionType = 'UpdateByColumns' 
		SET @Description = 'Updates a record in the ' + @TableName + ' table based on the parameters passed'
	ELSE IF @ActionType = 'DeleteByPK'
		SET @Description = 'Deletes a record in the ' + @TableName + ' table'
	ELSE IF @ActionType = 'DeleteByColumns' 
		SET @Description = 'Deletes a record in the ' + @TableName + ' table based on the parameters passed'


	Insert Into #SqlTable VALUES('-- =============================================' + @nline)
	Insert Into #SqlTable VALUES('-- Username:' + @cTAB + @cTAB + 'pnamburi' + @nline)	
	Insert Into #SqlTable VALUES('-- Action:' + @cTAB + @cTAB + @cTAB + 'Create' + @nline)
	Insert Into #SqlTable VALUES('-- Action Date:' + @cTAB + @cTAB + @date + @nline)
	Insert Into #SqlTable VALUES('-- Description:' + @cTAB + @cTAB + @Description + @nline)	
	Insert Into #SqlTable VALUES('-- =============================================' )
	/*
	SELECT @SqlStr='', @SqlStrTemp=''
	WHILE EXISTS(SELECT 'X' FROM #SqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @SqlStrTemp=SqlStr FROM #SqlTable

		IF LEN(@SqlStr) > 4000
		BEGIN
			PRINT @SqlStr
			SET @SqlStr = ''
		END
		SET @SqlStr = @SqlStr + @SqlStrTemp

		DELETE FROM #SqlTable WHERE Id=@Id
	END
	PRINT @SqlStr		
	*/	
END


GO

