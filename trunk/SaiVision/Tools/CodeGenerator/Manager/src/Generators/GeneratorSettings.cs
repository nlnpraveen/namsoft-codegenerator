using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class GeneratorSettings
    {
        #region [ Properties ]
        /// <summary>
        /// Gets or sets the directory path.
        /// </summary>
        /// <value>The directory path.</value>
        public string DirectoryPath { get; set; }

        /// <summary>
        /// Gets or sets the namespace.
        /// </summary>
        /// <value>The namespace.</value>
        public string Namespace { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [pass data model as object parameter].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [pass data model as object parameter]; otherwise, <c>false</c>.
        /// </value>
        public bool PassDataModelAsObjectParameter { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is CE city generator.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is CE city generator; otherwise, <c>false</c>.
        /// </value>
        public bool IsCECityGenerator { get; set; }
        #endregion
    }
}
