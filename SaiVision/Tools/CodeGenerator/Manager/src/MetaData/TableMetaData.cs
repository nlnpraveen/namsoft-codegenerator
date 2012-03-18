using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class TableMetaData
    {
        #region [ Fields ]
        ColumnMetaDataCollection _Columns;
        #endregion

        #region [ Properties ]
        /// <summary>
        /// Gets or sets the name of the table.
        /// </summary>
        /// <value>The name of the table.</value>
        public string TableName { get; set; }
        public string TableNamePascal { get; set; }
        public string TableNameCamel { get; set; }

        public string PrimaryKeyNames { get; set; }
        public string PrimaryKeyNamesPascal { get; set; }
        public string PrimaryKeyNamesCamel { get; set; }

        public string[] PrimaryKey { get; set; }
        public string[] PrimaryKeyPascal { get; set; }
        public string[] PrimaryKeyCamel { get; set; }

        public bool IsSelect { get; set; }
        public bool IsInsert { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is select by PK.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is select by PK; otherwise, <c>false</c>.
        /// </value>
        public bool IsSelectByPK { get; set; }
        public bool IsUpdateByPK { get; set; }
        public bool IsDeleteByPK { get; set; }
        public bool IsSelectByColumns { get; set; }
        public bool IsUpdateByColumns { get; set; }
        public bool IsDeleteByColumns { get; set; }

        public string SelectProc { get; set; }
        public string SelectByPKProc { get; set; }
        public string UpdateByPKProc { get; set; }
        public string DeleteByPKProc { get; set; }
        public string SelectByColumnsProc { get; set; }
        public string UpdateByColumnsProc { get; set; }
        public string DeleteByColumnsProc { get; set; }
        public string[] QueryColumns { get; set; }
        public string[] QueryColumnsPascal { get; set; }
        public string[] QueryColumnsCamel { get; set; }

        public string QueryColumnsNames { get; set; }
        public string QueryColumnsNamesPascal { get; set; }
        public string QueryColumnsNamesCamel { get; set; }


        public ColumnMetaDataCollection Columns
        {
            get
            {
                return _Columns;
            }
        }
        #endregion

        #region [ CTOR ]
        public TableMetaData() { }

        public TableMetaData(DataRow row, DataTable dtColumns)
        {
            TableName = (row["TableName"] == DBNull.Value) ? TableName : row["TableName"].ToString();
            TableNamePascal = (row["TableNamePascal"] == DBNull.Value) ? TableNamePascal : row["TableNamePascal"].ToString();
            TableNameCamel = (row["TableNameCamel"] == DBNull.Value) ? TableNameCamel : row["TableNameCamel"].ToString();
            IsSelect = (row["IsSelect"] == DBNull.Value) ? IsSelect : bool.Parse(row["IsSelect"].ToString());
            IsInsert = (row["IsInsert"] == DBNull.Value) ? IsInsert : bool.Parse(row["IsInsert"].ToString());
            IsSelectByPK = (row["IsSelectByPK"] == DBNull.Value) ? IsSelectByPK : bool.Parse(row["IsSelectByPK"].ToString());
            IsUpdateByPK = (row["IsUpdateByPK"] == DBNull.Value) ? IsUpdateByPK : bool.Parse(row["IsUpdateByPK"].ToString());
            IsDeleteByPK = (row["IsDeleteByPK"] == DBNull.Value) ? IsDeleteByPK : bool.Parse(row["IsDeleteByPK"].ToString());
            IsSelectByColumns = (row["IsSelectByColumns"] == DBNull.Value) ? IsSelectByColumns : bool.Parse(row["IsSelectByColumns"].ToString());
            IsUpdateByColumns = (row["IsUpdateByColumns"] == DBNull.Value) ? IsUpdateByColumns : bool.Parse(row["IsUpdateByColumns"].ToString());
            IsDeleteByColumns = (row["IsDeleteByColumns"] == DBNull.Value) ? IsDeleteByColumns : bool.Parse(row["IsDeleteByColumns"].ToString());

            SelectProc = (row["SelectProc"] == DBNull.Value) ? SelectProc : row["SelectProc"].ToString();
            SelectByPKProc = (row["SelectByPKProc"] == DBNull.Value) ? SelectByPKProc : row["SelectByPKProc"].ToString();
            UpdateByPKProc = (row["UpdateByPKProc"] == DBNull.Value) ? UpdateByPKProc : row["UpdateByPKProc"].ToString();
            DeleteByPKProc = (row["DeleteByPKProc"] == DBNull.Value) ? DeleteByPKProc : row["DeleteByPKProc"].ToString();
            SelectByColumnsProc = (row["SelectByColumnsProc"] == DBNull.Value) ? SelectByColumnsProc : row["SelectByColumnsProc"].ToString();
            UpdateByColumnsProc = (row["UpdateByColumnsProc"] == DBNull.Value) ? UpdateByColumnsProc : row["UpdateByColumnsProc"].ToString();
            DeleteByColumnsProc = (row["DeleteByColumnsProc"] == DBNull.Value) ? DeleteByColumnsProc : row["DeleteByColumnsProc"].ToString();

            /* Primary Key */
            if (row["PrimaryKey"] != DBNull.Value)
            {
                string val = row["PrimaryKey"].ToString();
                PrimaryKey = val.Split(new char[] { ',' });
                PrimaryKeyNames = val;
            }
            if (row["PrimaryKeyPascal"] != DBNull.Value)
            {
                string val = row["PrimaryKeyPascal"].ToString();
                PrimaryKeyPascal = val.Split(new char[] { ',' });
                PrimaryKeyNamesPascal = val;
            }
            if (row["PrimaryKeyCamel"] != DBNull.Value)
            {
                string val = row["PrimaryKeyCamel"].ToString();
                PrimaryKeyCamel = val.Split(new char[] { ',' });
                PrimaryKeyNamesCamel = val;
            }

            /* Query Columns */
            if (row["QueryColumns"] != DBNull.Value)
            {
                string val = row["QueryColumns"].ToString();
                QueryColumns = val.Split(new char[] { ',' });
                QueryColumnsNames = val;
            }
            if (row["QueryColumnsPascal"] != DBNull.Value)
            {
                string val = row["QueryColumnsPascal"].ToString();
                QueryColumnsPascal = val.Split(new char[] { ',' });
                QueryColumnsNamesPascal = val;
            }
            if (row["QueryColumnsCamel"] != DBNull.Value)
            {
                string val = row["QueryColumnsCamel"].ToString();
                QueryColumnsCamel = val.Split(new char[] { ',' });
                QueryColumnsNamesCamel = val;
            }


            // Columns
            DataRow[] columnRows = dtColumns.Select(string.Format("TableName='{0}'", TableName));
            _Columns = new ColumnMetaDataCollection();
            foreach (DataRow rowColumn in columnRows)
            {
                ColumnMetaData tmd = new ColumnMetaData(rowColumn);
                _Columns.Add(tmd);
            }
        }
        #endregion
    }
}
