using CECity.Enterprise.DataManager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using CECity.Enterprise.DataModel;

namespace SaiVision.Platform.CodeGenerator.DataManagers.Tests
{
    
    
    /// <summary>
    ///This is a test class for JobDataManagerTest and is intended
    ///to contain all JobDataManagerTest Unit Tests
    ///</summary>
    [TestClass()]
    public class JobDataManagerTest
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
            JobDataManager target = JobDataManager.GetInstance(); // TODO: Initialize to an appropriate value
            Job job = new Job() { Name = "RCP.CreditValidationResults"
                ,GroupName = "RCP.EmailNotifications"
                ,Description = "Sends an email displaying the credit validation resutls for participant's CPD activities. It is scheduled to run every Friday at 5 PM."
                ,AssemblyName = "CECity.CommandCenter.Lifetime", ClassName="CECity.CommandCenter.Lifetime.CreditValidationResultEmailJob"
                ,IsActive = true
                , TempBigInt = 123
                //, TempChar = 'a'
                , TempDate = DateTime.Now
                , TempDateTime = DateTime.Now
                //, TempDateDefault = DateTime.Now
                , TempInt = 123
                , TempTinyInt = 10
                //, TempGuid = new Guid("C4BD1604-7A5B-E111-A5C9-00219B05EF45")
            }; // TODO: Initialize to an appropriate value
            target.AddJob(job);
        }
    }
}
