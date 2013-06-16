using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using SaiVision.Tools.CodeGenerator.Manager;
using System.Windows.Input;
using MicroMvvm;
using SaiVision.Platform.CommonUtil.Extensions;

namespace SaiVision.Tools.CodeGenerator.ViewModels
{
    public class DatabaseViewModel : ObservableObject
    {
        #region [ Fields ]
        int _SelectionTableId;
        TableViewModel _SelectionTable;
        #endregion

        #region [ Properties ]
        public ObservableCollection<TableViewModel> Tables { get; set; }
        public ObservableCollection<TableViewModel> SelectedTables { get; set; }
        //public List<TableMetaData> Tables { get; set; }

        public int SelectionTableId
        {
            get
            {
                return _SelectionTableId;
            }
            set
            {
                _SelectionTableId = value;
                SelectionTable = Tables.First(t => t.TableId.Equals(_SelectionTableId));
                //SelectionTable = (Tables.Any(t => t.TableId.Equals(_SelectionTableId))) ? Tables.First(t => t.TableId.Equals(_SelectionTableId)): SelectedTables.First(t => t.TableId.Equals(_SelectionTableId));
                RaisePropertyChanged("SelectionTableId");
            }
        }

        public TableViewModel SelectionTable
        {
            get
            {
                return _SelectionTable;
            }
            set
            {
                _SelectionTable = value;
                RaisePropertyChanged("SelectionTable");
            }
        }

        #endregion

        #region [ Contructor ]
        public DatabaseViewModel()
        {

            Tables = new ObservableCollection<TableViewModel>();
            DBMetaData metaData = DBManager.GetInstance().GetDBMetaData();
            metaData.Tables.ForEach(table => Tables.Add(new TableViewModel(table)));

            SelectionTableId = Tables[0].TableId;
            /*
            DBMetaData metaData = DBManager.GetInstance().GetDBMetaData();
            this.Tables = metaData.Tables;
            */
            SelectedTables = new ObservableCollection<TableViewModel>(Tables.Where(table => table.TableModel.IsGenerateCode == true));
            //SelectedTables.ForEach(table => Tables.Remove(table));
        }
        #endregion

        #region [ Public Methods ]

        #endregion

        #region [ Private Methods ]

        #endregion

        #region [ Commands ]
        void AddTableExecute()
        {
            TableViewModel table = Tables.First(t => t.TableId.Equals(SelectionTableId));
            // Is already selected?
            if (SelectedTables.Any(t => t.TableId.Equals(SelectionTableId)))
            {
                TableViewModel selectedTable = SelectedTables.First(t => t.TableId.Equals(SelectionTableId));
                SelectedTables.Remove(selectedTable);
            }
            SelectedTables.Add(table);
        }

        bool CanAddTableExecute()
        {
            return true;
        }

        public ICommand AddTable { get { return new RelayCommand(AddTableExecute, CanAddTableExecute); } }

        void SaveConfigurationExecute()
        {
            DBMetaData metaData = new DBMetaData() { DataBaseId = 1, DatabaseName = "CommandCenter" };
            SelectedTables.ForEach(st => metaData.Tables.Add(st.TableModel));

            metaData.SaveConfiguration();
        }

        bool CanSaveConfigurationExecute()
        {
            return SelectedTables.Count > 0;
        }

        public ICommand SaveConfiguration { get { return new RelayCommand(SaveConfigurationExecute, CanSaveConfigurationExecute); } }


        #endregion

    }
}
