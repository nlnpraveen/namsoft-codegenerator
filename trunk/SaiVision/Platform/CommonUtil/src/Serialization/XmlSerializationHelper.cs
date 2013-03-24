using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Xml;

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

            XmlWriter writer = XmlWriter.Create(xmlString, settings);

            xser.Serialize(writer, obj);
            writer.Close();            

            return xmlString.ToString();
        }
    }
}
