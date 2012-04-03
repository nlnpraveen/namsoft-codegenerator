using CECity.Enterprise.DataManager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using CECity.Enterprise.DataModel;
using System.Collections.Generic;
using SaiVision.Platform.Common;

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
            target.AddJobTest(job);
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
            int jobId = 4; // TODO: Initialize to an appropriate value
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
            int jobId = 5; // TODO: Initialize to an appropriate value
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
            int jobId = 3; // TODO: Initialize to an appropriate value
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
    }
}
