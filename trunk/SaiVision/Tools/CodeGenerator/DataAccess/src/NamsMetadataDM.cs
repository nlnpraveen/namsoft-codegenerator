using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CECity.Platform.DataAccess;
using System.Data;
using System.Data.SqlClient;

namespace SaiVision.Tools.CodeGenerator.DataAccess
{
    public class NamsMetadataDM
    {

        public static DataSet GetDataBaseMetaData(string database, DateTime? fetchDate)
        {
            if (string.IsNullOrEmpty(database))
                throw new ArgumentOutOfRangeException("database", database, string.Format("Value is in-correct {0}", database));

            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    if (database.Equals("CommandCenter"))
                        connectionManager.Open(CECity.Platform.Common.DBServerType.LifeTime);

                    IDbCommand cmd = connectionManager.GetCommand("PROC");
                    cmd.CommandType = CommandType.Text;
                    //string commandText = "DECLARE @ModifyDate DateTime; SET @ModifyDate=null; SELECT [TableName]=[col].[TABLE_NAME], [ColumnName]=[col].[COLUMN_NAME], [ColumnDefault]=[col].COLUMN_DEFAULT, [IsNullable]=[col].IS_NULLABLE, [DataType]=[col].DATA_TYPE,[IsIdentity]=COLUMNPROPERTY( [t].[object_id], [col].[COLUMN_NAME], 'IsIdentity'), [t].[modify_date] FROM sys.objects [t] JOIN sys.columns [c] ON t.[object_id]=c.[object_id] JOIN INFORMATION_SCHEMA.COLUMNS [col] ON [col].[COLUMN_NAME]=[c].[name] AND [col].[TABLE_NAME]=[t].[name] WHERE ([t].[modify_date] > @ModifyDate Or @ModifyDate Is Null);  SELECT so.[name], sc.[name] FROM syscolumns sc INNER JOIN sys.objects so ON sc.id=so.[object_id] INNER JOIN sysindexes si ON si.id=so.[object_id] INNER JOIN sysindexkeys sik ON sc.colid=sik.colid AND sc.id=sik.id  WHERE (so.[modify_date] > @ModifyDate Or @ModifyDate Is Null) AND si.indid BETWEEN 1 AND 254  AND	(si.status & 2048) = 2048 AND so.[type]='U';";
                    string commandText = "DECLARE @ModifyDate DateTime; SET @ModifyDate={0}; SELECT [TableName]=[t].[Name], [PrimaryKey]=STUFF((SELECT sc.[Name] + ',' FROM syscolumns sc INNER JOIN sys.objects so ON so.[object_id]=[t].[object_id] AND sc.id=so.[object_id] INNER JOIN sysindexes si ON si.id=so.[object_id] INNER JOIN sysindexkeys sik ON sc.colid=sik.colid AND sc.id=sik.id  WHERE si.indid BETWEEN 1 AND 254  AND	(si.status & 2048) = 2048 AND so.[type]='U' FOR XML PATH ('')) ,1,0,'') FROM sys.objects [t] WHERE [t].[type]='U' AND ([t].[modify_date] > @ModifyDate Or @ModifyDate Is Null) ORDER BY [t].[Name]; SELECT [TableName]=[col].[TABLE_NAME], [ColumnName]=[col].[COLUMN_NAME], [ColumnOrder]=[col].[ORDINAL_POSITION], [ColumnDefault]=[col].COLUMN_DEFAULT, [IsNullable]=[col].IS_NULLABLE, [DataType]=[col].DATA_TYPE,[IsIdentity]=Cast(COLUMNPROPERTY( [t].[object_id], [col].[COLUMN_NAME], 'IsIdentity') As Bit), [NumericPrecision]=[col].[NUMERIC_PRECISION], [NumericScale]=[col].[NUMERIC_SCALE], [CharacterMaximumLength]=[col].[CHARACTER_MAXIMUM_LENGTH] FROM sys.objects [t] JOIN sys.columns [c] ON t.[object_id]=c.[object_id] JOIN INFORMATION_SCHEMA.COLUMNS [col] ON [col].[COLUMN_NAME]=[c].[name] AND [col].[TABLE_NAME]=[t].[name] WHERE ([t].[modify_date] > @ModifyDate Or @ModifyDate Is Null) ORDER BY [col].[TABLE_NAME];";
                    commandText = string.Format(commandText, fetchDate.HasValue ? "'"+fetchDate.Value.ToShortDateString() +"'" : "null");
                    cmd.CommandText = commandText;

                    DataSet dsMetadata = connectionManager.FillDataSet(cmd);

                    dsMetadata.Tables[0].TableName = "Tables";
                    dsMetadata.Tables[1].TableName = "Columns";

                    return dsMetadata;
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "SynchronizeMetaData", "database", database), sqlex);
            }
            catch (Exception ex)
            {
                throw new DBException(ex.Message, ex);
            }
        }

        /// <summary>
        /// Synchronizes the metadata for one or more databases.
        /// </summary>
        /// <param name="xmlMetadata">The XML metadata.</param>
        /// <exception cref="CECity.Platform.DataAccess.DBException"></exception>
        public static void MetadataSynchronize(string xmlMetadata)
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_Metadata_Synchronize");

                    //now create the parameters.
                    cmd.Parameters.Add(connectionManager.GetParameter("@xmlMetadata",
                        SqlDbType.Xml,
                        ParameterDirection.Input,
                        xmlMetadata));

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "SynchronizeMetaData", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw new DBException(ex.Message, ex);
            }
        }

        public static void MetadataSaveConfiguration(string xmlMetadata)
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_Metadata_SaveConfiguration");

                    //now create the parameters.
                    cmd.Parameters.Add(connectionManager.GetParameter("@xmlMetadata",
                        SqlDbType.Xml,
                        ParameterDirection.Input,
                        xmlMetadata));

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "MetaDataSaveConfiguration", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw new DBException(ex.Message, ex);
            }
        }
        

        public static DataSet GetMetaDataMaster()
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_Metadata_SelectMaster");

                    DataSet dsMetadata = connectionManager.FillDataSet(cmd);

                    dsMetadata.Tables[0].TableName = "Tables";
                    dsMetadata.Tables[1].TableName = "Columns";

                    return dsMetadata;
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "GetMetaData", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable GetConfiguredDataBases()
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_Metadata_GetDataBases");

                    return connectionManager.FillTable(cmd);
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "GetConfiguredDataBases", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw new DBException(ex.Message, ex);
            }
        }        
        
        public static DataTable GetForeignKeyColumns(string tableName)
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_GetForeignKeyColumns");

                    cmd.Parameters.Add(connectionManager.GetParameter("@TableName",
                        SqlDbType.VarChar,
                        ParameterDirection.Input,
                        tableName));

                    DataSet dsMetadata = connectionManager.FillDataSet(cmd);
                    
                    return dsMetadata.Tables[0];
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "GetMetaData", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataSet GetUniqueConstraintColumns(string tableName)
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_GetUniqueConstraintColumns");

                    cmd.Parameters.Add(connectionManager.GetParameter("@TableName",
                        SqlDbType.Int,
                        ParameterDirection.Input,
                        tableName));

                    DataSet dsMetadata = connectionManager.FillDataSet(cmd);
                    dsMetadata.Tables[0].TableName = "ConstraintNames";
                    dsMetadata.Tables[1].TableName = "ConstraintDetails";

                    return dsMetadata;
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "GetMetaData", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string GetPrimaryKeyColumn(string tableName)
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_GetPrimaryKeyColumn");

                    cmd.Parameters.Add(connectionManager.GetParameter("@TableName",
                        SqlDbType.NVarChar,
                        ParameterDirection.Input,
                        tableName));

                    cmd.Parameters.Add(connectionManager.GetParameter("@ColumnName",
                        SqlDbType.NVarChar, 128,
                        ParameterDirection.Output));

                    cmd.ExecuteNonQuery();

                    return ((IDataParameter)cmd.Parameters["@ColumnName"]).Value.ToString();
                }
            }
            catch (SqlException sqlex)
            {
                //throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString("SqlExceptionWrapper", "GetMetaData", "reqId", reqId), sqlex);
                throw sqlex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
