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
            //GetAllCustomers();
            AddNewCustomer();
        }

        private static void AddNewCustomer()
        {
            try
            {
                var context = new AdventureWorksSuperEntities();
                Random rand = new Random();

                char[] alphabets = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p' };
                string firstName = string.Format("{0}{1}{2}{3}{4}{5}", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                string lastName = string.Format("{0}{1}{2}{3}{4}{5}", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                var customer = new Customer() { FirstName = firstName, LastName = lastName, ModifiedDate = DateTime.Now };
                customer.SalesOrderHeaders.Add(new SalesOrderHeader
                {
                    OrderDate = DateTime.Now,
                    DueDate = DateTime.Now.AddMonths(1),
                    ModifiedDate = DateTime.Now,
                    Comment = "Don't forget to ship this too!"
                });
                context.Customers.Add(customer);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }

        static void GetAllCustomers()
        {
            var context = new AdventureWorksSuperEntities();
            var query = from c in context.Customers select c;
            var customers = query.ToList();
        }
    }
}
