using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class TableMetaDataCollection : List<TableMetaData>
    {
        #region [ Properties ]
        public TableMetaData this[string tableName]
        {
            get
            {
                TableMetaData tmd = this.Find(t => t.TableName.Equals(tableName));
                return tmd;
            }
        }
        #endregion
    }
}
