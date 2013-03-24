using System;
using System.Collections;

namespace SaiVision.Platform.CommonLibrary
{
    // this class allows for separation of domain and technical errors, it is needed for reference in the web.config and
    // for use with the health monitor of ASP.NET
    public class LoggingTechnicalErrorEvent : LoggingErrorEvent
    {
        public LoggingTechnicalErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, WebEventCustomCode, ex, DistributionBoundry)
        {

        }
        public LoggingTechnicalErrorEvent(string ErrorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(ErrorId, message, eventSource, WebEventCustomCode, ex, DistributionBoundry)
        {

        }

        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingTechnicalErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry)
        {
        }
        // errorID passed in, Invoked in case of events identified by their event code and related event detailed code.
        public LoggingTechnicalErrorEvent(string errorID, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(errorID, message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry)
        {
        }

        public LoggingTechnicalErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, WebEventCustomCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }

        public LoggingTechnicalErrorEvent(string errorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(errorId, message, eventSource, WebEventCustomCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }
        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingTechnicalErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }
        // errorid, Invoked in case of events identified by their event code and related event detailed code.
        public LoggingTechnicalErrorEvent(string errorId, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(errorId, message, eventSource, WebEventCustomCode, eventDetailCode, ex, DistributionBoundry, AdditionalDataToLog)
        {
        }


    }
}
