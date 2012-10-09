using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MicroMvvm;
using SaiVision.Tools.CodeGenerator.Manager;

namespace SaiVision.Tools.CodeGenerator.ViewModels
{
    public class ColumnViewModel : ObservableObject
    {
        #region [ Fields ]
        ColumnMetaData _Column;        
        #endregion

        #region [ Properties ]
        public string ColumnName
        {
            get
            {
                return _Column.ColumnName;
            }
            set
            {
                _Column.ColumnName = value;
                RaisePropertyChanged("ColumnName");
            }
        }

        public string ColumnNamePascal
        {
            get
            {
                return _Column.ColumnNamePascal;
            }
            set
            {
                _Column.ColumnNamePascal = value;
                RaisePropertyChanged("ColumnNamePascal");
            }
        }

        public string ColumnNameCamel
        {
            get
            {
                return _Column.ColumnNameCamel;
            }
            set
            {
                _Column.ColumnNameCamel = value;
                RaisePropertyChanged("ColumnNameCamel");
            }
        }

        #endregion

        #region [ Constructor ]
        public ColumnViewModel()
        {
        }

        public ColumnViewModel(ColumnMetaData column)
        {
            _Column = column;
        }

        #endregion

        #region [ Public Methods ]

        #endregion

        #region [ Private Methods ]

        #endregion
    }
}
