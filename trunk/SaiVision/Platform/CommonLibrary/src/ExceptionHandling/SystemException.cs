using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Configuration;

namespace SaiVision.Platform.CommonLibrary
{
    public abstract class SystemException : Exception
    {
        public virtual bool EnableExceptionLogging
        {
            get
            {
                bool enableExceptionLogging = false;
                bool.TryParse(ConfigurationManager.AppSettings["EnableExceptionLogging"], out enableExceptionLogging);
                return enableExceptionLogging;
            }
        }

        private string guid;

        public SystemException(string message)
            : base(message)
        {
            CreateAndSetGuid();
        }
        public SystemException(string message, string guid)
            : base(message)
        {
            // use the passed in guid instead of generating one
            this.Guid = guid;
        }

        public SystemException(string message, Exception innerException)
            : base(message, innerException)
        {
            CreateAndSetGuid();
        }

        public SystemException(string message, Exception innerException, string guid)
            : base(message, innerException)
        {
            // use the passed in guid instead of generating one
            this.Guid = guid;
        }

        // Constructor accepting a single string message
        public abstract void SystemExceptionLogging(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode);


        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        public abstract void SystemExceptionLogging(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode);


        // Constructor accepting a single string message and a hashtable of additional data to be logged
        public abstract void SystemExceptionLogging(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog);


        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        // and a hashtable of additional data to be logged
        public abstract void SystemExceptionLogging(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog);


        public string Guid
        {
            get { return guid; }
            set { guid = value; }
        }

        // creates a new GUID and assigns the class property 'Guid' to the created GUID
        public string CreateAndSetGuid()
        {
            string uniqueErrorIdentifier = System.Guid.NewGuid().ToString();
            this.Guid = uniqueErrorIdentifier;

            return uniqueErrorIdentifier;
        }
    }
}
