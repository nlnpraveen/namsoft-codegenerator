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
            //AddNewProduct();
            ModifyDetailsForSalesOrder();
            //GetAllCustomers();
            //AddNewCustomer();
        }

        private static void ModifyDetailsForSalesOrder()
        {
            using (var context = new AdventureWorksSuperEntities())
            {
                var detailList = context.SalesOrderDetails.Where(d => d.SalesOrderID == 1003).ToList();

                // modify an OrderDetail
                //detailList[0].OrderQty = 10;
                //delete an OrderDetail
                //context.DeleteObject(detailList[1]);
                //insert a new OrderDetail
                var product = context.Products.SingleOrDefault(p => p.ProductID == 1);
                var newDetail = new SalesOrderDetail
                {
                    SalesOrderID = 1003,
                    ProductID = product.ProductID,
                    OrderQty = 2,
                    UnitPrice = product.ListPrice,
                    UnitPriceDiscount = 0,
                    ModifiedDate = DateTime.Today
                };
                context.SalesOrderDetails.AddObject(newDetail);
                context.SaveChanges();
            }

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
                string companyName = string.Format("{0}{1}{2}{3}{4}{5} Inc.", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                var customer = new Customer() {CompanyName=companyName, FirstName = firstName, LastName = lastName, TimeStamp=new byte[] {}, ModifiedDate = DateTime.Now };
                customer.SalesOrderHeaders.Add(new SalesOrderHeader
                {
                    SalesOrderNumber = string.Format("{0}{1}{2}{3}{4}{5}", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]),
                    OrderDate = DateTime.Now,
                    DueDate = DateTime.Now.AddMonths(1),
                    ModifiedDate = DateTime.Now,
                    Comment = "Don't forget to ship this too!"
                });
                context.Customers.AddObject(customer);                
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

        private static void AddNewProduct()
        {
            try
            {
                var context = new AdventureWorksSuperEntities();
                Random rand = new Random();

                char[] alphabets = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p' };
                string productName = string.Format("{0}{1}{2}{3}{4}{5}", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                string productNumber = string.Format("{0}{1}{2}{3}{4}{5}", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                string companyName = string.Format("{0}{1}{2}{3}{4}{5} Inc.", alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)], alphabets[rand.Next(15)]);
                var product = new Product() { Name = productName, ProductNumber = productNumber, StandardCost = rand.Next(15), ListPrice = rand.Next(13), SellStartDate = DateTime.Now.AddHours(5), ModifiedDate = DateTime.Now, rowguid = new Guid() };
                context.Products.AddObject(product);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }
    }
}
