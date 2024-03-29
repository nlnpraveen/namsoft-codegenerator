USE [SaiVision]
GO
/****** Object:  StoredProcedure [dbo].[CGEN_GenerateProcDropStmt]    Script Date: 03/06/2012 20:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Username:      pnamburi
-- Action:        Create
-- Action date:   2009.01.14  
-- Description:   Generate the drop statement for a procedure
-- =============================================
  
ALTER PROCEDURE [dbo].[CGEN_GenerateProcDropStmt]
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
	SET		@Indent = '   '
	SET 	@nline = char(13) + char(10)
	SET		@date =  CONVERT(varchar, GetDate(), 110)

	Insert Into #SqlTable VALUES('IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].['+@ProcName+']'') AND type in (N''P'', N''PC''))' + @nline)
	Insert Into #SqlTable VALUES(@cTAB+ 'DROP PROCEDURE dbo.['+@ProcName+']' + @nline)---
	Insert Into #SqlTable VALUES('GO')
	
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

