using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SaiVision.Tools.CodeGenerator.DataAccess;
using System.IO;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class ManagerGenerator
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
        /// <summary>
        /// Gets the DB meta data.
        /// </summary>
        /// <value>The DB meta data.</value>
        public DBMetaData DBMetaData
        {
            get
            {
                return _dbMetaData;
            }
        }

        public ManagerGenerator(GeneratorSettings settings, DBMetaData dbMetaData)
        {
            this.Settings = settings;
            this._dbMetaData = dbMetaData;
        }

        public void GenerateManagerClasses()
        {
            IEnumerable<IGrouping<string, TableMetaData>> tableGroups = DBMetaData.Tables.GroupBy(tmd => tmd.TableName);

            foreach (IGrouping<string, TableMetaData> tableGroup in tableGroups)
            {
                string dbTableName = tableGroup.Key;
                string pascalTableName = tableGroup.First().TableNamePascal;

                string filePath = string.Format(@"{0}\{1}DataManager.cs", Settings.DirectoryPath, pascalTableName);
                StreamWriter fileWriter = null;
                fileWriter = Utility.GetFileStreamWriter(filePath, true);
                string className = string.Format("{0}DataManager", pascalTableName);

                #region [-- Process each entry in the table --]
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
                        "using CECity.Enterprise.DataAccess;",
                        "using CECity.Enterprise.DataModel;",
                        "using SaiVision.Platform.Common;",
                        "using SaiVision.Platform.Common.Serialization;"
                    }));
                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("namespace {0}", Settings.Namespace));
                    fileWriter.WriteLine("{");
                    fileWriter.WriteLine(string.Format("{0}public class {1}", tab1, className));
                    fileWriter.WriteLine(string.Format("{0}{{", tab1));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Constructors", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Private Members", tab2));
                    fileWriter.WriteLine(string.Format("{0}private static {1} _instance;", tab2, className));
                    fileWriter.WriteLine(string.Format("{0}private static object syncRoot = new Object();", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Public Members", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
                    fileWriter.WriteLine(CodeGenHelper.GetInstanceProperty(className));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Private Properties", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Instance Methods", tab2));
                    foreach (TableMetaData table in tableGroup)
                    {
                        GenerateManagerMethods(fileWriter, table);
                    }

                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine(string.Format("{0}}}", tab1));
                    fileWriter.WriteLine("}");

                }
                finally
                {
                    Utility.CloseFileStream(fileWriter);
                }
                #endregion
            }

            #region [ Old Code ]
            //foreach (DataRow tableRow in dsMetadata.Tables["Tables"].Rows)
            //{
            //    string dbTableName = tableRow["table_name"].ToString();
            //    string pascalTableName = Utility.ConvertToPascalCase(dbTableName);
            //    string filePath = string.Format(@"{0}\{1}DataManager.cs", DirectoryPath, pascalTableName);

            //    StreamWriter fileWriter = null;
            //    fileWriter = Utility.GetFileStreamWriter(filePath, true);

            //    string className = string.Format("{0}DataManager", pascalTableName);

            //    try
            //    {
            //        writeStream = new FileStream(filePath, FileMode.Create, FileAccess.Write);
            //        fileWriter = new StreamWriter(writeStream);

            //        fileWriter.WriteLine(CodeGenHelper.GetFilePrologue());
            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(CodeGenHelper.GetUsingStmt(new string[] { "using System;", 
            //            "using System.Collections.Generic;", 
            //            "using System.Data;",
            //            "using System.Text;", 
            //            "using System.Runtime.Serialization.Formatters.Binary;",
            //            "using System.IO;",
            //            "using System.Threading;",
            //            "using CECity.Enterprise.DataAccess;",
            //            "using CECity.Enterprise.DataModel;",
            //            "using CECity.Enterprise.Common;"
            //        }));
            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("namespace {0}", _namespace));
            //        fileWriter.WriteLine("{");
            //        fileWriter.WriteLine(string.Format("{0}public class {1}", tab1, className));
            //        fileWriter.WriteLine(string.Format("{0}{{", tab1));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Constructors", tab2));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Private Members", tab2));
            //        fileWriter.WriteLine(string.Format("{0}private static {1} _instance;", tab2, className));
            //        fileWriter.WriteLine(string.Format("{0}private static object syncRoot = new Object();", tab2));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Public Members", tab2));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
            //        fileWriter.WriteLine(CodeGenHelper.GetInstanceProperty(className));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Private Properties", tab2));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Instance Methods", tab2));
            //        fileWriter.Write(CodeGenHelper.Get_ManagerMethod_ByPrimaryKey(dbTableName, dsMetadata));

            //        fileWriter.Write(CodeGenHelper.Get_ManagerMethod_ByForeignKey(dbTableName, dsMetadata));

            //        fileWriter.Write(CodeGenHelper.Get_ManagerMethod_AllRecords(dbTableName, dsMetadata));

            //        fileWriter.Write(CodeGenHelper.Insert_ManagerMethod(dbTableName, dsMetadata));

            //        fileWriter.Write(CodeGenHelper.Update_ManagerMethod(dbTableName, dsMetadata));

            //        fileWriter.Write(CodeGenHelper.Delete_ManagerMethod(dbTableName, dsMetadata));

            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine();

            //        fileWriter.WriteLine(string.Format("{0}#region Static Methods", tab2));
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));


            //        fileWriter.WriteLine(string.Format("{0}}}", tab1));
            //        fileWriter.WriteLine("}");
            //    }
            //    catch (Exception ex)
            //    {
            //        throw ex;
            //    }
            //    finally
            //    {
            //        if (fileWriter != null)
            //        {
            //            fileWriter.Flush();
            //            fileWriter.Close();
            //        }

            //        if (writeStream != null)
            //        {
            //            writeStream.Close();
            //        }
            //    }
            //} 
            #endregion
        }

        private void GenerateManagerMethods(StreamWriter fileWriter, TableMetaData table)
        {
            if (table.IsSelect)
                fileWriter.WriteLine(CodeGenHelper.Get_ManagerMethod_AllRecords(Settings, table));

            if (table.IsSelectByPK)
                fileWriter.WriteLine(CodeGenHelper.Get_ManagerMethod_ByPrimaryKey(Settings, table));

            if (table.IsSelectByColumns)
                fileWriter.WriteLine(CodeGenHelper.Get_ManagerMethod_ByColumns(Settings, table));

            if (table.IsInsert)
                fileWriter.WriteLine(CodeGenHelper.Insert_ManagerMethod(Settings, table));

            if (table.IsUpdateByPK)
                fileWriter.WriteLine(CodeGenHelper.Update_ManagerMethod(Settings, table));

            if (table.IsUpdateByColumns)
                fileWriter.WriteLine(CodeGenHelper.Update_ManagerMethod_ByColumns(Settings, table));

            if (table.IsDeleteByPK)
                fileWriter.WriteLine(CodeGenHelper.Delete_ManagerMethod(Settings, table));

            if (table.IsDeleteByColumns)
                fileWriter.WriteLine(CodeGenHelper.Delete_ManagerMethod_ByColumns(Settings, table));

            if (table.IsInsertBulk)
                fileWriter.WriteLine(CodeGenHelper.InsertBulk_ManagerMethod(Settings, table));

            if (table.IsUpdateBulk)
                fileWriter.WriteLine(CodeGenHelper.UpdateBulk_ManagerMethod(Settings, table));

            if (table.IsDeleteBulk)
                fileWriter.WriteLine(CodeGenHelper.DeleteBulk_ManagerMethod(Settings, table));
        }
    }
}
