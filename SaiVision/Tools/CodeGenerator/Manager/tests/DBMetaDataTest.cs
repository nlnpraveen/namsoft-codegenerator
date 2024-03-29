﻿using SaiVision.Tools.CodeGenerator.Manager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;
using System.Text;
using System.Xml;

namespace SaiVision.Tools.CodeGenerator.Manager.Tests
{
    
    
    /// <summary>
    ///This is a test class for DBMetaDataTest and is intended
    ///to contain all DBMetaDataTest Unit Tests
    ///</summary>
    [TestClass()]
    public class DBMetaDataTest
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
        ///A test for Synchronize
        ///</summary>
        [TestMethod()]
        public void SynchronizeMetadata()
        {
            List<DBMetaData> dbs = DBManager.GetInstance().GetConfiguredDataBases();

            foreach (DBMetaData db in dbs)
            {
                db.Synchronize();

                /*
                XmlSerializer xser = new XmlSerializer(db.GetType());
                FileStream fs = new FileStream(@"C:\DBQueries\Tutorials\openxml\DBMetaData\DBMetaData_Xml_Serializer1.xml", FileMode.Create);
                xser.Serialize(fs, db);
                fs.Close();
                 */
            }
               
        }
    }
}
