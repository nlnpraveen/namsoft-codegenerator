using SaiVision.Tools.CodeGenerator.Manager;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;

namespace SaiVision.Tools.CodeGenerator.Manager.Tests
{
    
    
    /// <summary>
    ///This is a test class for UtilityTest and is intended
    ///to contain all UtilityTest Unit Tests
    ///</summary>
    [TestClass()]
    public class UtilityTest
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
        ///A test for ConvertToPascalCase
        ///</summary>
        [TestMethod()]
        public void ConvertToPascalCaseTest()
        {
            string input = "JOB"; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = Utility.ConvertToPascalCase(input);
            //Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Verify the correctness of this test method.");
            Console.WriteLine(actual);
        }

        /// <summary>
        ///A test for ConvertToPascalCase
        ///</summary>
        [TestMethod()]
        public void ConvertToPascalCaseTest1()
        {
            string input = "LOCK_EntityLock"; // TODO: Initialize to an appropriate value
            List<string> prefixes = new List<string>() { "LOCK" }; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = Utility.ConvertToPascalCase(input, prefixes);
            Console.WriteLine(actual);
        }

        /// <summary>
        ///A test for ConvertToCamelCase
        ///</summary>
        [TestMethod()]
        public void ConvertToCamelCaseTest()
        {
            string input = "LOCK_LockConstant"; // TODO: Initialize to an appropriate value
            //input = "_";
            List<string> prefixes = new List<string>() {"_" };; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = Utility.ConvertToCamelCase(input, prefixes);
            Console.WriteLine(actual);            
        }
    }
}
