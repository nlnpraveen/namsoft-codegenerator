using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Xml.Serialization;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class ColumnMetaData
    {
        #region [ Fields ]

        #endregion

        #region [ Properties ]
        /// <summary>
        /// Gets or sets the name of the table.
        /// </summary>
        /// <value>The name of the table.</value>
        [XmlAttribute()]
        public string TableName { get; set; }

        /// <summary>
        /// Gets or sets the name of the column.
        /// </summary>
        /// <value>The name of the column.</value>
        [XmlAttribute()]
        public string ColumnName { get; set; }

        /// <summary>
        /// Gets or sets the column name pascal.
        /// </summary>
        /// <value>The column name pascal.</value>
        [XmlAttribute()]
        public string ColumnNamePascal { get; set; }

        /// <summary>
        /// Gets or sets the column name camel.
        /// </summary>
        /// <value>The column name camel.</value>
        [XmlAttribute()]
        public string ColumnNameCamel { get; set; }

        /// <summary>
        /// Gets or sets the column default.
        /// </summary>
        /// <value>The column default.</value>
        [XmlAttribute()]
        public string ColumnDefault { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is nullable type.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is nullable type; otherwise, <c>false</c>.
        /// </value>
        [XmlIgnore()]
        public bool IsNullableType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is nullable.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is nullable; otherwise, <c>false</c>.
        /// </value>
        [XmlAttribute()]
        public Boolean IsNullable { get; set; }

        /// <summary>
        /// Gets or sets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
        [XmlAttribute()]
        public string DataType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is identity.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is identity; otherwise, <c>false</c>.
        /// </value>
        [XmlAttribute()]
        public bool IsIdentity { get; set; }

        [XmlAttribute()]
        public int ColumnOrder { get; set; }

        [XmlAttribute()]
        public Int16 NumericPrecision { get; set; }

        [XmlAttribute()]
        public int NumericScale { get; set; }

        [XmlAttribute()]
        public int CharacterMaximumLength { get; set; }
        #endregion

        #region [ Ctor ]
        public ColumnMetaData() { }

        public ColumnMetaData(DataRow row)
        {            
            TableName = (row.Table.Columns.Contains("TableName") && row["TableName"] != DBNull.Value) ? row["TableName"].ToString() : TableName;
            ColumnName = (row.Table.Columns.Contains("ColumnName") && row["ColumnName"] != DBNull.Value) ? row["ColumnName"].ToString() : ColumnName;
            ColumnNamePascal = (row.Table.Columns.Contains("ColumnNamePascal") && row["ColumnNamePascal"] != DBNull.Value) ? row["ColumnNamePascal"].ToString() : ColumnNamePascal;
            ColumnNameCamel = (row.Table.Columns.Contains("ColumnNameCamel") && row["ColumnNameCamel"] != DBNull.Value) ? row["ColumnNameCamel"].ToString() : ColumnNameCamel;
            ColumnDefault = (row.Table.Columns.Contains("ColumnDefault") && row["ColumnDefault"] != DBNull.Value) ? row["ColumnDefault"].ToString() : ColumnDefault;
            IsNullable = (row.Table.Columns.Contains("IsNullable") && row["IsNullable"] != DBNull.Value) ? (row["IsNullable"].ToString().Equals("NO") ? false : true) : IsNullable;
            DataType = (row.Table.Columns.Contains("DataType") && row["DataType"] != DBNull.Value) ? row["DataType"].ToString() : DataType;
            IsIdentity = (row.Table.Columns.Contains("IsIdentity") && row["IsIdentity"] != DBNull.Value) ? bool.Parse(row["IsIdentity"].ToString()) : IsIdentity;
            NumericPrecision = (row.Table.Columns.Contains("NumericPrecision") && row["NumericPrecision"] != DBNull.Value) ? short.Parse(row["NumericPrecision"].ToString()) : NumericPrecision;
            NumericScale = (row.Table.Columns.Contains("NumericScale") && row["NumericScale"] != DBNull.Value) ? int.Parse(row["NumericScale"].ToString()) : NumericScale;
            CharacterMaximumLength = (row.Table.Columns.Contains("CharacterMaximumLength") && row["CharacterMaximumLength"] != DBNull.Value) ? int.Parse(row["CharacterMaximumLength"].ToString()) : CharacterMaximumLength;
            ColumnOrder = (row.Table.Columns.Contains("ColumnOrder") && row["ColumnOrder"] != DBNull.Value) ? int.Parse(row["ColumnOrder"].ToString()) : ColumnOrder;

            // Column will be a nullable type if it is either nullable in the database
            // or has a default value associated with it

            // To diable nullable types. Just make this value false
            IsNullableType = (IsNullable || ColumnDefault != null);
            
        }
        #endregion
    }
}
