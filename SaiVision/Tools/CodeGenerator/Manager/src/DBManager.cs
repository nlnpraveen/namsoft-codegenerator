using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading;
using SaiVision.Tools.CodeGenerator.DataAccess;
using SaiVision.Platform.CommonUtil.Serialization;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class DBManager
    {
        #region [ Fields ]
        private static DBManager _instance;
        private static object syncRoot = new object();

        #endregion

        #region [ Ctor ]
        //public DBManager() { } 
        #endregion

        #region [ Singleton ]
        public static DBManager GetInstance()
        {
            if (_instance == null)
            {
                lock(syncRoot)
                {
                    if (_instance == null)
                    {
                        Interlocked.Exchange(ref _instance, new DBManager());
                    }
                }
            }
            return _instance;
        }
        #endregion

        #region [ Properties ]

        #endregion

        #region [ Public Methods ]
        /// <summary>
        /// Gets the tables.
        /// </summary>
        /// <value>The tables.</value>
        public DBMetaData GetDBMetaData()
        {
            DataSet ds = NamsMetadataDM.GetMetaDataMaster();

            DBMetaData metaData = new DBMetaData(ds);

            return metaData;
        }

        /// <summary>
        /// Gets the data bases configured for code generation.
        /// </summary>
        /// <returns></returns>
        public List<DBMetaData> GetConfiguredDataBases()
        {
            List<DBMetaData> databases = new List<DBMetaData>();
            DataTable table = NamsMetadataDM.GetConfiguredDataBases();

            foreach (DataRow row in table.Rows)
            {
                DBMetaData db = new DBMetaData(row);
                databases.Add(db);
            }

            return databases;
        }

        /// <summary>
        /// Gets the database namespaces.
        /// </summary>
        /// <param name="databaseId">The database id.</param>
        /// <returns></returns>
        public List<DatabaseNamespace> GetDatabaseNamespaces(int databaseId)
        {
            DataTable dtDatabaseNamespaces = NamsMetadataDM.GetDatabaseNamespaces(databaseId);

            List<DatabaseNamespace> clnDatabaseNamespaces = new List<DatabaseNamespace>();
            foreach (DataRow row in dtDatabaseNamespaces.Rows)
            {
                clnDatabaseNamespaces.Add(new DatabaseNamespace(row));
            }

            return clnDatabaseNamespaces;
        }

        /// <summary>
        /// Saves the database namespaces.
        /// </summary>
        /// <param name="clDatabaseNamespace">The cl database namespace.</param>
        public void SaveDatabaseNamespaces(List<DatabaseNamespace> clDatabaseNamespace)
        {
            string xmlDatabaseNamespace = XmlSerializationHelper.ToXmlString(clDatabaseNamespace, true);
            NamsMetadataDM.SaveDatabaseNamespaces(xmlDatabaseNamespace);
        }
        #endregion
    }
}
