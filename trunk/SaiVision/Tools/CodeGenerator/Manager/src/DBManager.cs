using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading;
using SaiVision.Tools.CodeGenerator.DataAccess;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class DBManager
    {
        #region [ Fields ]
        private static DBManager _instance;
        private static object syncRoot = new object();

        #endregion

        #region [ Ctor ]
        public DBManager() { } 
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
        #endregion
    }
}
