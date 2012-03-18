using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace CECity.Enterprise.CodeGeneration.CGenManager
{
    public class FormManager
    {
        #region Constructors

        public FormManager() { }
        
        #endregion

        #region Private Members

        private static FormManager _instance;
        private static object syncRoot = new Object();

        #endregion

        #region Public Members

        #endregion

        #region Public Properties
        /// <summary>
        /// Gets the single instance of FormManager
        /// </summary>
        public static FormManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (syncRoot)
                    {
                        if (_instance == null)
                        {
                            Interlocked.Exchange(ref _instance, new FormManager());
                        }
                    }
                }
                return _instance;
            }
        }
        #endregion

        #region Private Properties
        #endregion

        #region Methods
        #endregion
    }
}
