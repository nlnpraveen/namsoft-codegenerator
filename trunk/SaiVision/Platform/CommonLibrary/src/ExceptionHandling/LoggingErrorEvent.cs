using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Management;
using System.Web.UI;
using System.Web;
using System.Collections;
using System.Reflection;
using System.Resources;
using System.Configuration;

namespace SaiVision.Platform.CommonLibrary
{
    public class LoggingErrorEvent : WebBaseErrorEvent
    {
        private Exception exception;
        private Page page;
        private string userName;
        private string distributionBoundry;
        private Hashtable additionalDataToLog;

        public virtual bool EnableExceptionLogging
        {
            get
            {
                bool enableExceptionLogging = false;
                bool.TryParse(ConfigurationManager.AppSettings["EnableExceptionLogging"], out enableExceptionLogging);
                return enableExceptionLogging;
            }
        }

        public virtual bool EnableLog4NetLogging
        {
            get
            {
                bool enableLog4NetLogging = false;
                bool.TryParse(ConfigurationManager.AppSettings["EnableLog4NetLogging"], out enableLog4NetLogging);
                return enableLog4NetLogging;
            }
        }

        // used to override the generation of the unique id within this program
        // the GUID will be provided by the calling program instead
        string UniqueErrorId;

        public LoggingErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), ex)
        {
            UniqueErrorId = "N/A";
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, new Hashtable());
        }

        public LoggingErrorEvent(string uniqueErrorIdentifier, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), ex)
        {
            UniqueErrorId = uniqueErrorIdentifier;
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, new Hashtable());
        }
        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), eventDetailCode, ex)
        {
            UniqueErrorId = "N/A";
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, new Hashtable());
        }
        // ErrorID passed in , Invoked in case of events identified by their event code and related event detailed code.
        public LoggingErrorEvent(string uniqueErrorIdentifier, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), eventDetailCode, ex)
        {
            UniqueErrorId = uniqueErrorIdentifier;
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, new Hashtable());
        }

        //
        // constructors with a hash table of additional information to be logged
        //
        public LoggingErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), ex)
        {
            UniqueErrorId = "N/A";
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, AdditionalDataToLog);
        }
        //
        // constructors errorID passed in, with a hash table of additional information to be logged
        //
        public LoggingErrorEvent(string uniqueErrorIdentifier, string message, object eventSource, WebEventCustomCode WebEventCustomCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), ex)
        {
            UniqueErrorId = uniqueErrorIdentifier;
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, AdditionalDataToLog);
        }

        // Invoked in case of events identified by their event code and related event detailed code.
        public LoggingErrorEvent(string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), eventDetailCode, ex)
        {
            UniqueErrorId = "N/A";
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, AdditionalDataToLog);
        }
        // with ID passed in, Invoked in case of events identified by their event code and related event detailed code.
        public LoggingErrorEvent(string uniqueErrorIdentifier, string message, object eventSource, WebEventCustomCode WebEventCustomCode, int eventDetailCode, Exception ex, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
            : base(message, eventSource, (int)Enum.Parse(WebEventCustomCode.GetType(), WebEventCustomCode.ToString()), eventDetailCode, ex)
        {
            UniqueErrorId = uniqueErrorIdentifier;
            string userName = "N/A or Windows service is running";
            if (HttpContext.Current != null)
            {
                userName = HttpContext.Current.User.Identity.Name;
            }
            GatherInfo(eventSource as Page, ex, userName, DistributionBoundry, AdditionalDataToLog);
        }

        private void GatherInfo(Page Page, Exception ex, string UserName, DistributionBoundry DistributionBoundry, Hashtable AdditionalDataToLog)
        {
            this.page = Page;
            this.exception = ex;
            this.userName = UserName;
            this.distributionBoundry = DistributionBoundry.ToString();
            this.additionalDataToLog = AdditionalDataToLog;
        }

        // provides a way to manually or programatically raise the event when needed
        public static void CustomRaise(WebBaseEvent evnt)
        {
            Raise(evnt);
        }

        public override void Raise()
        {
            if (EnableLog4NetLogging)
                DoLog4NetLogging();
            if (EnableExceptionLogging)
                base.Raise();
        }

        // add our own custom output to the logging
        public override void FormatCustomEventDetails(WebEventFormatter formatter)
        {
            if (EnableExceptionLogging)
            {
                if (formatter == null)
                    throw new CECityArgumentOutOfRangeException("formatter", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "FormatCustomEventDetails()", "formatter"));

                base.FormatCustomEventDetails(formatter);

                string delimiter = "|||"; // the triple pipe, deadliest of all delimiters

                if (exception != null)
                {
                    if (page != null)
                    {
                        formatter.AppendLine(page.ToString());
                    }

                    formatter.AppendLine("\r\n");
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................User Name:" + this.userName + delimiter);
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................Exception Message:" + this.exception.Message + delimiter);
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................Exception Source:" + this.exception.Source + delimiter);
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................Unique Error Identifier:" + this.UniqueErrorId + delimiter);
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................Distribution Boundry:" + this.distributionBoundry + delimiter);
                    formatter.AppendLine("\r\n");
                    formatter.AppendLine(".................................Exception stack trace follows...");
                    formatter.AppendLine("\r\n");

                    // loop through the hashtable and add any additional data that was passed in
                    foreach (DictionaryEntry entry in this.additionalDataToLog)
                    {
                        formatter.AppendLine(".................................Additional Data:" + "Key:" + entry.Key + ", Value:" + entry.Value + delimiter);
                        formatter.AppendLine("\r\n");
                    }

                    formatter.AppendLine(exception.StackTrace);
                }
            }
            else
            {
                base.FormatCustomEventDetails(formatter);
            }
        }

        public void DoLog4NetLogging()
        {
            StringBuilder formatter = new StringBuilder();
            string delimiter = "|||"; // the triple pipe, deadliest of all delimiters

            if (exception != null)
            {

                formatter.AppendLine("\r\n");
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................User Name:" + this.userName + delimiter);
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................Exception Message:" + this.exception.Message + delimiter);
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................Exception Source:" + this.exception.Source + delimiter);
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................Unique Error Identifier:" + this.UniqueErrorId + delimiter);
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................Distribution Boundry:" + this.distributionBoundry + delimiter);
                formatter.AppendLine("\r\n");
                formatter.AppendLine(".................................Exception stack trace follows...");
                formatter.AppendLine("\r\n");

                // loop through the hashtable and add any additional data that was passed in
                foreach (DictionaryEntry entry in this.additionalDataToLog)
                {
                    formatter.AppendLine(".................................Additional Data:" + "Key:" + entry.Key + ", Value:" + entry.Value + delimiter);
                    formatter.AppendLine("\r\n");
                }

                formatter.AppendLine(exception.StackTrace);
                /*
                string loggerName = PropertyManager.EnvironmentProperty["Log4NetLoggerName"];
                if (!string.IsNullOrEmpty(loggerName))
                {
                    CECity.Platform.LogUtil.LogManager lm = new CECity.Platform.LogUtil.LogManager(loggerName);
                    string message = string.Format("{0}", formatter);
                    lm.LogERROR(message, exception.InnerException);

                }
                */
            }
        }
    }
}