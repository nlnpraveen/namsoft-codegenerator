using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Xml;
using System.IO;

namespace SaiVision.Platform.CommonUtil.Serialization
{
    public class XmlSerializationHelper
    {
        public static string ToXmlString(object obj, bool omitXmlDeclaration)
        {
            XmlSerializer xser = new XmlSerializer(obj.GetType());
            StringBuilder xmlString = new StringBuilder();
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.OmitXmlDeclaration = omitXmlDeclaration;

            using (XmlWriter writer = XmlWriter.Create(xmlString, settings))
            {
                xser.Serialize(writer, obj);
            }                    

            return xmlString.ToString();
        }

        /// <summary>
        /// Deserializes the specified XML.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="xml">The XML.</param>
        /// <param name="omitXmlDeclaration">if set to <c>true</c> [omit XML declaration].</param>
        /// <returns></returns>
        public static T Deserialize<T>(string xml, bool omitXmlDeclaration)
        {
            /*
             * string xml = XmlSerializationHelper.ToXmlString(activityLearningFormatXml, true);            
             * List<ActivityLearningFormat> mydeserializedObj = XmlSerializationHelper.Deserialize < List<ActivityLearningFormat>>(xml, true);
             */
            XmlSerializer xser = new XmlSerializer(typeof(T));
            XmlReaderSettings settings = new XmlReaderSettings();

            T obj;

            using (MemoryStream memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(xml)))
			{
                using (XmlReader xmlReader = XmlReader.Create(memoryStream, settings))
                {
                    obj = (T)xser.Deserialize(xmlReader);
                }
            }

            return obj;
        }

        /// <summary>
        /// Serialize an object
        /// </summary>
        /// <param name="source">The object to serialize</param>
        /// <param name="namespaces">Namespaces to include in serialization</param>
        /// <param name="settings">XML serialization settings. <see cref="System.Xml.XmlWriterSettings"/></param>
        /// <returns>A XML string that represents the object to be serialized</returns>
        public static string Serialize<T>(T source, bool omitXmlDeclaration) where T : class, new()
        {
            if (source == null)
                throw new ArgumentNullException("source", "Object to serialize cannot be null");

            string xml = null;
            XmlSerializer serializer = new XmlSerializer(source.GetType());

            using (MemoryStream memoryStream = new MemoryStream())
            {
                XmlWriterSettings settings = new XmlWriterSettings();
                settings.OmitXmlDeclaration = omitXmlDeclaration;

                using (XmlWriter xmlWriter = XmlWriter.Create(memoryStream, settings))
                {
                    System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(T));
                    x.Serialize(xmlWriter, source, null);

                    memoryStream.Position = 0; // rewind the stream before reading back.
                    using (StreamReader sr = new StreamReader(memoryStream))
                    {
                        xml = sr.ReadToEnd();
                    }
                }
            }

            return xml;
        }

    }
}
