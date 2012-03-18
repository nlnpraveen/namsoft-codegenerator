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
        public static DataSet GetMetaData()
        {
            try
            {
                using (ConnectionManager connectionManager = new ConnectionManager())
                {
                    connectionManager.Open();

                    IDbCommand cmd = connectionManager.GetCommand("CGEN_Metadata_Select");

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
