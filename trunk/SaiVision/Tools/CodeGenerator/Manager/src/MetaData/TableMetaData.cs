using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using SaiVision.Platform.MvvmInfrastructure.DomainModel;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class TableMetaData : DomainObject
    {
        #region [ Fields ]
        ColumnMetaDataCollection _Columns;
        private int _rowId;
        #endregion

        #region [ Properties ]        
        [XmlAttribute()]
        public int TableId { get; set; }
        /// <summary>
        /// Gets or sets the name of the table.
        /// </summary>
        /// <value>The name of the table.</value>        
        [XmlAttribute()]
        public string TableName { get; set; }
        [XmlAttribute()]
        public string TableNamePascal { get; set; }
        [XmlAttribute()]
        public string TableNameCamel { get; set; }

        [XmlAttribute()]
        public string PrimaryKeyNames { get; set; }
        [XmlAttribute()]
        public string PrimaryKeyNamesPascal { get; set; }
        [XmlAttribute()]
        public string PrimaryKeyNamesCamel { get; set; }
        [XmlIgnore()]
        public string NamespaceName { get; set; }
        [XmlAttribute()]
        public int NamespaceId { get; set; }

        [XmlAttribute()]
        public bool IsGenerateCode { get; set; }
        [XmlAttribute()]
        public bool IsGenerateCodeAlways { get; set; }

        [XmlIgnore()]
        public string[] PrimaryKey { get; set; }
        [XmlIgnore()]
        public string[] PrimaryKeyPascal { get; set; }
        [XmlIgnore()]
        public string[] PrimaryKeyCamel { get; set; }

        [XmlAttribute()]
        public bool IsSelect { get; set; }
        [XmlAttribute()]
        public bool IsInsert { get; set; }
        [XmlAttribute()]
        public bool IsInsertBulk { get; set; }
        [XmlAttribute()]
        public bool IsUpdateBulk { get; set; }
        [XmlAttribute()]
        public bool IsDeleteBulk { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is select by PK.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is select by PK; otherwise, <c>false</c>.
        /// </value>
        [XmlAttribute()]
        public bool IsSelectByPK { get; set; }
        [XmlAttribute()]
        public bool IsUpdateByPK { get; set; }
        [XmlAttribute()]
        public bool IsDeleteByPK { get; set; }
        [XmlAttribute()]
        public bool IsSelectByColumns { get; set; }
        [XmlAttribute()]
        public bool IsUpdateByColumns { get; set; }
        [XmlAttribute()]
        public bool IsDeleteByColumns { get; set; }

        [XmlIgnore()]
        public string SelectProc { get; set; }
        [XmlIgnore()]
        public string SelectByPKProc { get; set; }
        [XmlIgnore()]
        public string UpdateByPKProc { get; set; }
        [XmlIgnore()]
        public string DeleteByPKProc { get; set; }
        [XmlIgnore()]
        public string InsertBulkProc { get; set; }
        [XmlIgnore()]
        public string UpdateBulkProc { get; set; }
        [XmlIgnore()]
        public string DeleteBulkProc { get; set; }
        [XmlIgnore()]
        public string SelectByColumnsProc { get; set; }
        [XmlIgnore()]
        public string UpdateByColumnsProc { get; set; }
        [XmlIgnore()]
        public string DeleteByColumnsProc { get; set; }
        [XmlIgnore()]
        public string[] QueryColumns { get; set; }
        [XmlIgnore()]
        public string[] QueryColumnsPascal { get; set; }
        [XmlIgnore()]
        public string[] QueryColumnsCamel { get; set; }

        [XmlIgnore()]
        public string QueryColumnsNames { get; set; }
        [XmlIgnore()]
        public string QueryColumnsNamesPascal { get; set; }
        [XmlIgnore()]
        public string QueryColumnsNamesCamel { get; set; }

        [XmlIgnore()]
        public bool IsPrimary { get; set; }

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
            TableName = (row.Table.Columns.Contains("TableName") && row["TableName"] != DBNull.Value) ? row["TableName"].ToString() : TableName;
            TableNamePascal = (row.Table.Columns.Contains("TableNamePascal") && row["TableNamePascal"] != DBNull.Value) ? row["TableNamePascal"].ToString() : TableNamePascal;
            TableNameCamel = (row.Table.Columns.Contains("TableNameCamel") && row["TableNameCamel"] != DBNull.Value) ? row["TableNameCamel"].ToString() : TableNameCamel;
            NamespaceName = (row.Table.Columns.Contains("NamespaceName") && row["NamespaceName"] != DBNull.Value) ? row["NamespaceName"].ToString() : NamespaceName;
            NamespaceId = (row.Table.Columns.Contains("NamespaceId") && row["NamespaceId"] != DBNull.Value) ? int.Parse(row["NamespaceId"].ToString()) : NamespaceId;
            IsSelect = (row.Table.Columns.Contains("IsSelect") && row["IsSelect"] != DBNull.Value) ? bool.Parse(row["IsSelect"].ToString()) : IsSelect;
            IsInsert = (row.Table.Columns.Contains("IsInsert") && row["IsInsert"] != DBNull.Value) ? bool.Parse(row["IsInsert"].ToString()) : IsInsert;
            IsInsertBulk = (row.Table.Columns.Contains("IsInsertBulk") && row["IsInsertBulk"] != DBNull.Value) ? bool.Parse(row["IsInsertBulk"].ToString()) : IsInsertBulk;
            IsUpdateBulk = (row.Table.Columns.Contains("IsUpdateBulk") && row["IsUpdateBulk"] != DBNull.Value) ? bool.Parse(row["IsUpdateBulk"].ToString()) : IsUpdateBulk;
            IsDeleteBulk = (row.Table.Columns.Contains("IsDeleteBulk") && row["IsDeleteBulk"] != DBNull.Value) ? bool.Parse(row["IsDeleteBulk"].ToString()) : IsDeleteBulk;
            IsSelectByPK = (row.Table.Columns.Contains("IsSelectByPK") && row["IsSelectByPK"] != DBNull.Value) ? bool.Parse(row["IsSelectByPK"].ToString()) : IsSelectByPK;
            IsUpdateByPK = (row.Table.Columns.Contains("IsUpdateByPK") && row["IsUpdateByPK"] != DBNull.Value) ? bool.Parse(row["IsUpdateByPK"].ToString()) : IsUpdateByPK;
            IsDeleteByPK = (row.Table.Columns.Contains("IsDeleteByPK") && row["IsDeleteByPK"] != DBNull.Value) ? bool.Parse(row["IsDeleteByPK"].ToString()) : IsDeleteByPK;
            IsSelectByColumns = (row.Table.Columns.Contains("IsSelectByColumns") && row["IsSelectByColumns"] != DBNull.Value) ? bool.Parse(row["IsSelectByColumns"].ToString()) : IsSelectByColumns;
            IsUpdateByColumns = (row.Table.Columns.Contains("IsUpdateByColumns") && row["IsUpdateByColumns"] != DBNull.Value) ? bool.Parse(row["IsUpdateByColumns"].ToString()) : IsUpdateByColumns;
            IsDeleteByColumns = (row.Table.Columns.Contains("IsDeleteByColumns") && row["IsDeleteByColumns"] != DBNull.Value) ? bool.Parse(row["IsDeleteByColumns"].ToString()) : IsDeleteByColumns;

            SelectProc = (row.Table.Columns.Contains("SelectProc") && row["SelectProc"] != DBNull.Value) ? row["SelectProc"].ToString() : SelectProc;
            SelectByPKProc = (row.Table.Columns.Contains("SelectByPKProc") && row["SelectByPKProc"] != DBNull.Value) ? row["SelectByPKProc"].ToString() : SelectByPKProc;
            UpdateByPKProc = (row.Table.Columns.Contains("UpdateByPKProc") && row["UpdateByPKProc"] != DBNull.Value) ? row["UpdateByPKProc"].ToString() : UpdateByPKProc;
            DeleteByPKProc = (row.Table.Columns.Contains("DeleteByPKProc") && row["DeleteByPKProc"] != DBNull.Value) ? row["DeleteByPKProc"].ToString() : DeleteByPKProc;
            InsertBulkProc = (row.Table.Columns.Contains("InsertBulkProc") && row["InsertBulkProc"] != DBNull.Value) ? row["InsertBulkProc"].ToString() : InsertBulkProc;
            UpdateBulkProc = (row.Table.Columns.Contains("UpdateBulkProc") && row["UpdateBulkProc"] != DBNull.Value) ? row["UpdateBulkProc"].ToString() : UpdateBulkProc;
            DeleteBulkProc = (row.Table.Columns.Contains("DeleteBulkProc") && row["DeleteBulkProc"] != DBNull.Value) ? row["DeleteBulkProc"].ToString() : DeleteBulkProc;
            SelectByColumnsProc = (row.Table.Columns.Contains("SelectByColumnsProc") && row["SelectByColumnsProc"] != DBNull.Value) ? row["SelectByColumnsProc"].ToString() : SelectByColumnsProc;
            UpdateByColumnsProc = (row.Table.Columns.Contains("UpdateByColumnsProc") && row["UpdateByColumnsProc"] != DBNull.Value) ? row["UpdateByColumnsProc"].ToString() : UpdateByColumnsProc;
            DeleteByColumnsProc = (row.Table.Columns.Contains("DeleteByColumnsProc") && row["DeleteByColumnsProc"] != DBNull.Value) ? row["DeleteByColumnsProc"].ToString() : DeleteByColumnsProc;

            TableId = (row.Table.Columns.Contains("TableId") && row["TableId"] != DBNull.Value) ? int.Parse(row["TableId"].ToString()) : TableId;
            IsGenerateCode = (row.Table.Columns.Contains("IsGenerateCode") && row["IsGenerateCode"] != DBNull.Value) ? bool.Parse(row["IsGenerateCode"].ToString()) : IsGenerateCode;
            IsGenerateCodeAlways = (row.Table.Columns.Contains("IsGenerateCodeAlways") && row["IsGenerateCodeAlways"] != DBNull.Value) ? bool.Parse(row["IsGenerateCodeAlways"].ToString()) : IsGenerateCodeAlways;

            /* Primary Key */
            if (row.Table.Columns.Contains("PrimaryKey") && row["PrimaryKey"] != DBNull.Value)
            {
                string val = row["PrimaryKey"].ToString();
                if (val.EndsWith(",")) val = val.Remove(val.Length - 1);
                PrimaryKey = val.Split(new char[] { ',' });
                PrimaryKeyNames = val;
            }
            if (row.Table.Columns.Contains("PrimaryKeyPascal") && row["PrimaryKeyPascal"] != DBNull.Value)
            {
                string val = row["PrimaryKeyPascal"].ToString();
                PrimaryKeyPascal = val.Split(new char[] { ',' });
                PrimaryKeyNamesPascal = val;
            }
            if (row.Table.Columns.Contains("PrimaryKeyCamel") && row["PrimaryKeyCamel"] != DBNull.Value)
            {
                string val = row["PrimaryKeyCamel"].ToString();
                PrimaryKeyCamel = val.Split(new char[] { ',' });
                PrimaryKeyNamesCamel = val;
            }

            /* Query Columns */
            if (row.Table.Columns.Contains("QueryColumns") && row["QueryColumns"] != DBNull.Value)
            {
                string val = row["QueryColumns"].ToString();
                QueryColumns = val.Split(new char[] { ',' });
                QueryColumnsNames = val;
            }
            if (row.Table.Columns.Contains("QueryColumnsPascal") && row["QueryColumnsPascal"] != DBNull.Value)
            {
                string val = row["QueryColumnsPascal"].ToString();
                QueryColumnsPascal = val.Split(new char[] { ',' });
                QueryColumnsNamesPascal = val;
            }
            if (row.Table.Columns.Contains("QueryColumnsCamel") && row["QueryColumnsCamel"] != DBNull.Value)
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

            // Is Primary
            _rowId = (row.Table.Columns.Contains("RowId") && row["RowId"] != DBNull.Value) ? int.Parse(row["RowId"].ToString()) : 1;
            IsPrimary = (_rowId == 1) ? true : false;
            IsSelect = IsSelect && IsPrimary;
            IsInsert = IsInsert && IsPrimary;
            IsInsertBulk = IsInsertBulk && IsPrimary;
            IsUpdateBulk = IsUpdateBulk && IsPrimary;
            IsDeleteBulk = IsDeleteBulk && IsPrimary;
            IsSelectByPK = IsSelectByPK && IsPrimary;
            IsUpdateByPK = IsUpdateByPK && IsPrimary;
            IsDeleteByPK = IsDeleteByPK && IsPrimary;
        }
        #endregion
    }
}
