using System;
using System.Collections;

namespace SaiVision.Platform.CommonLibrary
{
    // this class allows for separation of domain and technical errors, it is needed for reference in the web.config and
    // for use with the health monitor of ASP.NET
    public class LoggingDomainErrorEvent : LoggingErrorEvent
    {
        public LoggingDomainErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, WebEventCustomCode, ex, DistributionBoundry)
        {
        }
        // With ErrorID
        public LoggingDomainErrorEvent(string errorID, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(errorID, message, eventSource, WebEventCustomCode, ex, DistributionBoundry)
        {
        }

        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingDomainErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry)
        {
        }
        // with ErrorID, Invoked in case of events identified by their event code and related event detailed code.
        public LoggingDomainErrorEvent(string errorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(errorId, message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry)
        {
        }

        public LoggingDomainErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, WebEventCustomCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }
        //with ErrorId
        public LoggingDomainErrorEvent(string errorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(errorId, message, eventSource, WebEventCustomCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }

        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingDomainErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }
        // with ErrorId, Invoked in case of events identified by their event code and related event detailed code.
        public LoggingDomainErrorEvent(string errorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(errorId, message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }
    }
}
