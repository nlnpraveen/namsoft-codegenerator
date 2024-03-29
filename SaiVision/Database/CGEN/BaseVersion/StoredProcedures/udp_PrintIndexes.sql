USE [CodeGenerator]
GO

/****** Object:  StoredProcedure [dbo].[CGEN_Metadata_Synchronize]    Script Date: 09/04/2012 18:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udp_PrintIndexes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[udp_PrintIndexes]
GO

/****** Object:  StoredProcedure [dbo].[udp_PrintIndexes]    Script Date: 03/12/2012 17:32:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[udp_PrintIndexes] 
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

	--SELECT @TableName='RKG_Recognition'

	DECLARE cIX CURSOR FOR
		SELECT OBJECT_NAME(SI.Object_ID), SI.Object_ID, SI.Name, SI.Index_ID
		FROM Sys.Indexes SI 
		 LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC ON SI.Name = TC.CONSTRAINT_NAME AND OBJECT_NAME(SI.Object_ID) = TC.TABLE_NAME
		WHERE TC.CONSTRAINT_NAME IS NULL
		 AND OBJECTPROPERTY(SI.Object_ID, 'IsUserTable') = 1 		 
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
		SET @IndexSql = 'CREATE '
		Insert Into @IndexSqlTable VALUES('CREATE ')

		-- Check if the index is unique
		IF (INDEXPROPERTY(@IxTableID, @IxName, 'IsUnique') = 1)
		BEGIN
			SET @IndexSql = @IndexSql + 'UNIQUE '
			Insert Into @IndexSqlTable VALUES('UNIQUE ')

		END
		-- Check if the index is clustered
		IF (INDEXPROPERTY(@IxTableID, @IxName, 'IsClustered') = 1)
		BEGIN
			SET @IndexSql = @IndexSql + 'CLUSTERED '
			Insert Into @IndexSqlTable VALUES('CLUSTERED ')
			
		END		
		ELSE
		BEGIN 
			SET @IndexSql = @IndexSql + 'NONCLUSTERED '
			Insert Into @IndexSqlTable VALUES('NONCLUSTERED ')
		END

		SET @IndexSql = @IndexSql + 'INDEX [' + @IxName + '] ON [dbo].[' + @IxTable + '] ' + @nline + '('
		Insert Into @IndexSqlTable VALUES( 'INDEX [' + @IxName + '] ON [dbo].[' + @IxTable + '] ' + @nline + '(')

		-- Get all columns of the index
		DECLARE cIxColumn CURSOR FOR 
			SELECT SC.Name, IC.[is_descending_key]
			FROM Sys.Index_Columns IC
			 JOIN Sys.Columns SC ON IC.Object_ID = SC.Object_ID AND IC.Column_ID = SC.Column_ID
			WHERE IC.Object_ID = @IxTableID AND Index_ID = @IxID AND IC.[is_included_column]=0
			ORDER BY IC.Index_Column_ID

		DECLARE @IxColumn SYSNAME, @IsDescendingKey Bit, @HasIncludedColumns Bit
		DECLARE @IxFirstColumn BIT SET @IxFirstColumn = 1
		SET @HasIncludedColumns='False'
		-- Loop throug all columns of the index and append them to the CREATE statement
		OPEN cIxColumn
		FETCH NEXT FROM cIxColumn INTO @IxColumn, @IsDescendingKey
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
		  IF (@IxFirstColumn = 1)
			 SET @IxFirstColumn = 0
		  ELSE
			BEGIN
				 SET @IndexSql = @IndexSql + ', '
				Insert Into @IndexSqlTable VALUES(', ')
			END

		  SET @IndexSql = @IndexSql + @nline + @cTAB + '[' + @IxColumn + ']' + CASE @IsDescendingKey WHEN 1 THEN ' DESC' ELSE ' ASC' END
				Insert Into @IndexSqlTable VALUES(@nline + @cTAB + '[' + @IxColumn + ']' + CASE @IsDescendingKey WHEN 1 THEN ' DESC' ELSE ' ASC' END)

		  FETCH NEXT FROM cIxColumn INTO @IxColumn, @IsDescendingKey
		END
		CLOSE cIxColumn
		DEALLOCATE cIxColumn

		SET @IndexSql = @IndexSql + @nline + ')'
		Insert Into @IndexSqlTable VALUES(@nline + ')')

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
			SET @IndexSql = @IndexSql + @nline + 'INCLUDE '+ @nline + '('
			Insert Into @IndexSqlTable VALUES(@nline + 'INCLUDE '+ @nline + '(')
			SET @HasIncludedColumns='True'
		END

		FETCH NEXT FROM cIxColumn INTO @IxColumn
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF (@IxFirstColumn = 1)
				SET @IxFirstColumn = 0
			ELSE
			BEGIN
				SET @IndexSql = @IndexSql + ', '
				Insert Into @IndexSqlTable VALUES(', ')
			END

			SET @IndexSql = @IndexSql + @nline + @cTAB + '[' + @IxColumn + ']' 
			Insert Into @IndexSqlTable VALUES(@nline + @cTAB + '[' + @IxColumn + ']')

			FETCH NEXT FROM cIxColumn INTO @IxColumn
		END
		CLOSE cIxColumn
		DEALLOCATE cIxColumn

		IF @HasIncludedColumns='True'
		BEGIN
			SET @IndexSql = @IndexSql + @nline + ') '
			Insert Into @IndexSqlTable VALUES(@nline + ') ')
		END

		SET @IndexSql = @IndexSql + @nline + 'WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]'
			Insert Into @IndexSqlTable VALUES(@nline + 'WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMAR
Y]')
		SET @IndexSql = @IndexSql + @nline 
			Insert Into @IndexSqlTable VALUES(@nline)
		SET @IndexSql = @IndexSql + @nline + '---------------------------------------------------------------------------------'
			Insert Into @IndexSqlTable VALUES(@nline + '---------------------------------------------------------------------------------')
			Insert Into @IndexSqlTable VALUES(@nline)

		-- Print out the CREATE statement for the index
		--PRINT @IndexSql

		FETCH NEXT FROM cIX INTO @IxTable, @IxTableID, @IxName, @IxID
	END

	CLOSE cIX
	DEALLOCATE cIX

	/*SET @IndexSql=''
	SELECT @IndexSql=Convert(VarChar(MAX), @IndexSql)+Convert(VarChar(MAX), IndexSql) FROM @IndexSqlTable ORDER BY Id
	SELECT @IndexSql = @IndexSql + N'Hello'
	PRINT @IndexSql*/

	SELECT @ISql='', @IndexSql=''
	WHILE EXISTS(SELECT 'X' FROM @IndexSqlTable)
	BEGIN
		SELECT TOP 1 @Id=Id, @ISql=IndexSql FROM @IndexSqlTable

		IF LEN(@IndexSql) > 4000
		BEGIN
			PRINT @IndexSql
			SET @IndexSql = ''
		END
		SET @IndexSql = @IndexSql + @ISql

		DELETE FROM @IndexSqlTable WHERE Id=@Id
	END
	PRINT @IndexSql
END