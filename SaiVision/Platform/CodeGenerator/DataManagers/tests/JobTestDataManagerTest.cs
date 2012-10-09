using CECity.Enterprise.DataManager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using CECity.Enterprise.DataModel;
using System.Collections.Generic;
using SaiVision.Platform.Common.Serialization;

namespace SaiVision.Platform.CodeGenerator.DataManagers.Tests
{
    
    
    /// <summary>
    ///This is a test class for JobTestDataManagerTest and is intended
    ///to contain all JobTestDataManagerTest Unit Tests
    ///</summary>
    [TestClass()]
    public class JobTestDataManagerTest
    {


        private TestContext testContextInstance;
        private static int _jobId;

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
        //Use ClassInitialize to run code before running the first test in the class
        [ClassInitialize()]
        public static void MyClassInitialize(TestContext testContext)
        {
            Console.WriteLine("Initializing Test Class");
        }
        
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
        ///A test for AddJob
        ///</summary>
        [TestMethod()]
        public void AddJobTest()
        {
            JobTestDataManager target = JobTestDataManager.GetInstance(); // TODO: Initialize to an appropriate value
            
            JobTest job = new JobTest()
            {
                AssemblyName = "JobAssembly " + new Random().Next(),
                ClassName = "JobClass",
                Description = "JobDescription",
                GroupName = "JobGroupName",
                //IsActive = true,
                Name = "AutoGeneratorJob",
                //TempChar = "MyTempChar",
                TempNChar = "MyTempNChar",
                TempNText = "MyTempNText",
                TempNVarCharMax = "MyTempNVarCharMax",
                TempText = "MyTempText",
                TempVarchar = "MyTempVarChar",
                TempFloat = 36.5F,
                TempGuid = Guid.NewGuid()
            };
            _jobId = target.AddJobTest(job);
        }


        /// <summary>
        ///A test for GetAllJobTests
        ///</summary>
        [TestMethod()]
        public void GetAllJobTestsTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            List<JobTest> expected = null; // TODO: Initialize to an appropriate value
            List<JobTest> actual;
            actual = target.GetAllJobTests();
            Console.Write(DataContractSerializationHelper.ToXmlString(actual, false));
            //Assert.AreEqual(4, actual.Count);
            //Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetJobTestByJobId
        ///</summary>
        [TestMethod()]
        public void GetJobTestByJobIdTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            int jobId = _jobId; // TODO: Initialize to an appropriate value
            JobTest expected = null; // TODO: Initialize to an appropriate value
            JobTest actual;
            actual = target.GetJobTestByJobId(jobId);
            Console.Write(DataContractSerializationHelper.ToXmlString(actual, false));
            //Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for UpdateJobTest
        ///</summary>
        [TestMethod()]
        public void UpdateJobTestTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            int jobId = _jobId; // TODO: Initialize to an appropriate value
            JobTest jobTest = target.GetJobTestByJobId(jobId); // TODO: Initialize to an appropriate value
            jobTest.AssemblyName = "Assembly Update " + jobId;
            jobTest.ClassName = "Class Update " + jobId;
            jobTest.GroupName = "GroupName Update " + jobId;
            jobTest.IsActive = false;
            target.UpdateJobTest(jobTest);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for DeleteByJobId
        ///</summary>
        [TestMethod()]
        public void DeleteByJobIdTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            int jobId = _jobId - 1; // TODO: Initialize to an appropriate value
            target.DeleteByJobId(jobId);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for GetJobTestBy_IsActive
        ///</summary>
        [TestMethod()]
        public void GetJobTestBy_IsActiveTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            bool isActive = true; // TODO: Initialize to an appropriate value
            List<JobTest> expected = null; // TODO: Initialize to an appropriate value
            List<JobTest> actual;
            actual = target.GetJobTestBy_IsActive(isActive);
            Console.Write(DataContractSerializationHelper.ToXmlString(actual, false));
        }

        /// <summary>
        ///A test for UpdateJobTestBy_GroupName
        ///</summary>
        [TestMethod()]
        public void UpdateJobTestBy_GroupNameTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            int jobId = _jobId; // TODO: Initialize to an appropriate value
            JobTest jobTest = target.GetJobTestByJobId(jobId); // TODO: Initialize to an appropriate value
            jobTest.Description = "JobDescription updated by group name";

            target.UpdateJobTestBy_GroupName(jobTest);
            
        }

        /// <summary>
        ///A test for DeleteJobTestBy_IsActive
        ///</summary>
        [TestMethod()]
        public void DeleteJobTestBy_IsActiveTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            bool isActive = false; // TODO: Initialize to an appropriate value
            target.DeleteJobTestBy_IsActive(isActive);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for UpdateJobTestBulk
        ///</summary>
        [TestMethod()]
        public void UpdateJobTestBulkTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            //JobTest job = target.GetJobTestByJobId(98);
            List<JobTest> jobTestXml = target.GetAllJobTests();
            jobTestXml[0].TempBigInt = 14;
            jobTestXml[1].TempBigInt = 24;
            jobTestXml[2].TempNChar = "CharviNDattu";
            target.UpdateJobTestBulk(jobTestXml);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for DeleteJobTestBulk
        ///</summary>
        [TestMethod()]
        public void DeleteJobTestBulkTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            List<JobTest> jobTestXml = target.GetAllJobTests();
            target.DeleteJobTestBulk(jobTestXml);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for InsertJobTestBulk
        ///</summary>
        [TestMethod()]
        public void InsertJobTestBulkTest()
        {
            JobTestDataManager target = new JobTestDataManager(); // TODO: Initialize to an appropriate value
            List<JobTest> jobTestXml = new List<JobTest>(); // TODO: Initialize to an appropriate value
            JobTest job = new JobTest()
            {
                AssemblyName = "Charvi come here " + new Random().Next(),
                ClassName = "Charvi is 14 months old",
                Description = "She is becoming naughty",
                GroupName = "MessIsMyFavorite",
                //IsActive = true,
                Name = "Charvi Babby",
                //TempChar = "MyTempChar",
                TempNChar = "MyTempNChar",
                TempNText = "MyTempNText",
                TempNVarCharMax = "MyTempNVarCharMax",
                TempText = "MyTempText",
                TempVarchar = "MyTempVarChar",
                TempFloat = 13.8F,
                TempGuid = Guid.NewGuid(),
                TempInt = 14
            };
            jobTestXml.Add(job);

            job = new JobTest()
            {
                AssemblyName = "Dattu naughty " + new Random().Next(),
                ClassName = "Dattu is 2 years 2 months old",
                Description = "He is already naughty",
                GroupName = "MessChessIsMyFavorite",
                //IsActive = true,
                Name = "Dattu the king",
                //TempChar = "MyTempChar",
                TempNChar = "DattuNChar",
                TempNText = "DattuTempNText",
                TempNVarCharMax = "DattuTempNVarCharMax",
                TempText = "DattuTempText",
                TempVarchar = "DattuTempVarChar",
                TempFloat = 25.8F,                
                TempInt = 16
            };
            jobTestXml.Add(job);

            job = new JobTest()
            {
                AssemblyName = "Charvi sends rakhi to dattu " + new Random().Next(),
                ClassName = "Dattu likes the rakhi",
                Description = "It is blue and white color rakhi",
                GroupName = "Rakshabandhan",
                //IsActive = true,
                Name = "CharviDataRakhi",
                //TempChar = "MyTempChar",
                TempNChar = "CharviDattuNChar",
                TempNText = "CharviDattuTempNText",
                TempNVarCharMax = "CharviDattuTempNVarCharMax",
                TempText = "CharviDattuTempText",
                TempVarchar = "CharviDattuTempVarChar",
                TempFloat = 41.8F,                
                TempInt = 42
            };
            jobTestXml.Add(job);

            target.InsertJobTestBulk(jobTestXml);
            //Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }
    }
}
