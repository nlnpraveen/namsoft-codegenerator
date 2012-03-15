using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using SaiVision.Platform.DataAccess;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;

namespace SaiVision.Platform.DataAccess.NUnit
{
    [TestFixture]
    public class DatabaseWrapperTest
    {
        private DatabaseWrapper dbWrapper;
        //[Test]
        //public void GetBaseRoles()
        //{
        //    DataManager manager = new DataManager();
        //    DataSet ds = manager.GetBaseRoles();
        //    Assert.AreEqual(4, ds.Tables[0].Rows.Count);
        //}

        //[Test]
        //public void GetBaseRolesReader()
        //{
        //    DataManager manager = new DataManager();
        //    IDataReader reader = manager.GetBaseRolesReader();

        //    // Call Read before accessing data.
        //    while (reader.Read())
        //    {
        //        Console.WriteLine(String.Format("{0}, {1}",
        //            reader[0], reader[1]));
        //    }
        //    //Assert.AreEqual(true, reader.GetType().Equals(typeof(SqlDataReader)));
        //}

        //[Test]
        //public void GetRoleName()
        //{
        //    DataManager manager = new DataManager();
        //    string name = manager.GetRoleName(1);
        //    Console.WriteLine("Rolename: {0}", name);
        //}

        [TestFixtureSetUp]
        public void CreateWrapper()
        {
            dbWrapper = new DatabaseWrapper();
        }

        [Test]
        public void ExecuteDataSet()
        {
            DbCommand cmd = dbWrapper.GetStoredProcCommand("ROLE_BaseRoles_Get");
            DataSet ds = dbWrapper.ExecuteDataSet(cmd);
            Assert.AreEqual(4, ds.Tables[0].Rows.Count);
        }

        [Test]
        public void ExecuteReader()
        {
            DbCommand cmd = dbWrapper.GetStoredProcCommand("ROLE_BaseRoles_Get");
            IDataReader reader = dbWrapper.ExecuteReader(cmd);

            // Call Read before accessing data.
            while (reader.Read())
            {
                Console.WriteLine(String.Format("{0}, {1}",
                    reader[0], reader[1]));
            }
            //Assert.AreEqual(true, reader.GetType().Equals(typeof(SqlDataReader)));
        }
    }
}
