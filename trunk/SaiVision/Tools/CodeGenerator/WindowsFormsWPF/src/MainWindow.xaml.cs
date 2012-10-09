using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using SaiVision.Tools.CodeGenerator.ViewModels;

namespace WindowsFormsWPF
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DatabaseViewModel _databaseVM = new DatabaseViewModel();
        public MainWindow()
        {
            InitializeComponent();
            base.DataContext = _databaseVM;            
        }
    }
}
