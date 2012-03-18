using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SaiVision.Tools.CodeGenerator.DataAccess;
using System.IO;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class DataAccessGenerator
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

        public DataAccessGenerator(GeneratorSettings settings, DBMetaData dbMetaData)
        {
            this.Settings = settings;
            this._dbMetaData = dbMetaData;
        }

        public void GenerateDataAccessClasses()
        {
            IEnumerable<IGrouping<string, TableMetaData>> tableGroups = DBMetaData.Tables.GroupBy(tmd => tmd.TableName);

            foreach (IGrouping<string, TableMetaData> tableGroup in tableGroups)
            {                
                string dbTableName = tableGroup.Key;
                string pascalTableName = tableGroup.First().TableNamePascal;

                string filePath = string.Format(@"{0}\{1}DM.cs", Settings.DirectoryPath, pascalTableName);
                StreamWriter fileWriter = null;
                fileWriter = Utility.GetFileStreamWriter(filePath, true);

                #region [-- Process each entry in the table --]
                string className = string.Format("{0}DM", pascalTableName);
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
                            "using System.Data.SqlClient;",
                            "using CECity.Platform.DataAccess;",
                            "using CECity.Enterprise.DataModel;",
                            "using CECity.Platform.Common;"
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
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Public Members", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Private Properties", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Instance Methods", tab2));
                    fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

                    fileWriter.WriteLine();

                    fileWriter.WriteLine(string.Format("{0}#region Static Methods", tab2));
                    foreach (TableMetaData table in tableGroup)
                    {
                        GenerateDataAccessMethods(fileWriter, table);
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
            //#region [-- Process each entry in the table --]
            //foreach (TableMetaData table in DBMetaData.Tables)
            //{
            //    string dbTableName = table.TableName;
            //    string pascalTableName = Utility.ConvertToPascalCase(dbTableName);

            //    string filePath = string.Format(@"{0}\{1}DM.cs", DirectoryPath, pascalTableName);

            //    StreamWriter fileWriter = null;
            //    string className = string.Format("{0}DM", pascalTableName);

            //    bool isFileExists = File.Exists(filePath);

            //    try
            //    {
            //        fileWriter = Utility.GetFileStreamWriter(filePath);

            //        if (!isFileExists)
            //        {

            //            fileWriter.WriteLine(CodeGenHelper.GetFilePrologue());
            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(CodeGenHelper.GetUsingStmt(new string[] { "using System;", 
            //            "using System.Collections.Generic;", 
            //            "using System.Data;",
            //            "using System.Text;", 
            //            "using System.Runtime.Serialization.Formatters.Binary;",
            //            "using System.IO;",
            //            "using System.Data.SqlClient;",
            //            "using CECity.Platform.DataAccess;",
            //            "using CECity.Enterprise.DataModel;"
            //            }));
            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("namespace {0}", _namespace));
            //            fileWriter.WriteLine("{");
            //            fileWriter.WriteLine(string.Format("{0}public class {1}", tab1, className));
            //            fileWriter.WriteLine(string.Format("{0}{{", tab1));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Constructors", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Private Members", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Public Members", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Public Properties", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Private Properties", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Instance Methods", tab2));
            //            fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //            fileWriter.WriteLine();

            //            fileWriter.WriteLine(string.Format("{0}#region Static Methods", tab2));

            //            GenerateDataAccessMethods(fileWriter, table);
            //        }
            //        else
            //        {
            //            // File already exists
            //            GenerateDataAccessMethods(fileWriter, table);
            //        }

            //    }
            //    finally
            //    {
            //        Utility.CloseFileStream(fileWriter);
            //    }

            //    // Now End the Region
            //    fileWriter = Utility.GetFileStreamWriter(filePath);
            //    try
            //    {
            //        fileWriter.WriteLine(string.Format("{0}#endregion", tab2));

            //        fileWriter.WriteLine(string.Format("{0}}}", tab1));
            //        fileWriter.WriteLine("}");
            //    }
            //    finally
            //    {
            //        Utility.CloseFileStream(fileWriter);
            //    }
            //}
            //#endregion 
            #endregion
        }

        private void GenerateDataAccessMethods(StreamWriter fileWriter, TableMetaData table)
        {
            if (table.IsSelect)
                fileWriter.WriteLine(CodeGenHelper.Get_DataAccessMethod_AllRecords(Settings, table));

            if (table.IsSelectByPK)
                fileWriter.WriteLine(CodeGenHelper.Get_DataAccessMethod_ByPrimaryKey(Settings, table));
            
            if (table.IsSelectByColumns)
                fileWriter.WriteLine(CodeGenHelper.Get_DataAccessMethod_ByColumns(Settings, table));             

            if (table.IsInsert)
                fileWriter.WriteLine(CodeGenHelper.Insert_DataAccessMethod(Settings, table));

            if (table.IsUpdateByPK)
                fileWriter.WriteLine(CodeGenHelper.Update_DataAccessMethod(Settings, table));

            if (table.IsUpdateByColumns)
                fileWriter.WriteLine(CodeGenHelper.Update_DataAccessMethod_ByColumns(Settings, table));

            if (table.IsDeleteByPK)
                fileWriter.WriteLine(CodeGenHelper.Delete_DataAccessMethod(Settings, table));

            if (table.IsDeleteByColumns)
                fileWriter.WriteLine(CodeGenHelper.Delete_DataAccessMethod_ByColumns(Settings, table));
        }
    }
}
