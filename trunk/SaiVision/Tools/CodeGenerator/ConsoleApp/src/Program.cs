using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SaiVision.Tools.CodeGenerator.Manager;
using SaiVision.Platform.CommonUtil.Extensions;

namespace SaiVision.Tools.CodeGenerator.ConsoleApp
{
    public class Program
    {
        static void Main(string[] args)
        {
            DBMetaData metaData = DBManager.GetInstance().GetDBMetaData();
            // Hack until we get only generated data.
            TableMetaData[] tables = metaData.Tables.Where(table => table.IsGenerateCode == true).ToArray();
            TableMetaDataCollection tmdc = new TableMetaDataCollection();
            tables.ForEach(t => tmdc.Add(t));
            metaData.Tables = tmdc;
            // Hack Ends until we get only generated data.

            GeneratorSettings settings = new GeneratorSettings();

            settings.PassDataModelAsObjectParameter = false;
            settings.IsCECityGenerator = true;
            settings.Namespace = "CECity.Enterprise.DataModel";
            settings.DirectoryPath = @"C:\dev\SaiVision\Platform\CodeGenerator\DataModels\src";
            ModelGenerator cgenerator = new ModelGenerator(settings, metaData);
            cgenerator.GenerateModelClasses();

            settings.Namespace = "CECity.Enterprise.DataAccess";
            settings.DirectoryPath = @"C:\dev\SaiVision\Platform\CodeGenerator\DataAccess\src";
            DataAccessGenerator dagenerator = new DataAccessGenerator(settings, metaData);
            dagenerator.GenerateDataAccessClasses();

            settings.Namespace = "CECity.Enterprise.DataManager";
            settings.DirectoryPath = @"C:\dev\SaiVision\Platform\CodeGenerator\DataManagers\src";
            ManagerGenerator managerGenerator = new ManagerGenerator(settings, metaData);
            managerGenerator.GenerateManagerClasses();            
        }        
    }
}
