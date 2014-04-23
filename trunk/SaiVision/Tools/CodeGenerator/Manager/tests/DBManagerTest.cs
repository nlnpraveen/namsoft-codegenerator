using SaiVision.Tools.CodeGenerator.Manager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using SaiVision.Platform.CommonLibrary;
using System.Runtime.Serialization;
using System.IO;

namespace SaiVision.Tools.CodeGenerator.Manager.Tests
{
    
    
    /// <summary>
    ///This is a test class for DBManagerTest and is intended
    ///to contain all DBManagerTest Unit Tests
    ///</summary>
    [TestClass()]
    public class DBManagerTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for GetConfiguredDataBases
        ///</summary>
        [TestMethod()]
        public void DataContractSerializationTest()
        {   
            /*
            DBMetaData metaData = DBManager.GetInstance().GetDBMetaData();

            Console.Write(DataContractSerializationHelper.ToXmlString(metaData, false));
            */
            List<DBMetaData> dbs = DBManager.GetInstance().GetConfiguredDataBases();

            foreach (DBMetaData db in dbs)
            {
                db.Synchronize();
            }
            DataContractSerializer xser = new DataContractSerializer(dbs.GetType());
            FileStream fs = new FileStream(@"C:\DBQueries\Tutorials\openxml\DBMetaData\DBMetaData1_DataContract_Serializer.xml", FileMode.Create);
            xser.WriteObject(fs, dbs);
            fs.Close();
        }

        /// <summary>
        ///A test for SaveDatabaseNamespaces
        ///</summary>
        [TestMethod()]
        public void SaveDatabaseNamespacesTest()
        {
            DBManager target = new DBManager(); // TODO: Initialize to an appropriate value
            List<DatabaseNamespace> clDatabaseNamespace = new List<DatabaseNamespace>(); // TODO: Initialize to an appropriate value
            clDatabaseNamespace.Add(new DatabaseNamespace() { DatabaseId = 1, NamespaceId = 1, NamespaceName = "SaiVision.GeneratedObjects", IsSelected = true });
            clDatabaseNamespace.Add(new DatabaseNamespace() { DatabaseId = 1, NamespaceId = 24, NamespaceName = "Saivision.GeneratedObjects.Activity", IsSelected = true });
            clDatabaseNamespace.Add(new DatabaseNamespace() { DatabaseId = 1, NamespaceId = 25, NamespaceName = "Saivision.GeneratedObjects.ActivityWorkflow", IsSelected = true });
            clDatabaseNamespace.Add(new DatabaseNamespace() { DatabaseId = 1, NamespaceId = 26, NamespaceName = "SaiVision.GeneratedObjects.RegularExpressions", IsSelected = true });
            clDatabaseNamespace.Add(new DatabaseNamespace() { DatabaseId = 1, NamespaceName = "SaiVision.GeneratedObjects.Enterprize", IsSelected = true });
            
            target.SaveDatabaseNamespaces(clDatabaseNamespace);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }
    }
}
