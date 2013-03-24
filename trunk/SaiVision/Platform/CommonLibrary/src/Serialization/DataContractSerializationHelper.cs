using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml;

namespace SaiVision.Platform.CommonLibrary
{
    /// <summary>
    /// Helper class for serializing objects to Xml string
    /// </summary>
    public class DataContractSerializationHelper
    {
        /// <summary>
        /// Serializes an object to an XML string.
        /// </summary>
        /// <param name="obj">The obj to be serialized.</param>
        /// <param name="omitXmlDeclaration">if set to <c>true</c> [omit XML declaration].</param>
        /// <returns></returns>
        public static string ToXmlString(object obj, bool omitXmlDeclaration)
        {
            DataContractSerializer dcSer = new DataContractSerializer(obj.GetType());
            StringBuilder xmlString = new StringBuilder();
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.OmitXmlDeclaration = omitXmlDeclaration;

            XmlWriter writer = XmlWriter.Create(xmlString, settings);
            dcSer.WriteObject(writer, obj);
            writer.Close();

            return xmlString.ToString();
        }
    }
}
