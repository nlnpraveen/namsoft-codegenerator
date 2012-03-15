using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.Unity;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration.Unity;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;

namespace SaiVision.Platform.DataAccess
{
    public class DatabaseWrapper
    {
        protected Database db;

        public DatabaseWrapper() 
        {

            // Resolve the class through the Unity container.
            //var container = new UnityContainer()
            //                .AddNewExtension<EnterpriseLibraryCoreExtension>();
            //DatabaseWrapper myObject = container.Resolve<DatabaseWrapper>();

            db = DatabaseFactory.CreateDatabase("STAGING");
        }

        public DatabaseWrapper(Database theDatabase)
        {
            db = theDatabase;
        }

        public DbCommand GetStoredProcCommand(string commandName)
        {
            DbCommand cmd = db.GetStoredProcCommand(commandName);
            return cmd;
        }

        public DataSet ExecuteDataSet(DbCommand cmd)
        {            
            DataSet set = db.ExecuteDataSet(cmd);
            return set;
        }

        public IDataReader ExecuteReader(DbCommand cmd)
        {
            IDataReader reader = db.ExecuteReader(cmd);
            return reader;            
        }

        public int ExecuteNonQuery(DbCommand cmd)
        {
            int val = db.ExecuteNonQuery(cmd);
            return val;
        }

        public object GetParameterValue(DbCommand cmd, string name)
        {
            Object obj = db.GetParameterValue(cmd, name).ToString();
            return obj;
        }

        public void AddInParameter(DbCommand cmd, string name, DbType dbType, object value)
        {
            db.AddInParameter(cmd, name, dbType, value);            
        }

        public void AddOutParameter(DbCommand cmd, string name, DbType dbType, int size)
        {
            db.AddOutParameter(cmd, name, dbType, size);
        }
    }
}
