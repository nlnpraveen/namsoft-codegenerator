//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AWModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class vSalesOrderDetail
    {
        public int SalesOrderID { get; set; }
        public int SalesOrderDetailID { get; set; }
        public Nullable<short> OrderQty { get; set; }
        public Nullable<int> ProductID { get; set; }
        public Nullable<decimal> UnitPrice { get; set; }
        public Nullable<decimal> UnitPriceDiscount { get; set; }
        public decimal LineTotal { get; set; }
        public Nullable<System.Guid> rowguid { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
    }
}
