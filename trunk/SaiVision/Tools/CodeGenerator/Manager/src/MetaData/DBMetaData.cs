using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class DBMetaData
    {
        #region [ Fields ]
        TableMetaDataCollection _tables;
        #endregion

        #region [ Properties ]
        /// <summary>
        /// Gets the tables.
        /// </summary>
        /// <value>The tables.</value>
        public TableMetaDataCollection Tables
        {
            get
            {               
                return _tables;
            }
        }
        #endregion

        #region [ Constructor ]
        public DBMetaData() { }

        public DBMetaData(DataSet metaData)
        {
            DataTable dtTables = metaData.Tables["Tables"];
            _tables = new TableMetaDataCollection();
            foreach (DataRow row in dtTables.Rows)
            {
                TableMetaData tmd = new TableMetaData(row, metaData.Tables["Columns"]);               
                _tables.Add(tmd);
            }
        }
        #endregion
    }
}
