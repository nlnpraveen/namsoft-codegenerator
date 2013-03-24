using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Management;
using System.Web.UI;
using System.Web;
using System.Collections;

namespace SaiVision.Platform.CommonLibrary
{
    public class CECityArgumentOutOfRangeException : SystemDomainException
    {

        static string standardErrorMessage = "You have not provided a required parameter.";

        // programmer supplies the error message to display
        public CECityArgumentOutOfRangeException(string paramName, object actualValue, string message)
            : base(SetNameAndValue(message, paramName, actualValue), DistributionBoundry.DataTier, WebEventCustomCode.DomainUnexpectedException)
        {
        }

        // programmer supplies the error message to display
        public CECityArgumentOutOfRangeException(string paramName, string actualValue, string message)
            : base(SetNameAndValue(message, paramName, actualValue), DistributionBoundry.DataTier, WebEventCustomCode.DomainUnexpectedException)
        {
        }


        // standard default error message will display
        public CECityArgumentOutOfRangeException(string paramName, string actualValue)
            : base(SetNameAndValue(standardErrorMessage, paramName, actualValue), DistributionBoundry.DataTier, WebEventCustomCode.DomainUnexpectedException)
        {
        }

        // allow other tiers to call this type of exception
        // standard default error message will display
        public CECityArgumentOutOfRangeException(string paramName, string actualValue, WebEventCustomCode WebEventCustomCode, DistributionBoundry DistributionBoundry)
            : base(SetNameAndValue(standardErrorMessage, paramName, actualValue), DistributionBoundry.DataTier, WebEventCustomCode.DomainUnexpectedException)
        {
        }

        private static string SetNameAndValue(string message, string paramName, object actualValue)
        {
            string actualValueString;

            try
            {
                actualValueString = actualValue.ToString();
            }
            catch (Exception ex)
            {
                actualValueString = "Actual parameter value could not be converted to a string. " + ex.Message;
            }


            return SetNameAndValue(message, paramName, actualValueString);
        }

        private static string SetNameAndValue(string message, string paramName, string actualValue)
        {
            string returnValue = message + " " + "Parameter Name:" + paramName + ", " + "Paramater Value:" + actualValue;
            return returnValue;
        }

    }
}
