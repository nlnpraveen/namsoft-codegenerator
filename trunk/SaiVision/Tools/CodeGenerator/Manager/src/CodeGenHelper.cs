using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SaiVision.Tools.CodeGenerator.DataAccess;
using SaiVision.Platform.Common.Extensions;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class CodeGenHelper
    {
        private static string tab1 = "\t";
        private static string tab2 = "\t\t";
        private static string tab3 = "\t\t\t";
        private static string tab4 = "\t\t\t\t";

        public static string GetFilePrologue()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("/*");
            sb.AppendLine(" * Created by Code Generator");
            sb.AppendLine(" * Creation Date: 1/23/2009");
            sb.AppendLine(" * Copyrights Namsoft LLC, All rights reserved.");
            sb.AppendLine(" * ");
            sb.AppendLine(" */");

            return sb.ToString();
        }

        public static string GetUsingStmt(string[] usingStmts)
        {
            StringBuilder sb = new StringBuilder();
            foreach (string stmt in usingStmts)
            {
                sb.AppendLine(stmt);
            }

            return sb.ToString();
        }

        public static string GetInstanceProperty(string className)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Gets the single instance of {1}", tab2, className));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}public static {1} GetInstance()", tab2, className));
            sb.AppendLine(string.Format("{0}{{", tab2));
            sb.AppendLine(string.Format("{0}if (_instance == null)", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}lock (syncRoot)", tab3 + tab1));
            sb.AppendLine(string.Format("{0}{{", tab3 + tab1));
            sb.AppendLine(string.Format("{0}if (_instance == null)", tab3 + tab2));
            sb.AppendLine(string.Format("{0}{{", tab3 + tab2));
            sb.AppendLine(string.Format("{0}Interlocked.Exchange(ref _instance, new {1}());", tab3 + tab3, className));
            sb.AppendLine(string.Format("{0}}}", tab3 + tab2));
            sb.AppendLine(string.Format("{0}}}", tab3 + tab1));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}return _instance;", tab3));
            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }

        #region Manager Methods

        public static string Get_ManagerMethod_AllRecords(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Gets all the records from the {1} table", tab2, table.TableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <returns>The {1} collection</returns>", tab2, table.TableNamePascal));

            sb.AppendLine(string.Format("{0}public List<{1}> GetAll{1}s()", tab2, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab2));
            sb.AppendLine(string.Format("{0}List<{1}> {2}Coll = new List<{1}>();", tab3, table.TableNamePascal, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}DataTable dt{1}= {1}DM.GetAll{1}s();", tab3, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}if (dt{1} != null && dt{1}.Rows.Count > 0)", tab3, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}foreach (DataRow row in dt{1}.Rows)", tab4, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab4));
            sb.AppendLine(string.Format("{0} {2}Coll.Add(new {1}(row));", tab4 + tab1, table.TableNamePascal, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}}}", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}return {1}Coll;", tab3, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }

        public static string Get_ManagerMethod_ByPrimaryKey(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            if (table.PrimaryKey != null && table.PrimaryKey.Length > 0)
            {
                StringBuilder parameterText = new StringBuilder();
                StringBuilder parameterText1 = new StringBuilder();
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    if (string.IsNullOrEmpty(parameterText.ToString()))
                    {
                        parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(mdColumn.ColumnNameCamel);
                    }
                    else
                    {
                        parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                    }
                });

                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Gets the {1} object by {2}", tab2, table.TableNamePascal, parameterText1));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2}</param>", tab2, string.Empty, string.Empty));
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2}</param>", tab2, mdColumn.ColumnNameCamel, mdColumn.ColumnNamePascal));
                });

                sb.AppendLine(string.Format("{0}/// <returns>The {1} object</returns>", tab2, table.TableNamePascal));
                
                sb.AppendLine(string.Format("{0}public {1} Get{1}By{2}({3})", tab2, table.TableNamePascal,
                    //string.Format("{0}{1}", (table.PrimaryKey.Length > 1 ? "_" : string.Empty), table.PrimaryKeyNamesPascal.Replace(',', '_'), 
                    table.PrimaryKeyNamesPascal.Replace(',', '_'), 
                    parameterText.ToString()));
                sb.AppendLine(string.Format("{0}{{", tab2));
                sb.AppendLine(string.Format("{0}{1} {2} = null;", tab3, table.TableNamePascal, table.TableNameCamel));
                sb.AppendLine(string.Format("{0}DataTable dt{1}= {1}DM.Get{1}By{2}({3});", tab3, table.TableNamePascal,
                    table.PrimaryKeyNamesPascal.Replace(',', '_'), parameterText1.ToString()));
                sb.AppendLine(string.Format("{0}if (dt{1} != null && dt{1}.Rows.Count > 0)", tab3, table.TableNamePascal));
                sb.AppendLine(string.Format("{0}{{", tab3));
                sb.AppendLine(string.Format("{0} {2} = new {1}(dt{1}.Rows[0]);", tab4, table.TableNamePascal, table.TableNameCamel));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}return {1};", tab3, table.TableNameCamel));
                sb.AppendLine(string.Format("{0}}}", tab2));

            }

            return sb.ToString();
        }

        public static string Get_ManagerMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder parameterText = new StringBuilder();
            StringBuilder parameterText1 = new StringBuilder();
            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(mdColumn.ColumnNameCamel);
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                }
            });

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Gets the {1} collection by {2}", tab2, table.TableNamePascal, table.QueryColumnsNamesPascal));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            table.QueryColumns.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2}</param>", tab2, mdColumn.ColumnNameCamel, mdColumn.ColumnNamePascal));
                });
            sb.AppendLine(string.Format("{0}/// <returns>The {1} collection</returns>", tab2, table.TableNamePascal));

            sb.AppendLine(string.Format("{0}public List<{1}> Get{1}By_{2}({3})", tab2, table.TableNamePascal, 
                table.QueryColumnsNamesPascal.Replace(',', '_'), 
                parameterText.ToString()));
            sb.AppendLine(string.Format("{0}{{", tab2));
            sb.AppendLine(string.Format("{0}List<{1}> {2}Coll = new List<{1}>();", tab3, table.TableNamePascal, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}DataTable dt{1}= {1}DM.Get{1}By_{2}({3});", tab3, table.TableNamePascal,
                table.QueryColumnsNamesPascal.Replace(',', '_'), 
                parameterText1));
            sb.AppendLine(string.Format("{0}if (dt{1} != null && dt{1}.Rows.Count > 0)", tab3, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}foreach (DataRow row in dt{1}.Rows)", tab4, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab4));
            sb.AppendLine(string.Format("{0} {2}Coll.Add(new {1}(row));", tab4 + tab1, table.TableNamePascal, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}}}", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}return {1}Coll;", tab3, table.TableNameCamel));
            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }

        public static string Insert_ManagerMethod(GeneratorSettings settings, TableMetaData table)
        {
            /* Assuming there is only identity key per table */
            ColumnMetaData primaryCMD = null;
            if (table.PrimaryKey != null)
            {
                primaryCMD = table.Columns.Find(c => (c.IsIdentity == true));
            }

            // Preparing parameters to be passed in method signature
            StringBuilder parameterText = new StringBuilder();
            if (!settings.PassDataModelAsObjectParameter)
            {
                table.Columns.ForEach(column =>
                {
                    if (!column.IsIdentity)
                    {
                        ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column.ColumnName));
                        if (string.IsNullOrEmpty(parameterText.ToString()))
                            parameterText.Append(string.Format("{0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                        else
                            parameterText.Append(string.Format(", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                    }
                });
            }

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Inserts record(s) into the {1} table", tab2, table.TableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));
            if (primaryCMD != null)
                sb.AppendLine(string.Format("{0}/// <returns>The {1} that was created</returns>", tab2, primaryCMD.ColumnNamePascal));

            sb.AppendLine(string.Format("{0}public {3} Add{1}({1} {2})", tab2, table.TableNamePascal, table.TableNameCamel, (primaryCMD == null ? "void" : Utility.GetEquivalentTypeName(primaryCMD.DataType))));
            sb.AppendLine(string.Format("{0}{{", tab2));
            if (primaryCMD != null)
            {
                if (settings.PassDataModelAsObjectParameter)
                {
                    sb.AppendLine(string.Format("{0}{4} {1} = {2}DM.Add{2}({3});", tab3, primaryCMD.ColumnNameCamel, table.TableNamePascal, table.TableNameCamel, Utility.GetEquivalentTypeName(primaryCMD.DataType)));
                }
                else
                {
                    sb.AppendLine(string.Format("{0}{4} {1} = {2}DM.Add{2}({3});", tab3, primaryCMD.ColumnNameCamel, table.TableNamePascal, parameterText, Utility.GetEquivalentTypeName(primaryCMD.DataType)));
                }
                sb.AppendLine(string.Format("{0}return {1};", tab3, primaryCMD.ColumnNameCamel));
            }
            else
            {
                if (settings.PassDataModelAsObjectParameter)
                    sb.AppendLine(string.Format("{0}{1}DM.Add{1}({2});", tab3, table.TableNamePascal, table.TableNameCamel));
                else
                    sb.AppendLine(string.Format("{0}{1}DM.Add{1}({2});", tab3, table.TableNamePascal, parameterText));
            }

            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        } 

        public static string Update_ManagerMethod(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            if (table.PrimaryKey != null && table.PrimaryKey.Length > 0)
            {
                // Preparing parameters to be passed in method signature
                StringBuilder parameterText = new StringBuilder();
                if (!settings.PassDataModelAsObjectParameter)
                {
                    table.Columns.ForEach(column =>
                    {
                        ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column.ColumnName));
                        if (string.IsNullOrEmpty(parameterText.ToString()))
                            parameterText.Append(string.Format("{0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                        else
                            parameterText.Append(string.Format(", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                    });
                }

                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Updates an existing record(s) into the {1} table", tab2, table.TableName));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

                sb.AppendLine(string.Format("{0}public void Update{1}({1} {2})", tab2, table.TableNamePascal, table.TableNameCamel));
                sb.AppendLine(string.Format("{0}{{", tab2));

                if (settings.PassDataModelAsObjectParameter)
                {
                    sb.AppendLine(string.Format("{0}{1}DM.Update{1}({2});", tab3, table.TableNamePascal, table.TableNameCamel));
                }
                else
                {
                    sb.AppendLine(string.Format("{0}{1}DM.Update{1}({2});", tab3, table.TableNamePascal, parameterText));
                }

                sb.AppendLine(string.Format("{0}}}", tab2));
            }

            return sb.ToString();
        }

        public static string Update_ManagerMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder parameterText = new StringBuilder();
            StringBuilder parameterText1 = new StringBuilder();
            table.QueryColumnsNames.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(mdColumn.ColumnNameCamel);
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                }
            });

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Updates an existing record(s) into the {1} table", tab2, table.TableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

            sb.AppendLine(string.Format("{0}public void Update{1}By_{2}({3})", tab2, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText.ToString()));
            sb.AppendLine(string.Format("{0}{{", tab2));

            sb.AppendLine(string.Format("{0}{1}DM.Update{1}By_{2}({3});", tab3, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText1));

            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }

        public static string Delete_ManagerMethod(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            if (table.PrimaryKey != null && table.PrimaryKey.Length > 0)
            {
                StringBuilder parameterText = new StringBuilder();
                StringBuilder parameterText1 = new StringBuilder();
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    if (string.IsNullOrEmpty(parameterText.ToString()))
                    {
                        parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(mdColumn.ColumnNameCamel);
                    }
                    else
                    {
                        parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                    }
                });


                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Deletes a record(s) from the {1} table", tab2, table.TableName));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

                sb.AppendLine(string.Format("{0}public void DeleteBy{2}({3})", tab2, table.TableNamePascal,
                    table.PrimaryKeyNamesPascal.Replace(',', '_'),
                    parameterText.ToString()));
                sb.AppendLine(string.Format("{0}{{", tab2));

                sb.AppendLine(string.Format("{0}{1}DM.Delete{1}By{2}({3});", tab3, table.TableNamePascal,
                    table.PrimaryKeyNamesPascal.Replace(',', '_'), parameterText1.ToString()));

                sb.AppendLine(string.Format("{0}}}", tab2));
            }

            return sb.ToString();
        }

        public static string Delete_ManagerMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder parameterText = new StringBuilder();
            StringBuilder parameterText1 = new StringBuilder();
            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(mdColumn.ColumnNameCamel);
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                }
            });

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Deletes a record(s) from the {1} table", tab2, table.TableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

            sb.AppendLine(string.Format("{0}public void Delete{1}By_{2}({3})", tab2, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText.ToString()));
            sb.AppendLine(string.Format("{0}{{", tab2));

            sb.AppendLine(string.Format("{0}{1}DM.Delete{1}By_{2}({3});", tab3, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText1));
            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }
        #endregion

        #region Data Access Methods

        #region [Public Methods]
        public static string Get_DataAccessMethod_AllRecords(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Gets all the records from the {1} table", tab2, table.TableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <returns>DataTable</returns>", tab2));

            sb.AppendLine(string.Format("{0}public static DataTable GetAll{1}s()", tab2, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}{{", tab2));
            sb.AppendLine(string.Format("{0}try", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
            sb.AppendLine(string.Format("{0}{{", tab4));
            sb.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
            sb.AppendLine(string.Empty);
            sb.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.SelectProc));
            sb.AppendLine(string.Empty);
            sb.AppendLine(string.Format("{0}DataTable dt{1} = connectionManager.FillTable(cmd);", tab4 + tab1, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}return dt{1};", tab4 + tab1, table.TableNamePascal));
            sb.AppendLine(string.Format("{0}}}", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}throw sqlex;", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}throw ex;", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}}}", tab2));

            return sb.ToString();
        }

        public static string Get_DataAccessMethod_ByPrimaryKey(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();

            if (table.PrimaryKey != null && table.PrimaryKey.Length > 0)
            {
                StringBuilder parameterText = new StringBuilder();
                StringBuilder parameterText1 = new StringBuilder();
                StringBuilder exceptionParameterText = new StringBuilder();
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    if (string.IsNullOrEmpty(parameterText.ToString()))
                    {
                        parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(mdColumn.ColumnNameCamel);
                        exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                    }
                    else
                    {
                        parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                        exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                    }
                });

                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Get the {1} record from the database by the {2}", tab2, table.TableNamePascal, table.PrimaryKeyNamesPascal));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2}</param>", tab2, mdColumn.ColumnNameCamel, mdColumn.ColumnNamePascal));
                });
                sb.AppendLine(string.Format("{0}/// <returns>DataTable</returns>", tab2));

                sb.AppendLine(string.Format("{0}public static DataTable Get{1}By{2}({3})", tab2, table.TableNamePascal,
                    table.PrimaryKeyNamesPascal.Replace(',', '_'),
                    parameterText.ToString()));
                sb.AppendLine(string.Format("{0}{{", tab2));
                sb.AppendLine(string.Format("{0}try", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                sb.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
                sb.AppendLine(string.Format("{0}{{", tab4));
                sb.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
                sb.AppendLine(string.Empty);
                sb.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.SelectByPKProc));
                sb.AppendLine(string.Empty);

                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, mdColumn.ColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(mdColumn.DataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                    sb.AppendLine(string.Format("{0}{1}));", tab4 + tab2, mdColumn.ColumnNameCamel));
                });



                sb.AppendLine(string.Empty);
                sb.AppendLine(string.Format("{0}DataTable dt{1} = connectionManager.FillTable(cmd);", tab4 + tab1, table.TableNamePascal));
                sb.AppendLine(string.Format("{0}return dt{1};", tab4 + tab1, table.TableNamePascal));
                sb.AppendLine(string.Format("{0}}}", tab4));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw sqlex;", tab4));
                else
                    sb.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Get{1}By{2}"", {3}), sqlex);", tab4, table.TableNamePascal, table.PrimaryKeyNamesPascal.Replace(',', '_'), exceptionParameterText.ToString()));

                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw ex;", tab4));
                else
                    sb.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}}}", tab2));
            }

            return sb.ToString();
        }

        public static string Get_DataAccessMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder parameterText = new StringBuilder();
            StringBuilder exceptionParameterText = new StringBuilder();
            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                }

            });

            StringBuilder methodText = new StringBuilder();
            methodText.AppendLine(string.Format("{0}/// <summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// Inserts record(s) into the {1} table", tab2, table.TableName));
            methodText.AppendLine(string.Format("{0}/// </summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));
            methodText.AppendLine(string.Format("{0}/// <returns>The {1}</returns>", tab2, table.TableNamePascal));

            methodText.AppendLine(string.Format("{0}public static DataTable Get{1}By_{2}({3})", tab2, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText.ToString()));
            methodText.AppendLine(string.Format("{0}{{", tab2));
            methodText.AppendLine(string.Format("{0}try", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            methodText.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
            methodText.AppendLine(string.Format("{0}{{", tab4));
            methodText.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.SelectByColumnsProc));
            methodText.AppendLine(string.Empty);

            table.QueryColumns.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    methodText.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, column));
                    methodText.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(mdColumn.DataType)));
                    methodText.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                    methodText.AppendLine(string.Format("{0}{1}));", tab4 + tab2, mdColumn.ColumnNameCamel));
                    methodText.AppendLine(string.Empty);
                });

            methodText.AppendLine(string.Format("{0}DataTable dt{1} = connectionManager.FillTable(cmd);", tab4 + tab1, table.TableNamePascal));
            methodText.AppendLine(string.Format("{0}return dt{1};", tab4 + tab1, table.TableNamePascal));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}}}", tab4));
            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw sqlex;", tab4));
            else
                methodText.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw ex;", tab4));
            else
                methodText.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}}}", tab2));

            return methodText.ToString();
        }

        public static string Insert_DataAccessMethod(GeneratorSettings settings, TableMetaData table)
        {
            // TO DO: Need to handle columns that are primary keys but not identity columns
            // Get the primary key for the table            
            string methodText = string.Empty;

            string dbTableName = table.TableName;
            string procName = string.Format("{0}_Insert", table.TableNamePascal);

            /* Assuming there is only identity key per table */
            ColumnMetaData primaryCMD = null;
            if (table.PrimaryKey != null)
            {
                primaryCMD = table.Columns.Find(c => (c.IsIdentity == true));
            }

            // Preparing parameters to be passed in method signature
            StringBuilder parameterText = new StringBuilder();
            StringBuilder exceptionParameterText = new StringBuilder();
            table.Columns.ForEach(column =>
            {
                // Identity column is returned from the database
                if (!column.IsIdentity)
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column.ColumnName));
                    if (!settings.PassDataModelAsObjectParameter)
                    {
                        if (string.IsNullOrEmpty(parameterText.ToString()))
                        {
                            parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn), mdColumn.ColumnNameCamel));
                            exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                        }
                        else
                        {
                            parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn), mdColumn.ColumnNameCamel));
                            exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(exceptionParameterText.ToString()))
                            exceptionParameterText.Append(string.Format(@"""{0}.{1}"", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                        else
                            exceptionParameterText.Append(string.Format(@", ""{0}.{1}"", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                    }
                }
            });

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("{0}/// <summary>", tab2));
            sb.AppendLine(string.Format("{0}/// Inserts record(s) into the {1} table", tab2, dbTableName));
            sb.AppendLine(string.Format("{0}/// </summary>", tab2));
            sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));
            if (primaryCMD != null)
                sb.AppendLine(string.Format("{0}/// <returns>The {1} that was created</returns>", tab2, primaryCMD.ColumnNamePascal));

            // Insert method signature
            if (settings.PassDataModelAsObjectParameter)
            {
                sb.AppendLine(string.Format("{0}public static {3} Add{1}({1} {2})", tab2, table.TableNamePascal, table.TableNameCamel, (primaryCMD == null ? "void" : Utility.GetEquivalentTypeName(primaryCMD.DataType))));
            }
            else
            {
                sb.AppendLine(string.Format("{0}public static {3} Add{1}({2})", tab2, table.TableNamePascal, parameterText, (primaryCMD == null ? "void" : Utility.GetEquivalentTypeName(primaryCMD.DataType))));
            }

            sb.AppendLine(string.Format("{0}{{", tab2));
            sb.AppendLine(string.Format("{0}try", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            sb.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
            sb.AppendLine(string.Format("{0}{{", tab4));
            sb.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
            sb.AppendLine(string.Empty);
            sb.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, procName));
            sb.AppendLine(string.Empty);

            // Parameters
            sb.AppendLine(Insert_DataAccessMethod_GetCommand(settings, table));

            sb.AppendLine(string.Format("{0}cmd.ExecuteNonQuery();", tab4 + tab1));
            sb.AppendLine(string.Empty);

            if (primaryCMD != null)
            {
                sb.AppendLine(string.Format("{0}int {1} = int.Parse(((IDataParameter)cmd.Parameters[\"@{2}\"]).Value.ToString());", tab4 + tab1, primaryCMD.ColumnNameCamel, primaryCMD.ColumnName));
                sb.AppendLine(string.Format("{0}return {1};", tab4 + tab1, primaryCMD.ColumnNameCamel));
            }

            sb.AppendLine(string.Format("{0}}}", tab4));
            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                sb.AppendLine(string.Format("{0}throw sqlex;", tab4));
            else
                sb.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));

            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
            sb.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                sb.AppendLine(string.Format("{0}throw ex;", tab4));
            else
                sb.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

            sb.AppendLine(string.Format("{0}}}", tab3));
            sb.AppendLine(string.Format("{0}}}", tab2));

            methodText = sb.ToString();

            return methodText;
        }

        public static string Update_DataAccessMethod(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();

            if (table.PrimaryKey != null)
            {
                string dbTableName = table.TableName;


                // Preparing parameters to be passed in method signature
                StringBuilder parameterText = new StringBuilder();
                StringBuilder exceptionParameterText = new StringBuilder();
                table.Columns.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column.ColumnName));
                    if (!settings.PassDataModelAsObjectParameter)
                    {
                        if (string.IsNullOrEmpty(parameterText.ToString()))
                        {
                            parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn), mdColumn.ColumnNameCamel));
                            exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                        }
                        else
                        {
                            parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn), mdColumn.ColumnNameCamel));
                            exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(exceptionParameterText.ToString()))
                            exceptionParameterText.Append(string.Format(@"""{0}.{1}"", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                        else
                            exceptionParameterText.Append(string.Format(@", ""{0}.{1}"", {0}.{1}", table.TableNameCamel, mdColumn.ColumnNamePascal));
                    }
                });

                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Updates an existing record(s) into the {1} table", tab2, dbTableName));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

                // Update method signature
                if (settings.PassDataModelAsObjectParameter)
                {
                    sb.AppendLine(string.Format("{0}public static void Update{1}({1} {2})", tab2, table.TableNamePascal, table.TableNameCamel));
                }
                else
                {
                    sb.AppendLine(string.Format("{0}public static void Update{1}({2})", tab2, table.TableNamePascal, parameterText.ToString()));
                }
                sb.AppendLine(string.Format("{0}{{", tab2));
                sb.AppendLine(string.Format("{0}try", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                sb.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
                sb.AppendLine(string.Format("{0}{{", tab4));
                sb.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
                sb.AppendLine(string.Empty);
                sb.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.UpdateByPKProc));
                sb.AppendLine(string.Empty);

                // Parameters
                sb.AppendLine(Update_DataAccessMethod_GetCommand(settings, table));

                /*
                // Prepare the command parameters
                foreach (ColumnMetaData column in table.Columns)
                {
                    string dataType = column.DataType;
                    string dbColumnName = column.ColumnName;

                    // The parameter direction is always input
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, dbColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                    if (settings.PassDataModelAsObjectParameter)
                    {
                        sb.AppendLine(string.Format("{0}{1}.{2}));", tab4 + tab2, table.TableNameCamel, column.ColumnNamePascal));
                    }
                    else
                    {
                        sb.AppendLine(string.Format("{0}{1}));", tab4 + tab2, column.ColumnNameCamel));
                    }
                    sb.AppendLine(string.Empty);
                }
                */

                sb.AppendLine(string.Format("{0}cmd.ExecuteNonQuery();", tab4 + tab1));
                sb.AppendLine(string.Empty);

                sb.AppendLine(string.Format("{0}}}", tab4));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw sqlex;", tab4));
                else
                    sb.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw ex;", tab4));
                else
                    sb.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}}}", tab2));
            }

            return sb.ToString();
        }

        public static string Update_DataAccessMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            string dbTableName = table.TableName;

            // Preparing parameters to be passed
            StringBuilder parameterText = new StringBuilder();
            StringBuilder exceptionParameterText = new StringBuilder();
            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                }

            });

            StringBuilder methodText = new StringBuilder();
            methodText.AppendLine(string.Format("{0}/// <summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// Inserts record(s) into the {1} table", tab2, dbTableName));
            methodText.AppendLine(string.Format("{0}/// </summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));
            methodText.AppendLine(string.Format("{0}/// <returns></returns>", tab2));

            methodText.AppendLine(string.Format("{0}public static void Update{1}By_{2}({3})", tab2, table.TableNamePascal, table.QueryColumnsNames.Replace(",", "_"), parameterText.ToString()));
            methodText.AppendLine(string.Format("{0}{{", tab2));
            methodText.AppendLine(string.Format("{0}try", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            methodText.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
            methodText.AppendLine(string.Format("{0}{{", tab4));
            methodText.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.UpdateByColumnsProc));
            methodText.AppendLine(string.Empty);

            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                methodText.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, column));
                methodText.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(mdColumn.DataType)));
                methodText.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                methodText.AppendLine(string.Format("{0}{1}));", tab4 + tab2, mdColumn.ColumnNameCamel));
                methodText.AppendLine(string.Empty);
            });

            methodText.AppendLine(string.Format("{0}cmd.ExecuteNonQuery();", tab4 + tab1));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}}}", tab4));
            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw sqlex;", tab4));
            else
                methodText.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw ex;", tab4));
            else
                methodText.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}}}", tab2));

            return methodText.ToString();
        }

        public static string Delete_DataAccessMethod(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            if (table.PrimaryKey != null && table.PrimaryKey.Length > 0)
            {
                StringBuilder parameterText = new StringBuilder();
                StringBuilder parameterText1 = new StringBuilder();
                StringBuilder exceptionParameterText = new StringBuilder();
                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    if (string.IsNullOrEmpty(parameterText.ToString()))
                    {
                        parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(mdColumn.ColumnNameCamel);
                        exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                    }
                    else
                    {
                        parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                        parameterText1.Append(string.Format(", {0}", mdColumn.ColumnNameCamel));
                        exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                    }
                });

                string dbTableName = table.TableName;

                sb.AppendLine(string.Format("{0}/// <summary>", tab2));
                sb.AppendLine(string.Format("{0}/// Deletes a record(s) from the {1} table", tab2, dbTableName));
                sb.AppendLine(string.Format("{0}/// </summary>", tab2));
                sb.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));

                sb.AppendLine(string.Format("{0}public static void Delete{1}By{2}({3})", tab2, table.TableNamePascal,
                    table.PrimaryKeyNamesPascal.Replace(',', '_'),
                    parameterText.ToString()));
                sb.AppendLine(string.Format("{0}{{", tab2));
                sb.AppendLine(string.Format("{0}try", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                sb.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
                sb.AppendLine(string.Format("{0}{{", tab4));
                sb.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
                sb.AppendLine(string.Empty);
                sb.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.DeleteByPKProc));
                sb.AppendLine(string.Empty);

                table.PrimaryKey.ForEach(column =>
                {
                    ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, mdColumn.ColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(mdColumn.DataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                    sb.AppendLine(string.Format("{0}{1}));", tab4 + tab2, mdColumn.ColumnNameCamel));
                });

                sb.AppendLine(string.Empty);
                sb.AppendLine(string.Format("{0}cmd.ExecuteNonQuery();", tab4 + tab1));
                sb.AppendLine(string.Format("{0}}}", tab4));
                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw sqlex;", tab4));
                else
                    sb.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));

                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
                sb.AppendLine(string.Format("{0}{{", tab3));
                if (!settings.IsCECityGenerator)
                    sb.AppendLine(string.Format("{0}throw ex;", tab4));
                else
                    sb.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

                sb.AppendLine(string.Format("{0}}}", tab3));
                sb.AppendLine(string.Format("{0}}}", tab2));
            }

            return sb.ToString();
        }

        public static string Delete_DataAccessMethod_ByColumns(GeneratorSettings settings, TableMetaData table)
        {
            string dbTableName = table.TableName;

            StringBuilder parameterText = new StringBuilder();
            StringBuilder exceptionParameterText = new StringBuilder();
            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                if (string.IsNullOrEmpty(parameterText.ToString()))
                {
                    parameterText.Append(string.Format("{0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@"""{0}"", {0}", mdColumn.ColumnNameCamel));
                }
                else
                {
                    parameterText.Append(string.Format(", {0} {1}", Utility.GetEquivalentTypeName(mdColumn.DataType), mdColumn.ColumnNameCamel));
                    exceptionParameterText.Append(string.Format(@", ""{0}"", {0}", mdColumn.ColumnNameCamel));
                }
            });


            StringBuilder methodText = new StringBuilder();
            methodText.AppendLine(string.Format("{0}/// <summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// Inserts record(s) into the {1} table", tab2, dbTableName));
            methodText.AppendLine(string.Format("{0}/// </summary>", tab2));
            methodText.AppendLine(string.Format("{0}/// <param name=\"{1}\">The {2} object</param>", tab2, table.TableNameCamel, table.TableNamePascal));
            methodText.AppendLine(string.Format("{0}/// <returns></returns>", tab2));

            methodText.AppendLine(string.Format("{0}public static void Delete{1}By_{2}({3})", tab2, table.TableNamePascal, table.QueryColumnsNamesPascal.Replace(",", "_"), parameterText.ToString()));
            methodText.AppendLine(string.Format("{0}{{", tab2));
            methodText.AppendLine(string.Format("{0}try", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            methodText.AppendLine(string.Format("{0}using (ConnectionManager connectionManager = new ConnectionManager())", tab4));
            methodText.AppendLine(string.Format("{0}{{", tab4));
            methodText.AppendLine(string.Format("{0}connectionManager.Open();", tab4 + tab1));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}IDbCommand cmd = connectionManager.GetCommand(\"{1}\");", tab4 + tab1, table.DeleteByColumnsProc));
            methodText.AppendLine(string.Empty);

            table.QueryColumns.ForEach(column =>
            {
                ColumnMetaData mdColumn = table.Columns.Find(cmd => cmd.ColumnName.Equals(column));
                methodText.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, column));
                methodText.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(mdColumn.DataType)));
                methodText.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                methodText.AppendLine(string.Format("{0}{1}));", tab4 + tab2, mdColumn.ColumnNameCamel));
                methodText.AppendLine(string.Empty);
            });

            methodText.AppendLine(string.Format("{0}cmd.ExecuteNonQuery();", tab4 + tab1));
            methodText.AppendLine(string.Empty);
            methodText.AppendLine(string.Format("{0}}}", tab4));
            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (SqlException sqlex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw sqlex;", tab4));
            else
                methodText.AppendLine(string.Format(@"{0}throw new DataAccessException(CECityResourceManager.GetCECityResourceManager().GetString(""SqlExceptionWrapper"", ""Add{1}"", {2}), sqlex);", tab4, table.TableNamePascal, exceptionParameterText.ToString()));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}catch (Exception ex)", tab3));
            methodText.AppendLine(string.Format("{0}{{", tab3));
            if (!settings.IsCECityGenerator)
                methodText.AppendLine(string.Format("{0}throw ex;", tab4));
            else
                methodText.AppendLine(string.Format("{0}throw new DBException(ex.Message, ex);", tab4));

            methodText.AppendLine(string.Format("{0}}}", tab3));
            methodText.AppendLine(string.Format("{0}}}", tab2));

            return methodText.ToString();
        }

        #endregion

        #region [Private Methods]
        private static string Insert_DataAccessMethod_GetCommand(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            // Parameters
            foreach (ColumnMetaData column in table.Columns)
            {
                string dataType = column.DataType;
                string dbColumnName = column.ColumnName;
                string columnNameFormat = (settings.PassDataModelAsObjectParameter ? string.Format("{0}.{1}", table.TableNameCamel, column.ColumnNamePascal) : column.ColumnNameCamel);
                if (column.IsIdentity)
                {
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, dbColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Output));", tab4 + tab2));
                }
                else
                {
                    // Handle nullable types seperately
                    if (!column.IsNullableType)
                    {
                        sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, dbColumnName));
                        sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                        sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                        sb.AppendLine(string.Format("{0}{1}));", tab4 + tab2, columnNameFormat));
                    }
                    else
                    {
                        string tablen = tab4 + tab1;
                        switch (column.DataType)
                        {
                            case "ntext":
                            case "varchar":
                            case "nvarchar":
                            case "nchar":
                            case "text":
                            case "char":
                                sb.AppendLine(string.Format("{0}if (!string.IsNullOrEmpty({1}))", tablen, columnNameFormat));
                                tablen = tablen + tab1;
                                break;
                            case "bit":
                            case "uniqueidentifier":
                            case "tinyint":
                                sb.AppendLine(string.Format("{0}if ({1}.HasValue)", tablen, columnNameFormat));
                                tablen = tablen + tab1;
                                break;
                        }
                        sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tablen, dbColumnName));
                        sb.AppendLine(string.Format("{0}{1},", tablen + tab1, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                        sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tablen + tab1));
                        switch (column.DataType)
                        {
                            case "int":
                            case "smallint":
                            case "bigint":
                            case "decimal":
                            case "numeric":
                            case "date":
                            case "datetime":
                            case "smalldatetime":
                            case "money":
                            case "smallmoney":
                            case "float":
                                sb.AppendLine(string.Format("{0}{1}.HasValue ? {1} : {2}.MinValue));", tablen + tab1, columnNameFormat, Utility.GetEquivalentTypeName(column.DataType)));
                                break;                                
                            default:
                                sb.AppendLine(string.Format("{0}{1}));", tablen + tab1, columnNameFormat));
                                break;
                        }

                        tablen = tab4 + tab1;
                        switch (column.DataType)
                        {
                            case "bit":
                            case "tinyint":
                            case "uniqueidentifier":
                                sb.AppendLine(string.Format("{0}else", tablen));
                                tablen = tablen + tab1;
                                sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tablen, dbColumnName));
                                sb.AppendLine(string.Format("{0}{1},", tablen + tab1, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                                sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tablen + tab1));
                                sb.AppendLine(string.Format("{0}DBNull.Value));", tablen + tab1));
                                break;
                        }
                    }
                }
                sb.AppendLine(string.Empty);
            }
            return sb.ToString();
        }

        private static string Update_DataAccessMethod_GetCommand(GeneratorSettings settings, TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();
            // Parameters
            foreach (ColumnMetaData column in table.Columns)
            {
                string dataType = column.DataType;
                string dbColumnName = column.ColumnName;
                string columnNameFormat = (settings.PassDataModelAsObjectParameter ? string.Format("{0}.{1}", table.TableNameCamel, column.ColumnNamePascal) : column.ColumnNameCamel);
                // Handle nullable types seperately
                if (!column.IsNullableType)
                {
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tab4 + tab1, dbColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tab4 + tab2, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tab4 + tab2));
                    sb.AppendLine(string.Format("{0}{1}));", tab4 + tab2, columnNameFormat));
                }
                else
                {
                    string tablen = tab4 + tab1;
                    switch (column.DataType)
                    {
                        case "ntext":
                        case "varchar":
                        case "nvarchar":
                        case "nchar":
                        case "text":
                        case "char":
                            sb.AppendLine(string.Format("{0}if (!string.IsNullOrEmpty({1}))", tablen, columnNameFormat));
                            tablen = tablen + tab1;
                            break;
                        case "bit":
                        case "uniqueidentifier":
                        case "tinyint":
                            sb.AppendLine(string.Format("{0}if ({1}.HasValue)", tablen, columnNameFormat));
                            tablen = tablen + tab1;
                            break;
                    }
                    sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tablen, dbColumnName));
                    sb.AppendLine(string.Format("{0}{1},", tablen + tab1, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                    sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tablen + tab1));
                    switch (column.DataType)
                    {
                        case "int":
                        case "smallint":
                        case "bigint":
                        case "decimal":
                        case "numeric":
                        case "date":
                        case "datetime":
                        case "smalldatetime":
                        case "money":
                        case "smallmoney":
                        case "float":
                            sb.AppendLine(string.Format("{0}{1}.HasValue ? {1} : {2}.MinValue));", tablen + tab1, columnNameFormat, Utility.GetEquivalentTypeName(column.DataType)));
                            break;
                        default:
                            sb.AppendLine(string.Format("{0}{1}));", tablen + tab1, columnNameFormat));
                            break;
                    }

                    tablen = tab4 + tab1;
                    switch (column.DataType)
                    {
                        case "bit":
                        case "tinyint":
                        case "uniqueidentifier":
                            sb.AppendLine(string.Format("{0}else", tablen));
                            tablen = tablen + tab1;
                            sb.AppendLine(string.Format("{0}cmd.Parameters.Add(connectionManager.GetParameter(\"@{1}\",", tablen, dbColumnName));
                            sb.AppendLine(string.Format("{0}{1},", tablen + tab1, Utility.GetEquivalentSqlDbTypeEnum(dataType)));
                            sb.AppendLine(string.Format("{0}ParameterDirection.Input,", tablen + tab1));
                            sb.AppendLine(string.Format("{0}DBNull.Value));", tablen + tab1));
                            break;
                    }
                }
                
                sb.AppendLine(string.Empty);
            }
            return sb.ToString();
        }
        #endregion
        #endregion        
    }
}
