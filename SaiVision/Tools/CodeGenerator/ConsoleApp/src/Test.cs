using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SaiVision.Tools.CodeGenerator.Manager;

namespace SaiVision.Tools.CodeGenerator.ConsoleApp
{    
    public class Test
    {
        public Test()
        {
            Console.WriteLine(string.Format("HasVal_ue_ --> {0}", Utility.ConvertToCamelCase("HasVal_ue_")));
            Console.WriteLine(string.Format("HasVal_ue_ --> {0}", Utility.ConvertToSentence("HasVal_ue_")));
            Console.WriteLine(string.Format("FormId --> {0}", Utility.ConvertToPascalCase("FormId")));
        }
    }
}
