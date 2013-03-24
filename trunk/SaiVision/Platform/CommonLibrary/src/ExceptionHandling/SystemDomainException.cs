﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace SaiVision.Platform.CommonLibrary
{
    public class SystemDomainException : SystemException
    {
        // Constructor accepting a single string message
        public SystemDomainException(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode)
            : base(message)
        {
            SystemExceptionLogging(message, DistributionBoundry, WebEventCustomCode);
        }

        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        public SystemDomainException(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode)
            : base(message, inner)
        {
            SystemExceptionLogging(message, inner, DistributionBoundry, WebEventCustomCode);
        }

        // Constructor accepting a single string message and a hashtable of additional data to be logged
        public SystemDomainException(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog)
            : base(message)
        {
            SystemExceptionLogging(message, DistributionBoundry, WebEventCustomCode, AdditionalDataToLog);
        }

        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        // and a hashtable of additional data to be logged
        public SystemDomainException(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog)
            : base(message, inner)
        {
            SystemExceptionLogging(message, inner, DistributionBoundry, WebEventCustomCode, AdditionalDataToLog);
        }


        //
        // implement abstract base class methods
        //

        // Constructor accepting a single string message
        public override void SystemExceptionLogging(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode)
        {
            LoggingDomainErrorEvent loggingErrorEvent = new LoggingDomainErrorEvent(base.Guid, message, null, WebEventCustomCode, this, DistributionBoundry);
            //HttpContext.Current.Server.ClearError();
            loggingErrorEvent.Raise();
        }


        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        public override void SystemExceptionLogging(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode)
        {
            LoggingDomainErrorEvent loggingErrorEvent = new LoggingDomainErrorEvent(base.Guid, message, null, WebEventCustomCode, inner, DistributionBoundry);
            //HttpContext.Current.Server.ClearError();

            loggingErrorEvent.Raise();
        }

        // Constructor accepting a single string message and a hashtable of additional data to be logged
        public override void SystemExceptionLogging(string message, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog)
        {
            LoggingDomainErrorEvent loggingErrorEvent = new LoggingDomainErrorEvent(base.Guid, message, null, WebEventCustomCode, this, DistributionBoundry, AdditionalDataToLog);
            //HttpContext.Current.Server.ClearError();

            loggingErrorEvent.Raise();
        }

        // Constructor accepting a string message and an 
        // inner exception which will be wrapped by this 
        // and a hashtable of additional data to be logged
        public override void SystemExceptionLogging(string message, Exception inner, DistributionBoundry DistributionBoundry, WebEventCustomCode WebEventCustomCode, Hashtable AdditionalDataToLog)
        {
            LoggingDomainErrorEvent loggingErrorEvent = new LoggingDomainErrorEvent(base.Guid, message, null, WebEventCustomCode, inner, DistributionBoundry, AdditionalDataToLog);
            //HttpContext.Current.Server.ClearError();
            loggingErrorEvent.Raise();
        }


    }
}
