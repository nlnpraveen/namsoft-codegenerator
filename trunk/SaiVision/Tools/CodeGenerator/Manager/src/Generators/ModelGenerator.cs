/*
 * Created by Code Generator
 * Creation Date: 1/23/2009
 * Copyrights Namsoft LLC, All rights reserved.
 * 
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using SaiVision.Tools.CodeGenerator.DataAccess;
using System.Data;
using SaiVision.Platform.CommonUtil.Extensions;
using System.Text.RegularExpressions;

namespace SaiVision.Tools.CodeGenerator.Manager
{    
    public class ModelGenerator
    {
        private string tab1 = "\t";
        private string tab2 = "\t\t";
        private string tab3 = "\t\t\t";
        private string tab4 = "\t\t\t\t";

        /// <summary>
        /// Gets or sets the settings.
        /// </summary>
        /// <value>The settings.</value>
        public GeneratorSettings Settings { get; set; }

        private DBMetaData _dbMetaData;
        public DBMetaData DBMetaData
        {
            get
            {
                return _dbMetaData;
            }
        }

        public ModelGenerator(GeneratorSettings settings, DBMetaData dbMetaData)
        {
            this.Settings = settings;
            this._dbMetaData = dbMetaData;
        }

        #region [Public Methods]
        public void GenerateModelClasses()
        {            
            IEnumerable<IGrouping<string, TableMetaData>> tableGroups = DBMetaData.Tables.GroupBy(tmd => tmd.TableName);

            foreach (IGrouping<string, TableMetaData> tableGroup in tableGroups)
            {
                string dbTableName = tableGroup.Key;
                TableMetaData table = DBMetaData.Tables.Find(tb => tb.TableName.Equals(dbTableName));
                string filePath = string.Format(@"{0}\{1}.cs", Settings.DirectoryPath, table.TableNamePascal);
                string className = table.TableNamePascal;

                if (!File.Exists(filePath) || true)
                {
                    StreamWriter fileWriter = null;
                    fileWriter = Utility.GetFileStreamWriter(filePath, true);

                    try
                    {
                        fileWriter.WriteLine(CodeGenHelper.GetFilePrologue());
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(CodeGenHelper.GetUsingStmt(new string[] { "using System;", 
                        "using System.Collections.Generic;", 
                        "using System.Data;",
                        "using System.Text;", 
                        "using System.Runtime.Serialization.Formatters.Binary;",
                        "using System.IO;",
                        "using System.Threading;",
                        "using System.Runtime.Serialization;"
                    }));
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("namespace {0}", Settings.Namespace));
                        fileWriter.WriteLine("{");
                        fileWriter.WriteLine(string.Format(@"{0}[DataContract(Namespace="""")]", tab1));
                        fileWriter.WriteLine(string.Format("{0}public class {1}", tab1, table.TableNamePascal));
                        fileWriter.WriteLine(string.Format("{0}{{", tab1));

                        fileWriter.WriteLine(string.Format("{0}#region Private Members", tab2));
                        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
                        fileWriter.WriteLine();

                        foreach (ColumnMetaData column in table.Columns)
                        {
                            string dataType = Utility.GetEquivalentTypeName(column);
                            fileWriter.WriteLine(string.Format("{0}private {1} _{2};", tab2, dataType, column.ColumnNamePascal));
                            fileWriter.WriteLine(string.Format(@"{0}/// <summary>", tab2));
                            fileWriter.WriteLine(string.Format(@"{0}/// {1}. {2}", tab2, column.ColumnNamePascal, (column.IsNullableType && !column.IsNullable) ? "Default value has been set." : string.Empty));
                            fileWriter.WriteLine(string.Format(@"{0}/// </summary>", tab2));
                            fileWriter.WriteLine(string.Format("{0}[DataMember()]", tab2));
                            fileWriter.WriteLine(string.Format("{0}public {1} {2}", tab2, dataType, column.ColumnNamePascal));
                            fileWriter.WriteLine(string.Format("{0}{{", tab2));
                            fileWriter.WriteLine(string.Format("{0}get {{ return _{1}; }}", tab3, column.ColumnNamePascal));
                            fileWriter.WriteLine(string.Format("{0}set {{ _{1} = value; }}", tab3, column.ColumnNamePascal));
                            fileWriter.WriteLine(string.Format("{0}}}", tab2));

                            fileWriter.WriteLine();
                        }

                        fileWriter.WriteLine();
                        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("{0}#region Constructors", tab2));
                        fileWriter.WriteLine();
                        fileWriter.WriteLine(string.Format("{0}public {1}()", tab2, table.TableNamePascal));
                        fileWriter.WriteLine(string.Format("{0}{{", tab2));
                        fileWriter.WriteLine(InitializeNullableFields(table));
                        fileWriter.WriteLine(string.Format("{0}}}", tab2));
                        fileWriter.WriteLine();
                        fileWriter.WriteLine(string.Format("{0}public {1}(DataRow row)", tab2, table.TableNamePascal));
                        fileWriter.WriteLine(string.Format("{0}{{", tab2));
                        foreach (ColumnMetaData column in table.Columns)
                        {
                            fileWriter.WriteLine(string.Format(@"{0}_{1} = {2};", tab3, column.ColumnNamePascal, Utility.GetRowValueByTypeName(column.DataType, column.ColumnName, column.ColumnNamePascal)));
                        }
                        fileWriter.WriteLine(string.Format("{0}}}", tab2));
                        fileWriter.WriteLine();
                        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("{0}#region Instance Methods", tab2));
                        fileWriter.WriteLine(string.Format("{0}// Convert an object to a byte array", tab2));
                        fileWriter.WriteLine(string.Format("{0}private byte[] ObjectToByteArray(Object obj)", tab2));
                        fileWriter.WriteLine(string.Format("{0}{{", tab2));
                        fileWriter.WriteLine(string.Format("{0}if(obj == null)", tab3));
                        fileWriter.WriteLine(string.Format("{0}return null;", tab4));
                        fileWriter.WriteLine(string.Format("{0}BinaryFormatter bf = new BinaryFormatter();", tab3));
                        fileWriter.WriteLine(string.Format("{0}MemoryStream ms = new MemoryStream();", tab3));
                        fileWriter.WriteLine(string.Format("{0}bf.Serialize(ms, obj);", tab3));
                        fileWriter.WriteLine(string.Format("{0}return ms.ToArray();", tab3));
                        fileWriter.WriteLine(string.Format("{0}}}", tab2));
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));


                        fileWriter.WriteLine(string.Format("{0}}}", tab1));
                        fileWriter.WriteLine("}");
                    }
                    //catch (Exception ex)
                    //{
                    //    throw ex;
                    //}
                    finally
                    {
                        Utility.CloseFileStream(fileWriter);
                    }
                }
            }
        }         
        #endregion

        #region [Private Methods]
        private string InitializeNullableFields(TableMetaData table)
        {
            StringBuilder sb = new StringBuilder();

            table.Columns.Where(cmd => (cmd.IsNullableType && !cmd.IsNullable)).ForEach(column =>
                {
                    sb.Append(GetColumnDefaultAssignment(column));                    
                });

            return sb.ToString();
        }

        private string GetColumnDefaultAssignment(ColumnMetaData column)
        {
            string pattern = @"(\(N'|\('|'\)|\(\(|\)\)|\(|\))";
            string defaultValue = Regex.Replace((column.ColumnDefault == null ? string.Empty : column.ColumnDefault), pattern, string.Empty, (RegexOptions.IgnoreCase & RegexOptions.Multiline));
            StringBuilder defaultAssignment = new StringBuilder();

            switch (column.DataType)
            {
                /*
                case "image":
                    defaultAssignment = "byte[]";
                    break;
                case "varbinary":
                    defaultAssignment = "byte[]";
                    break;
                */                
                case "varchar":
                case "nvarchar":
                case "ntext":
                case "text":
                case "char":
                case "nchar":
                    defaultAssignment.AppendLine(string.Format("{0}{1} = \"{2}\";", tab3, column.ColumnNamePascal, defaultValue));
                    break;
                case "date":
                case "datetime":
                case "smalldatetime":
                    if (defaultValue.Equals("getdate")) 
                    defaultAssignment.AppendLine(string.Format("{0}{1} = DateTime.Now;", tab3, column.ColumnNamePascal));
                    else
                    {
                        defaultAssignment.AppendLine(string.Format("{0}DateTime _{1}; if (DateTime.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    }
                    break;
                case "int":
                case "smallint":
                    defaultAssignment.AppendLine(string.Format("{0}int _{1}; if (int.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    break;
                case "bigint":
                    defaultAssignment.AppendLine(string.Format("{0}long _{1}; if (long.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    break;
                case "tinyint":
                    defaultAssignment.AppendLine(string.Format("{0}byte _{1}; if (byte.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    break;
                case "smallmoney":
                case "money":
                case "numeric":
                case "decimal":
                    defaultAssignment.AppendLine(string.Format("{0}decimal _{1}; if (decimal.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    break;
                case "float":
                    defaultAssignment.AppendLine(string.Format("{0}float _{1}; if (float.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal));
                    break;
                case "bit":
                    defaultAssignment.AppendLine(string.Format("{0}bool _{1}; if (bool.TryParse(\"{2}\", out _{1})) {3} = _{1};", tab3, column.ColumnNameCamel, (defaultValue.Equals("1") ? "true" : "false"), column.ColumnNamePascal));
                    break;
                case "uniqueidentifier":
                    string elseAssignNewGuid = string.Format("else {0} = Guid.NewGuid();", column.ColumnNamePascal);
                    defaultAssignment.AppendLine(string.Format("{0}Guid _{1}; if (Guid.TryParse(\"{2}\", out _{1})) {3} = _{1};{4}", tab3, column.ColumnNameCamel, defaultValue, column.ColumnNamePascal, (defaultValue.Equals("newid") ? elseAssignNewGuid : string.Empty)));
                    break;
            }
            
            return defaultAssignment.ToString();
        }
        #endregion
    }
}
