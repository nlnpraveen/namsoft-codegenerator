using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;

namespace SaiVision.Tools.CodeGenerator.Manager
{
    public class Utility
    {
        public static string ConvertToCamelCase(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            bool skipNext = false;
            StringBuilder retVal = new StringBuilder(32);            
            retVal.Append(char.ToLower(input[0]));
            for (int i = 1; i < input.Length; i++)
            {
                if (skipNext)
                {
                    skipNext = false;
                    continue;
                }

                if (input[i] == '_')
                {
                    if (i + 1 < input.Length)
                    {
                        retVal.Append(char.ToUpper(input[i + 1]));
                        i++;
                    }
                }
                else if (char.IsUpper(input[i])) // ID will be converted to Id
                {
                    retVal.Append(input[i]);
                    if (i + 1 < input.Length && char.IsUpper(input[i + 1]))
                    {
                        retVal.Append(char.ToLower(input[i + 1]));
                        skipNext = true;
                    }
                }
                else
                {
                    retVal.Append(input[i]);
                }
            }

            return retVal.ToString();
        }

        /// <summary>
        /// Converts to camel case. Prefixes applied will be truncated.
        /// Examples:
        /// JOB -> job
        /// JOB_JobId -> jobJobId
        /// activity_body_type -> activityBodyType
        /// ID -> id
        /// Id -> id
        /// _ -> empty string
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="prefixes">The prefixes.</param>
        /// <returns></returns>
        public static string ConvertToCamelCase(string input, List<string> prefixes)
        {
            // 1. Truncate prefixes
            foreach (string prefix in prefixes)
            {
                if (input.StartsWith(prefix, StringComparison.InvariantCultureIgnoreCase))
                {
                    input = input.Substring(prefix.Length, input.Length - prefix.Length);
                    break;
                }
            }
            input = input.Trim(new char[] { '_' });

            if (string.IsNullOrEmpty(input))
                return string.Empty;

            // 2. Handle string with allcaps
            bool allCaps = !input.ToCharArray().Any(c => char.IsLower(c));
            if (allCaps) input = input.ToLower();

            StringBuilder retVal = new StringBuilder(32);
            // 3. Do actual parsing
            if (!input.Contains('_'))
                retVal.Append(char.ToLower(input[0]));
            else if (input.Length > 1)
            {
                retVal.Append(input.Substring(0, (input.IndexOf('_'))).ToLower());
                input = input.Substring(input.IndexOf('_') + 1, input.Length - (input.IndexOf('_') + 1));
                retVal.Append(char.ToUpper(input[0]));
            }
            for (int i = 1; i < input.Length; i++)
            {
                if (input[i] == '_')
                {
                    if (i + 1 < input.Length)
                    {
                        retVal.Append(char.ToUpper(input[i + 1]));
                        i++;
                    }
                }                    
                else
                {
                    retVal.Append(input[i]);
                }
            }

            return retVal.ToString();
        }

        public static string ConvertToPascalCase(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            bool skipNext = false;
            StringBuilder retVal = new StringBuilder(32);
            retVal.Append(char.ToUpper(input[0]));
            for (int i = 1; i < input.Length; i++)
            {
                if (skipNext)
                {
                    skipNext = false;
                    continue;
                }

                if (input[i] == '_')
                {
                    if (i + 1 < input.Length)
                    {
                        retVal.Append(char.ToUpper(input[i + 1]));
                        i++;
                    }
                }
                else if (char.IsUpper(input[i])) // ID will be converted to Id
                {
                    retVal.Append(input[i]);
                    if (i + 1 < input.Length && char.IsUpper(input[i+1]))
                    {
                        retVal.Append(char.ToLower(input[i+1]));
                        skipNext = true;
                    }
                }
                else
                {
                    retVal.Append(input[i]);
                }
            }

            return retVal.ToString();
        }

        /// <summary>
        /// Converts to pascal case.Prefixes applied will be truncated.
        /// Examples:
        /// JOB -> Job
        /// JOB_JobId -> JobJobId
        /// activity_body_type -> ActivityBodyType
        /// ID -> Id
        /// Id -> Id
        /// LOCK_ENTITYLOCK -> Entitylock (LOCK_)
        /// _ -> empty string
        /// </summary>
        /// <param name="input">The input.</param>
        /// <param name="prefixes">The prefixes.</param>
        /// <returns></returns>
        public static string ConvertToPascalCase(string input, List<string> prefixes)
        {
            // 1. Truncate prefixes
            foreach (string prefix in prefixes)
            {
                if (input.StartsWith(prefix, StringComparison.InvariantCultureIgnoreCase))
                {
                    input = input.Substring(prefix.Length, input.Length - prefix.Length);
                    break;
                }
            }
            input = input.Trim(new char[] { '_' });
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            // 2. Handle string with allcaps
            bool allCaps = !input.ToCharArray().Any(c => char.IsLower(c));
            if (allCaps) input = input.ToLower();


            StringBuilder retVal = new StringBuilder(32);
            // 3. Do actual parsing            
            if (!input.Contains('_'))
                retVal.Append(char.ToUpper(input[0]));
            else if (input.Length > 1)
            {
                retVal.Append(char.ToUpper(input[0]));
                retVal.Append(input.Substring(1, (input.IndexOf('_')-1)).ToLower());
                input = input.Substring(input.IndexOf('_') + 1, input.Length - (input.IndexOf('_') + 1));
                retVal.Append(char.ToUpper(input[0]));
            }
            for (int i = 1; i < input.Length; i++)
            {
                if (input[i] == '_')
                {
                    if (i + 1 < input.Length)
                    {
                        retVal.Append(char.ToUpper(input[i + 1]));
                        i++;
                    }
                }
                else if (char.IsUpper(input[i])) // ID will be converted to Id
                {
                    if (input.Length != 2)
                        retVal.Append(input[i]);
                    else
                        retVal.Append(char.ToLower(input[i]));                    
                }
                else
                {
                    retVal.Append(input[i]);
                }
            }

            /*
            bool sawUC = false;
            for (int i = 0; i < input.Length; i++)
            {
                if (input[i] == '_')
                {
                    sawUC = true;
                    continue;
                }
                if (sawUC)
                {
                    retVal.Append(char.ToUpper(input[i]));
                    sawUC = false;
                    continue;
                }
                if (i == 0)
                {
                    retVal.Append(char.ToUpper(input[i]));
                    continue;
                }
                // Append As-Is
                retVal.Append(input[i]);
            }
             * */
            return retVal.ToString();
        }

        public static string ConvertToSentence(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;            

            StringBuilder retVal = new StringBuilder(32);
            retVal.Append(char.ToUpper(input[0]));
            for (int i = 1; i < input.Length; i++)
            {
                if (input[i] == '_')
                {
                    retVal.Append(" ");                    
                }
                else if (char.IsUpper(input[i]))
                {
                    retVal.Append(" ");
                    retVal.Append(char.ToLower(input[i]));
                }
                else
                {
                    retVal.Append(input[i]);
                }
            }

            return retVal.ToString();
        }

        public static string GetEquivalentSqlDbTypeEnum(string sqlType)
        {
            string enumText = string.Empty;
            switch (sqlType)
            {
                case "float":
                    enumText = "SqlDbType.Float";
                    break;
                case "text":
                    enumText = "SqlDbType.Text";
                    break;
                case "image":
                    enumText = "SqlDbType.Image";
                    break;
                case "decimal":
                    enumText = "SqlDbType.Decimal";
                    break;
                case "nvarchar":
                    enumText = "SqlDbType.NVarChar";
                    break;
                case "smalldatetime":
                    enumText = "SqlDbType.SmallDateTime";
                    break;
                case "int":
                    enumText = "SqlDbType.Int";
                    break;
                case "ntext":
                    enumText = "SqlDbType.NText";
                    break;
                case "varchar":
                    enumText = "SqlDbType.VarChar";
                    break;
                case "date":
                    enumText = "SqlDbType.Date";
                    break;
                case "datetime":
                    enumText = "SqlDbType.DateTime";
                    break;
                case "numeric":
                    enumText = "SqlDbType.Decimal";
                    break;
                case "bigint":
                    enumText = "SqlDbType.BigInt";
                    break;
                case "bit":
                    enumText = "SqlDbType.Bit";
                    break;
                case "char":
                    enumText = "SqlDbType.Char";
                    break;
                case "tinyint":
                    enumText = "SqlDbType.TinyInt";
                    break;
                case "nchar":
                    enumText = "SqlDbType.NChar";
                    break;
                case "uniqueidentifier":
                    enumText = "SqlDbType.UniqueIdentifier";
                    break;
                case "smallint":
                    enumText = "SqlDbType.SmallInt";
                    break;
                case "varbinary":
                    enumText = "SqlDbType.VarBinary";
                    break;
                case "money":
                    enumText = "SqlDbType.Money";
                    break;
                case "smallmoney":
                    enumText = "SqlDbType.SmallMoney";
                    break;
            }

            return enumText;
        }

        public static string GetEquivalentTypeName(string sqlType)
        {
            string dataType = string.Empty;
            switch (sqlType)
            {
                case "text":
                    dataType = "string";
                    break;
                case "image":
                    dataType = "byte[]";
                    break;
                case "decimal":
                    dataType = "decimal"; //"decimal?";
                    break;
                case "float":
                    dataType = "float"; //"decimal?";
                    break;
                case "nvarchar":
                    dataType = "string";
                    break;
                case "smalldatetime":
                    dataType = "DateTime";//"DateTime?";
                    break;
                case "int":
                    dataType = "int";//"int?";
                    break;
                case "ntext":
                    dataType = "string";
                    break;
                case "varchar":
                    dataType = "string";
                    break;
                case "date":
                case "datetime":
                    dataType = "DateTime";//"DateTime?";
                    break;
                case "numeric":
                    dataType = "decimal";//"decimal?";
                    break;
                case "bigint":
                    dataType = "long";//"long?";
                    break;
                case "bit":
                    dataType = "bool";//"bool?";
                    break;
                case "char":
                    dataType = "char";//"char?";
                    break;
                case "tinyint":
                    dataType = "byte";//"byte?";
                    break;
                case "nchar":
                    dataType = "string";
                    break;
                case "uniqueidentifier":
                    dataType = "string";// "Guid";
                    break;
                case "smallint":
                    dataType = "int";//"int?";
                    break;
                case "varbinary":
                    dataType = "byte[]";
                    break;
                case "smallmoney":
                case "money":
                    dataType = "decimal";//"decimal?";
                    break;
            }

            return dataType;
        }

        public static string GetRowValueByTypeName(string sqlType, string columnName, string pascalColumnName)
        {
            string str = string.Empty;
            switch (sqlType)
            {
                case "ntext":
                case "varchar":
                case "nvarchar":
                case "nchar":
                case "text":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? string.Empty : row[""{0}""].ToString()", columnName);
                    break;
                case "varbinary":
                case "image":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : ObjectToByteArray(row[""{0}""])", columnName, pascalColumnName);
                    break;
                case "decimal":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : decimal.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "float":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : float.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "smalldatetime":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : DateTime.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "int":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : int.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "date":
                case "datetime":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : DateTime.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "numeric":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : decimal.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "bigint":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : long.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "bit":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : bool.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "char":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : char.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "tinyint":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : byte.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "uniqueidentifier":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : row[""{0}""].ToString()", columnName, pascalColumnName);
                    break;
                case "smallint":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : int.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
                case "smallmoney":
                case "money":
                    str = string.Format(@"(row[""{0}""] == DBNull.Value) ? _{1} : decimal.Parse(row[""{0}""].ToString())", columnName, pascalColumnName);
                    break;
            }

            return str;
        }

        public static string GetDefaultValueForType(string sqlType)
        {
            string defaultValue = string.Empty;
            return defaultValue;
        }

        public static StreamWriter 
            GetFileStreamWriter(string filePath, bool overwriteExistingFile)
        {
            FileStream writeStream = null;
            StreamWriter fileWriter = null;
            bool isFileExists = File.Exists(filePath);

            writeStream = new FileStream(filePath, ((isFileExists && !overwriteExistingFile) ? FileMode.Append : FileMode.Create), FileAccess.Write);
            fileWriter = new StreamWriter(writeStream);

            return fileWriter;
        }

        public static void CloseFileStream(StreamWriter fileWriter)
        {
            if (fileWriter != null)
            {
                fileWriter.Flush();
                fileWriter.Close();
            }

            if (fileWriter.BaseStream != null)
            {
                fileWriter.BaseStream.Close();
            }
        }
    }
}
