using System;
using System.Globalization;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Resources;

namespace SaiVision.Platform.CommonLibrary
{
    public sealed class CECityResourceManager
    {
        private static readonly CECityResourceManager instance = new CECityResourceManager();
        private static ResourceManager stringManager;

        private CECityResourceManager()
        {
            stringManager = new ResourceManager("CECity.Platform.Common.Resources.MessageRepository", Assembly.GetExecutingAssembly());
        }

        public static CECityResourceManager GetCECityResourceManager()
        {
            return CECityResourceManager.instance;
        }

        public string GetString(string resourceFileKey, string methodName, string parameter)
        {
            if (methodName == null)
                throw new CECityArgumentOutOfRangeException("methodName", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, string)", "methodName"));
            if (parameter == null)
                throw new CECityArgumentOutOfRangeException("parameter", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, string)", "parameter"));

            string message = "Method: " + methodName.ToString() + " " + stringManager.GetString(resourceFileKey).ToString() + " (parameter: " + parameter.ToString() + ").";
            return message;
            // return string.Format(CultureInfo.InvariantCulture, "Method: {0} {1} (parameter: {3})", methodName, stringManager.GetString(resourceFileKey), parameter);
        }


        /// <summary>
        /// Gets the message from the resource file for when parameter is of the wrong type.
        /// </summary>
        /// <param name="resourceFileKey">The error key, should be 'InvalidParameterType'.</param>
        /// <param name="methodName"></param>
        /// <param name="parameter">The name of the parameter with the incorrect type.</param>
        /// <param name="parameterType">The name of the proper type for the parameter.</param>
        /// <returns></returns>
        public string GetString(string resourceFileKey, string methodName, string parameter, string parameterType)
        {
            if (methodName == null)
                throw new CECityArgumentOutOfRangeException("methodName", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, string, string)", "methodName"));
            if (parameter == null)
                throw new CECityArgumentOutOfRangeException("parameter", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, string, string)", "parameter"));
            if (parameterType == null)
                throw new CECityArgumentOutOfRangeException("parameterType", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, string, string)", "parameterType"));

            return string.Format(CultureInfo.InvariantCulture, stringManager.GetString(resourceFileKey).ToString(), methodName, parameter, parameterType);
            // "In method 'methodName', paramter 'parameter' should have type 'parameterType'."


            //string message = "Method: " + methodName.ToString() + " " + stringManager.GetString(resourceFileKey).ToString() + " (parameter: " + parameter.ToString() + ")." + " " + parameterType;
            //return message;

            //TODO: MAKE THIS WORK WITH RESX FILES
            //return string.Format(CultureInfo.InvariantCulture, "Method: {0} {1} (parameter: {3})", methodName, stringManager.GetString(resourceFileKey), parameter);
        }


        /// <summary>
        /// Gets the message from the resource file. Always pass the arguments as key-value paris.
        /// for ex: CECityResourceManager.GetCECityResourceManager().GetString("InvalidParameter", "Method", "AddUpdateAddress", "objectId", objectId.ToString())
        /// </summary>
        /// <param name="portalObjectCollection">The collection of portal objects.</param>
        public string GetString(string resourceFileKey, string methodName, params object[] arguments)
        {
            if (methodName == null)
                throw new CECityArgumentOutOfRangeException("methodName", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, params string[])", "methodName"));
            if (arguments == null)
                throw new CECityArgumentOutOfRangeException("arguments", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string, params string[])", "arguments"));

            StringBuilder message = new StringBuilder();
            string msg = stringManager.GetString(resourceFileKey).ToString();
            message.Append(msg.Replace("{0}", methodName));
            try
            {
                for (int i = 0; i < arguments.Length; i = i + 2)
                {
                    object arg1 = arguments[i] ?? "NULL";
                    object arg2 = arguments[i + 1] ?? "NULL";
                    string comma = (i + 2 != arguments.Length) ? ", " : "";

                    message.Append(string.Format(CultureInfo.InvariantCulture, "{0}: {1}{2}", arg1.ToString(), arg2.ToString(), comma));
                }
            }
            catch (IndexOutOfRangeException)
            {
            }
            catch (Exception e)
            {
                message.Append(" " + e.Message);
            }

            return message.ToString();
        }

        public string GetString(string resourceFileKey, string methodName)
        {
            if (methodName == null)
                throw new CECityArgumentOutOfRangeException("methodName", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "GetString(string, string)", "methodName"));

            string message = "Method: " + methodName.ToString() + " " + stringManager.GetString(resourceFileKey).ToString() + ".";
            return message;
            // return string.Format(CultureInfo.InvariantCulture, "Method: {0} {1}.", methodName, stringManager.GetString(resourceFileKey).ToString());
        }

        /// <summary>
        /// Gets the message from the resource file. Always pass the arguments as key-value paris.
        /// for ex: CECityResourceManager.GetCECityResourceManager().GetString("CannotPerformUserAction", "objectId", objectId.ToString())
        /// </summary>
        /// <param name="portalObjectCollection">The collection of portal objects.</param>
        public string GetMessage(string resourceFileKey, params object[] arguments)
        {
            string msg = stringManager.GetString(resourceFileKey).ToString();
            if (arguments != null)
            {
                try
                {
                    for (int i = 0; i < arguments.Length; i++)
                    {
                        object arg1 = arguments[i] ?? "NULL";

                        msg = msg.Replace("{" + i + "}", arg1.ToString());
                    }
                }
                catch (IndexOutOfRangeException)
                {
                }
                catch (Exception)
                {
                }
            }

            return msg;
        }

    }
}
