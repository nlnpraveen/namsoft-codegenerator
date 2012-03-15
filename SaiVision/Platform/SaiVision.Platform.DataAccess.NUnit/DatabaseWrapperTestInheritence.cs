using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using System.Data.Common;
using System.Data;

namespace SaiVision.Platform.DataAccess.NUnit
{
    [TestFixture]
    public class DatabaseWrapperTestInheritence : DatabaseWrapper
    {
        [Test]
        public void ExecuteDatasetWithReturnParameters()
        {
            DbCommand cmd = null;
            try
            {
                cmd = db.GetStoredProcCommand("ROLE_BaseRoles_Get");
                db.AddParameter(cmd, "ReturnValue", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Current, string.Empty);

                db.ExecuteDataSet(cmd);
            }
            catch (Exception ex)
            {
                if (cmd != null)
                {
                    string s = db.GetParameterValue(cmd, "ReturnValue").ToString();
                    Console.WriteLine("This is the GUID value: {0}", s);
                    Console.WriteLine("Integer.MaxValue: {0}", int.MaxValue);
                }         
            }
        }
    }
}
