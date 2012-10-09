using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SaiVision.Tools.CodeGenerator.Manager;
using MicroMvvm;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace SaiVision.Tools.CodeGenerator.ViewModels
{
    public class TableViewModel : ObservableObject
    {
        #region [ Fields ]
        TableMetaData _Table;
        #endregion

        #region [ Properties ]
        /// <summary>
        /// Gets or sets the name of the table.
        /// </summary>
        /// <value>
        /// The name of the table.
        /// </value>
        public string TableName
        { 
            get
            { 
                return _Table.TableName;
            } 
            set 
            {
               _Table.TableName = value;
               RaisePropertyChanged("TableName");
            } 
        }

        /// <summary>
        /// Gets the table id.
        /// </summary>
        /// <value>
        /// The table id.
        /// </value>
        public int TableId
        {
            get
            {
                return _Table.TableId;
            }
        }

        /// <summary>
        /// Gets a value indicating whether the table is having a primary key.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is table having primary key; otherwise, <c>false</c>.
        /// </value>
        public bool IsTableHavingPrimaryKey
        {
            get
            {
                return !string.IsNullOrEmpty(_Table.PrimaryKeyNames);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is select by PK.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is select by PK; otherwise, <c>false</c>.
        /// </value>
        public bool IsSelectByPK
        {
            get
            {
                return _Table.IsSelectByPK;
            }
            set
            {
                _Table.IsSelectByPK = value;
                RaisePropertyChanged("IsSelectByPK");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is update by PK.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is update by PK; otherwise, <c>false</c>.
        /// </value>
        public bool IsUpdateByPK
        {
            get
            {
                return _Table.IsUpdateByPK;
            }
            set
            {
                _Table.IsUpdateByPK = value;
                RaisePropertyChanged("IsUpdateByPK");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is delete by PK.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is delete by PK; otherwise, <c>false</c>.
        /// </value>
        public bool IsDeleteByPK
        {
            get
            {
                return _Table.IsDeleteByPK;
            }
            set
            {
                _Table.IsDeleteByPK = value;
                RaisePropertyChanged("IsDeleteByPK");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is insert.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is insert; otherwise, <c>false</c>.
        /// </value>
        public bool IsInsert
        {
            get
            {
                return _Table.IsInsert;
            }
            set
            {
                _Table.IsInsert = value;
                RaisePropertyChanged("IsInsert");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is select.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is select; otherwise, <c>false</c>.
        /// </value>
        public bool IsSelect
        {
            get
            {
                return _Table.IsSelect;
            }
            set
            {
                _Table.IsSelect = value;
                RaisePropertyChanged("IsSelect");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is insert bulk.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is insert bulk; otherwise, <c>false</c>.
        /// </value>
        public bool IsInsertBulk
        {
            get
            {
                return _Table.IsInsertBulk;
            }
            set
            {
                _Table.IsInsertBulk = value;
                RaisePropertyChanged("IsInsertBulk");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is update bulk.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is update bulk; otherwise, <c>false</c>.
        /// </value>
        public bool IsUpdateBulk
        {
            get
            {
                return _Table.IsUpdateBulk;
            }
            set
            {
                _Table.IsUpdateBulk = value;
                RaisePropertyChanged("IsUpdateBulk");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is delete bulk.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is delete bulk; otherwise, <c>false</c>.
        /// </value>
        public bool IsDeleteBulk
        {
            get
            {
                return _Table.IsDeleteBulk;
            }
            set
            {
                _Table.IsDeleteBulk = value;
                RaisePropertyChanged("IsDeleteBulk");
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is generate code.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is generate code; otherwise, <c>false</c>.
        /// </value>
        public bool IsGenerateCode
        {
            get
            {
                return _Table.IsGenerateCode;
            }
            set
            {
                _Table.IsGenerateCode = value;
                RaisePropertyChanged("IsGenerateCode");
            }
        }

        public string TableNamePascal
        {
            get
            {
                return _Table.TableNamePascal;
            }
            set
            {
                _Table.TableNamePascal = value;
                RaisePropertyChanged("TableNamePascal");
            }
        }

        public string TableNameCamel
        {
            get
            {
                return _Table.TableNameCamel;
            }
            set
            {
                _Table.TableNameCamel = value;
                RaisePropertyChanged("TableNameCamel");
            }
        }

        public ObservableCollection<ColumnViewModel> Columns { get; set; }

        public TableMetaData TableModel
        {
            get
            {
                return _Table;
            }
        }
        #endregion

        #region [ Contructor ]
        public TableViewModel()
        {
        }

        public TableViewModel(TableMetaData table)
        {
            _Table = table;
            Columns = new ObservableCollection<ColumnViewModel>();
            table.Columns.ForEach(column => Columns.Add(new ColumnViewModel(column)));
        }
        #endregion

        #region [ Public Methods ]

        #endregion

        #region [ Private Methods ]

        #endregion

    }
}
