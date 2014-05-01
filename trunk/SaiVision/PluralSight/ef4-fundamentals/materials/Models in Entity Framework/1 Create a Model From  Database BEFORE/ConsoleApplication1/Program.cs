using AWModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            GetAllCustomers();
        }

        static void GetAllCustomers()
        {
            var context = new AdventureWorksSuperEntities();
            var query = from c in context.Customers select c;
            var customers = query.ToList();
        }
    }
}
