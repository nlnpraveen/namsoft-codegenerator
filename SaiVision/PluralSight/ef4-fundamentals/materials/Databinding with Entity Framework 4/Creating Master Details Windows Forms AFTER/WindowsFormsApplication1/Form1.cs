using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using AWModel;

namespace WindowsFormsApplication1
{
  public partial class Form1 : Form
  {
    AWEntities context;
    public Form1()
    {
      InitializeComponent();
    }

    private void Form1_Load(object sender, EventArgs e)
    {
      context = new AWEntities();
      var query = context.Customers.Where(c => c.SalesOrderHeaders.Any());
      var customers = query.ToList();
      customerBindingSource.DataSource = customers;
    }

    private void customerBindingNavigatorSaveItem_Click(object sender, EventArgs e)
    {
      context.SaveChanges();
    }
  }
}
