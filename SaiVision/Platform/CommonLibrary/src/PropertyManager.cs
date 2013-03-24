using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace SaiVision.Platform.CommonLibrary
{
    public sealed class PropertyManager
    {
        private static PropertyManager propertyManager;

        private PropertyManager()
        {

        }

        /// <summary>
        /// Retrieves the value based on the key. It can be used to read app settings, message repository, cache. 
        /// Currently it reads only from the app settings
        /// Ex: PropertyManger.EnvironmentProperty["proxyURL"]
        /// </summary>
        public static PropertyManager EnvironmentProperty
        {
            get
            {
                if (propertyManager == null)
                    propertyManager = new PropertyManager();

                return propertyManager;
            }
        }

        /// <summary>
        /// Retrieves the value based on the key. It can be used to read app settings, message repository, cache. 
        /// Currently it reads only from the app settings
        /// Ex: PropertyManger.EnvironmentProperty["proxyURL"]
        /// </summary>
        /// <param name="key">The key for which the value has to be retrieved. If key not found, returns an empty value.</param>
        public string this[string key]
        {
            get
            {
                return propertyManager.GetValue(key);
            }
        }

        /// <summary>
        /// Retrieves the value based on the key. It can be used to read app settings, message repository, cache. 
        /// Currently it reads only from the app settings
        /// Ex: PropertyManger.EnvironmentProperty["proxyURL"]
        /// </summary>
        /// <param name="key">The key for which the value has to be retrieved. If key not found, returns an empty value.</param>
        private string GetValue(string key)
        {
            // 1. check in the config file. Extend this function to check in other places.
            string propertyValue = ConfigurationManager.AppSettings.Get(key);
            return (!string.IsNullOrEmpty(propertyValue) ? propertyValue : string.Empty);
        }
    }
}

