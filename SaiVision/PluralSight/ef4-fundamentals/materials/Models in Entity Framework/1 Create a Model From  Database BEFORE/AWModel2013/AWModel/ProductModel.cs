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
    
    public partial class ProductModel
    {
        public ProductModel()
        {
            this.ProductModelProductDescriptions = new HashSet<ProductModelProductDescription>();
            this.Products = new HashSet<Product>();
        }
    
        public int ProductModelID { get; set; }
        public string Name { get; set; }
        public string CatalogDescription { get; set; }
        public System.Guid rowguid { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    
        public virtual ICollection<ProductModelProductDescription> ProductModelProductDescriptions { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}
