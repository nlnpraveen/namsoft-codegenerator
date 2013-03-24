using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SaiVision.Tools.CodeGenerator.DataAccess;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using SaiVision.Platform.CommonUtil.Serialization;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    [DataContract()]
    public class DBMetaData
    {
        #region [ Fields ]
        TableMetaDataCollection _tables;
        #endregion

        #region [ Properties ]

        [XmlAttribute()]
        public int DataBaseId { get; set; }

        [XmlAttribute()]
        public string DatabaseName { get; set; }

        [XmlIgnore()]
        public DateTime? LastSyncDate { get; set; }

        /// <summary>
        /// Gets the tables.
        /// </summary>
        /// <value>The tables.</value>
        [DataMember()]
        public TableMetaDataCollection Tables
        {
            get
            {               
                return _tables;
            }
            set
            {
                _tables = value;
            }
        }
        #endregion

        #region [ Constructor ]            
        /// <summary>
        /// Initializes a new instance of the <see cref="DBMetaData" /> class.
        /// </summary>
        public DBMetaData() { _tables = new TableMetaDataCollection(); }

        /// <summary>
        /// Initializes a new instance of the <see cref="DBMetaData" /> class.
        /// </summary>
        /// <param name="row">The row.</param>
        public DBMetaData(DataRow row)
        {
            DataBaseId = (row["CGEN_MasterDatabaseId"] == DBNull.Value) ? DataBaseId : int.Parse(row["CGEN_MasterDatabaseId"].ToString());
            DatabaseName = (row["DatabaseName"] == DBNull.Value) ? string.Empty : row["DatabaseName"].ToString();
            LastSyncDate = (row["LastSyncDate"] == DBNull.Value) ? LastSyncDate : DateTime.Parse(row["LastSyncDate"].ToString());
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="DBMetaData" /> class.
        /// </summary>
        /// <param name="metaData">The meta data.</param>
        public DBMetaData(DataSet metaData)
        {
            PopulateMetaData(metaData);
        }        
        #endregion

        #region [ Public Methods ]
        public void Synchronize()
        {
            DataSet metaData = NamsMetadataDM.GetDataBaseMetaData(this.DatabaseName, LastSyncDate);
            PopulateMetaData(metaData);

            string xmlMetadata = XmlSerializationHelper.ToXmlString(this, false);
            NamsMetadataDM.MetadataSynchronize(xmlMetadata);
        }

        public void SaveConfiguration()
        {
            string xmlMetadata = XmlSerializationHelper.ToXmlString(this, false);
            NamsMetadataDM.MetadataSaveConfiguration(xmlMetadata);
        }
        #endregion

        #region [ Private Methods ]
        private void PopulateMetaData(DataSet metaData)
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
