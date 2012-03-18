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
                        "using System.Threading;"
                    }));
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("namespace {0}", Settings.Namespace));
                        fileWriter.WriteLine("{");
                        fileWriter.WriteLine(string.Format("{0}public class {1}", tab1, table.TableNamePascal));
                        fileWriter.WriteLine(string.Format("{0}{{", tab1));

                        fileWriter.WriteLine(string.Format("{0}#region Private Members", tab2));
                        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));
                        fileWriter.WriteLine();

                        fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
                        fileWriter.WriteLine();

                        foreach (ColumnMetaData column in table.Columns)
                        {
                            string dataType = Utility.GetEquivalentTypeName(column.DataType);
                            fileWriter.WriteLine(string.Format("{0}private {1} _{2};", tab2, dataType, column.ColumnNamePascal));
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
                        fileWriter.WriteLine(string.Format("{0}public {1}() {{ }}", tab2, table.TableNamePascal));
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
    }
}
