using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using System.Data;

namespace PSODPOCO
{ 

 
  class Program
  {
    static void Main()
    {
     using (var context=new ConferenceEntities())
     {

       var talks = from t in context.Talks select t;
       foreach (var t in talks)
       {
         Console.WriteLine(t.Name);
         foreach (Speaker s in t.Speakers)
         {
           Console.WriteLine("   " + s.Name);
         }
       }

     }
      Console.ReadKey();
    }
   
  }
}
