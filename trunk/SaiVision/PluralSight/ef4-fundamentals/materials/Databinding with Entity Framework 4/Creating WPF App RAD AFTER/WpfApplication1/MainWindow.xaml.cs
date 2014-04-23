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


namespace WpfApplication1
{
  /// <summary>
  /// Interaction logic for MainWindow.xaml
  /// </summary>
  public partial class MainWindow : Window
  {
    private AdventureWorksSuperLTEntities context;
    public MainWindow()
    {
      InitializeComponent();
      
    }

    private IQueryable<Customer> GetCustomersQuery(AdventureWorksSuperLTEntities adventureWorksSuperLTEntities)
    {
      // Auto generated code

      System.Data.Objects.ObjectQuery<Customer> customersQuery = adventureWorksSuperLTEntities.Customers;
      // Update the query to include SalesOrderHeaders data in Customers. You can modify this code as needed.
      return customersQuery.Include("SalesOrderHeaders")
        .Where(c=>c.SalesOrderHeaders.Any());
    }

    private void Window_Loaded(object sender, RoutedEventArgs e)
    {

      context = new AdventureWorksSuperLTEntities();
      // Load data into Customers. You can modify this code as needed.
      var customersViewSource = ((CollectionViewSource)(FindResource("customersViewSource")));
      IQueryable<Customer> customersQuery = GetCustomersQuery(context);
      customersViewSource.Source = customersQuery.ToList();
    }

    private void Save_Click(object sender, RoutedEventArgs e)
    {
      context.SaveChanges();
    }

  
    
  }
}
