//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DatabaseFromModel_Before
{
    using System;
    using System.Collections.Generic;
    
    public partial class Session
    {
        public Session()
        {
            this.Minutes = 60;
        }
    
        public int Id { get; set; }
        public int Minutes { get; set; }
        public string Name { get; set; }
        public int PersonId { get; set; }
    
        public virtual Person Person { get; set; }
    }
}
