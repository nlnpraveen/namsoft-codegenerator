using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using MicroMvvm;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    [XmlType(TypeName = "DatabaseNamespace")]
    public class DatabaseNamespace : ObservableObject
    {
        #region [ Fields ]        
        #endregion

        #region [ CTOR ]
        /// <summary>
        /// Initializes a new instance of the <see cref="DatabaseNamespace"/> class.
        /// </summary>
        public DatabaseNamespace() { }

        public DatabaseNamespace(DataRow row) 
        {
            _DatabaseId = (row["DatabaseId"] == DBNull.Value) ? _DatabaseId : int.Parse(row["DatabaseId"].ToString());
            _NamespaceId = (row["CGEN_NamespaceId"] == DBNull.Value) ? _NamespaceId : int.Parse(row["CGEN_NamespaceId"].ToString());
            _NamespaceName = (row["NamespaceName"] == DBNull.Value) ? string.Empty : row["CGEN_NamespaceId"].ToString();
            _IsSelected = (row["IsSelected"] == DBNull.Value) ? _IsSelected : bool.Parse(row["IsSelected"].ToString());            
        }
        #endregion

        #region [ Properties ]
        private int _DatabaseId;
        /// <summary>
        /// Gets or sets the database id.
        /// </summary>
        /// <value>
        /// The database id.
        /// </value>
        [XmlAttribute()]
        public int DatabaseId { get { return _DatabaseId; } set { _DatabaseId = value; RaisePropertyChanged("DatabaseId"); } }

        private int? _NamespaceId;
        /// <summary>
        /// Gets or sets the namespace id.
        /// </summary>
        /// <value>
        /// The namespace id.
        /// </value>
        [XmlIgnore()]
        public int? NamespaceId { get { return _NamespaceId; } set { _NamespaceId = value; RaisePropertyChanged("NamespaceId"); } }

        [XmlAttribute("NamespaceId")]
        public string NamespaceIdStr
        {
            get
            {
                return NamespaceId.HasValue ? NamespaceId.ToString() : "null";
            }
            set
            {
                int _namespaceId;
                if (!value.Equals("null") && int.TryParse(value, out _namespaceId))
                    NamespaceId = _namespaceId;
                else
                    NamespaceId = null;

                NamespaceIdStr = value;
            }
        }

        private bool _IsSelected;
        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is selected; otherwise, <c>false</c>.
        /// </value>
        [XmlAttribute()]
        public bool IsSelected { get { return _IsSelected; } set { _IsSelected = value; RaisePropertyChanged("IsSelected"); } }

        private string _NamespaceName;
        /// <summary>
        /// Gets or sets the name of the namespace.
        /// </summary>
        /// <value>
        /// The name of the namespace.
        /// </value>
        [XmlAttribute()]
        public string NamespaceName { get { return _NamespaceName; } set { _NamespaceName = value; RaisePropertyChanged("NamespaceName"); } }
        #endregion
    }
}
