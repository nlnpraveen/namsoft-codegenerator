using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

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
        public string TableName { get; set; }

        /// <summary>
        /// Gets or sets the name of the column.
        /// </summary>
        /// <value>The name of the column.</value>
        public string ColumnName { get; set; }

        /// <summary>
        /// Gets or sets the column name pascal.
        /// </summary>
        /// <value>The column name pascal.</value>
        public string ColumnNamePascal { get; set; }

        /// <summary>
        /// Gets or sets the column name camel.
        /// </summary>
        /// <value>The column name camel.</value>
        public string ColumnNameCamel { get; set; }

        /// <summary>
        /// Gets or sets the column default.
        /// </summary>
        /// <value>The column default.</value>
        public string ColumnDefault { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is nullable type.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is nullable type; otherwise, <c>false</c>.
        /// </value>
        public bool IsNullableType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is nullable.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is nullable; otherwise, <c>false</c>.
        /// </value>
        public Boolean IsNullable { get; set; }

        /// <summary>
        /// Gets or sets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
        public string DataType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is identity.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is identity; otherwise, <c>false</c>.
        /// </value>
        public bool IsIdentity { get; set; }
        #endregion

        #region [ Ctor ]
        public ColumnMetaData() { }

        public ColumnMetaData(DataRow row)
        {
            TableName = (row["TableName"] == DBNull.Value) ? TableName : row["TableName"].ToString();
            ColumnName = (row["ColumnName"] == DBNull.Value) ? ColumnName : row["ColumnName"].ToString();
            ColumnNamePascal = (row["ColumnNamePascal"] == DBNull.Value) ? ColumnNamePascal : row["ColumnNamePascal"].ToString();
            ColumnNameCamel = (row["ColumnNameCamel"] == DBNull.Value) ? ColumnNameCamel : row["ColumnNameCamel"].ToString();
            ColumnDefault = (row["ColumnDefault"] == DBNull.Value) ? ColumnDefault : row["ColumnDefault"].ToString();
            IsNullable = (row["IsNullable"] == DBNull.Value) ? IsNullable : (row["IsNullable"].ToString().Equals("NO") ? false : true);
            DataType = (row["DataType"] == DBNull.Value) ? DataType : row["DataType"].ToString();
            IsIdentity = (row["IsNullable"] == DBNull.Value) ? IsIdentity : (row["IsIdentity"].ToString().Equals("0") ? false : true);

            // Column will be a nullable type if it is either nullable in the database
            // or has a default value associated with it

            // To diable nullable types. Just make this value false
            IsNullableType = (IsNullable || ColumnDefault != null);
            
        }
        #endregion
    }
}
