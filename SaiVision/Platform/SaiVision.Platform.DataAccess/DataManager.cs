using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;

namespace SaiVision.Platform.DataAccess
{
    public class DataManager
    {
        public DataManager() { }

        public DataSet GetBaseRoles()
        {
            DatabaseWrapper wrapper = new DatabaseWrapper();

            DbCommand cmd = wrapper.GetStoredProcCommand("ROLE_BaseRoles_Get");
            DataSet roleDataSet = wrapper.ExecuteDataSet(cmd);
            return roleDataSet;
        }

        public IDataReader GetBaseRolesReader()
        {
            DatabaseWrapper wrapper = new DatabaseWrapper();

            DbCommand cmd = wrapper.GetStoredProcCommand("ROLE_BaseRoles_Get");
            IDataReader reader = wrapper.ExecuteReader(cmd);
            
            return reader;
        }

        public string GetRoleName(int roleId)
        {
            DatabaseWrapper wrapper = new DatabaseWrapper();

            DbCommand cmd = wrapper.GetStoredProcCommand("ROLE_BaseRoles_GetRoleName");
            wrapper.AddInParameter(cmd, "RoleId", DbType.Int32, roleId);
            wrapper.AddOutParameter(cmd, "RoleName", DbType.String, 100);
            wrapper.ExecuteNonQuery(cmd);

            string roleName = wrapper.GetParameterValue(cmd, "RoleName").ToString();

            return roleName;
        }

    }
}
