using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MicroMvvm;
using SaiVision.Platform.MvvmInfrastructure.ViewModel;
using SaiVision.Tools.CodeGenerator.Manager;

namespace SaiVision.Tools.CodeGenerator.ViewModels
{
    public class ColumnViewModel : DynamicViewModel
    {
        #region [ Fields ]
        ColumnMetaData _Column;        
        #endregion

        #region [ Properties ]
        /*public string ColumnName
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
        }*/

        #endregion

        #region [ Constructor ]
        public ColumnViewModel()
        {
        }

        public ColumnViewModel(ColumnMetaData column)
            : base(column)            
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
