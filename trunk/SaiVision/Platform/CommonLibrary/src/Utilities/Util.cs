using System;
using System.Reflection;
using System.Globalization;
using System.Resources;
using System.Text;

namespace SaiVision.Platform.CommonLibrary
{
    /// <summary>
    /// The type of database being used.
    /// </summary>
    public enum DBType : int
    {
        None = 0,
        /// <summary>
        /// Microsoft SQL Server
        /// </summary>
        SQLServer = 1,
        /// <summary>
        /// Oracle RDBMS
        /// </summary>
        Oracle = 2,
        /// <summary>
        /// MySQL Database
        /// </summary>
        MySQL = 3,
        MongoDB = 4
    }

    /// <summary>
    /// The environment you want the database from (i.e. Production, QA, etc.)
    /// </summary>
    public enum DBEnvironment
    {
        None = 0,
        /// <summary>
        /// Use the Development instance.
        /// </summary>
        Development = 1,
        /// <summary>
        /// Use the QA instance.
        /// </summary>
        QA = 2,
        /// <summary>
        /// Use the Production instance.
        /// </summary>
        Production = 3,
        /// <summary>
        /// ORACLE USE ONLY CURRNTLY: Use the value in the "ConnectionString" config value. Ex: "OracleConnectionString".
        /// </summary>
        Default = 4,
        /// <summary>
        /// Pre-QA; ORACLE USE ONLY CURRNTLY: Use the value in the "ConnectionString" config value. Ex: "OracleConnectionString".
        /// </summary>
        PQA = 5
    }

    /// <summary>
    /// The server type you want to connect to for data (e.g. main application, reporting, etc.)
    /// </summary>
    public enum DBServerType
    {
        None = 0,
        /// <summary>
        /// Use the application database server
        /// </summary>
        Application = 1,
        /// <summary>
        /// Use the reporting database server
        /// </summary>
        Reporting = 2,
        /// <summary>
        /// Use the Lifetime database server
        /// </summary>
        LifeTime = 3,
        /// <summary>
        /// Use the Ecommerce database server
        /// </summary>
        Ecommerce = 4,
        /// <summary>
        /// Use the Logi Metadata database server
        /// </summary>
        CustomReports = 5,
        /// <summary>
        /// Use the Ajax Session Data
        /// </summary>
        AjaxSessionData = 6,
        /// <summary>
        /// Use the Calculation Data
        /// </summary>

        CalculationData = 7,

        /// <summary>
        /// Use the Calculation Data
        /// </summary>

        ActivityRecurrence = 8,

        /// <summary>
        /// Use the File Upload Data
        /// </summary>
        FileUploadData = 9,
        /// <summary>
        /// Use the PIRegistry Data
        /// </summary>
        PIRegistry = 10,
        /// <summary>
        /// Use the Command Center Providers Data
        /// </summary>
        CommandCenterProviders = 11,
        /// <summary>
        /// Use the Event Sentry Data
        /// </summary>
        EventSentry = 12,
        /// <summary>
        /// Use the Error Management Data
        /// </summary>
        ErrorManagement = 13,
        /// <summary>
        /// Use Support Center Data
        /// </summary>
        SupportCenter = 14
    }

    /// <summary>
    /// An enumaration of the possible Status values.
    /// </summary>
    public enum Status : int
    {
        None = 0,
        InActive = 1,
        Active = 2,
        UnderConstruction = 3,
        WaitingApproval = 4,
        Approved = 5,
        UnderReview = 6,
        Published = 7,
        InProgress = 8,
        PendingReassessment = 9,
        Complete = 10,
        NotStarted = 11,
        WaitingForReassessment = 12,
        SubmittedForCredit = 13,
        Pass = 14,
        Fail = 15,
        Invalid = 17,
        Valid = 18,
        ImportPending = 20,
        ImportCompleted = 22,
        ImportError = 24,
        ImportCancelled = 44,
        QA = 26,
        Production = 27,
        Cancelled = 61,
        ValidationRejected = 62,
        Pending = 41,
        PickedByService = 63,
        Rejected = 64
    }

    /// <summary>
    /// An enumeration of the possibile priority values.
    /// </summary>
    public enum Priority : int
    {
        None = 0,
        Low = 1,
        Medium = 2,
        High = 3
    }
    /// <summary>
    /// The possible sort orders.
    /// </summary>
    public enum SortOrder : int
    {
        Ascending = 0,
        Descending = 1
    }

    /// <summary>
    /// The type of a provider assessment report.
    /// </summary>
    public enum ProviderAssessmentReportType : int
    {
        None = 0,
        Comparison = 1,
        Summary = 2,
        Single = 3
    }

    /// <summary>
    /// A provider assessment report qualifier.
    /// </summary>
    public enum ProviderAssessmentReportValueType : int
    {
        None = 0,
        Provider = 1,
        Peer = 2,
        Benchmark = 3,
        PracticeGroup = 4,
        ParentPracticeGroup = 5
    }

    /// <summary>
    /// The type of form.
    /// </summary>
    public enum FormType : int
    {
        None = 0,
        ChartReview = 1,
        PracticeAssessment = 2,
        ProgramEvaluation = 3,
        Participant = 4,
        ExternalActivityForm = 14
    }

    /// <summary>
    /// The type of chart to display.
    /// </summary>
    public enum ChartType : int
    {
        None = 0,
        Area = 1,
        Bar = 2,
        Bubble = 3,
        Candlestick = 4,
        Column = 5,
        Cylinder = 6,
        Doughnut = 7,
        Line = 8,
        Pie = 9,
        Point = 10
    }

    /// <summary>
    /// The type to download.
    /// </summary>
    public enum DownloadType : int
    {
        None = 0,
        Form = 1,
        Header = 2,
        Logo1 = 3,
        Logo2 = 4,
        Resource = 5
    }

    /// <summary>
    /// System level unit indicators
    /// </summary>
    public enum SystemUnits : int
    {
        None = 0,
        Percent = 1,
        MililetersPerDecaliter = 2,
        Onces = 3,  // 'Onces' or 'Ounces'?
        Pounds = 4,
        Years = 5,
        Patients = 6
    }

    public enum OrganizationManagerModes : int
    {
        None = 0,
        AddUser = 100,
        EditUser = 200,
        RemoveUser = 300,
        RemoveFromModule = 400,
        AddUserGroup = 500,
        EditUserGroup = 600,
        RemoveUserGroup = 700,
        ChangeUserPassword = 800,
        RemoveUserGroupWarning = 900,
        AddParticipantGroup = 1000,
        EditParticipantGroup = 1100,
        RemoveParticipantGroup = 1200,
        ManageParticipantGroupMembership = 1300,
        ManageImageLibrary = 1400,
        AddImage = 1500,
        EditImage = 1600,
        DeleteImage = 1700,
        ViewImage = 1800
    }

    public enum PermissionCode : int
    {
        None = 0,
        Add = 100,
        Edit = 110,
        Delete = 120,
        Index = 130,
        Report = 140,
        Publish = 150,
        Request = 930,
        Manage = 931
    }

    public enum ObjectListCode : int
    {
        None = 0,
        ActivityListIndexing = 1,
        ManageIndexList = 2
    }

    public enum ModuleDefinitionCode : int
    {
        None = 0,
        PresentationLibrary = 38,
        SpeakersBureau = 48,
        LMSTranscript = 51,
        LMSPrograms = 52,
        LMSProgramIndex = 53,
        LMSProgramPostTest = 54,
        LMSProgramDisclaimer = 55,
        LMSProfile = 58,
        LMSCurriculum = 59,
        LMSAutoLogoff = 60,
        LMSProgramCatalog = 62,
        PresLib2Main = 63,
        PresLib2Browser = 66,
        PresLib2Manager = 67
    }
    /// <summary>
    /// Possible Import Types
    /// </summary>
    public enum ImportType : int
    {
        None = 0,
        Participants = 1,
        Activity = 2,
        AssessmentScore = 3,
        AssessmentAttempt = 4,
        ParticipantRegistration = 5,
        SiteRegistration = 6,
        VelocityActivityImport = 7,
        AssessmentResults = 8,
        VelocityABTImport = 9,
        VelocityActivityRegistration = 10,
        VelocityActivityDisclaimerPage = 11,
        VelocityABTScenarioImport = 12,
        VelocityABTProviderImport = 13,
        VelocityABTScenarioAccreditationImport = 14,
        ProjectImport = 15,
        SiteParticipantRegistration = 16,
        SiteParticipantActivity = 17,
        ParticipantRequirements = 18
    }
    /// <summary>
    /// Possible Import Groups
    /// </summary>
    public enum ImportGroup : int
    {
        None = 0,
        ActivityRegistrationAndResults = 1,
        SiteRegistration = 2,
        Main = 3,
        AssessmentScores = 4,
        PortalRegistration = 5,
        ActivityResults = 6,
        PortalAndActivityRegistration = 7,
        AssessmentResults = 8,
        ActivityImport = 9
    }

    /// <summary>
    /// Custom WebEvent codes so as not to conflict with the Microsoft events
    /// </summary>
    public enum WebEventCustomCode
    {
        None = 0,
        GeneralError = System.Web.Management.WebEventCodes.WebExtendedBase + 1,
        CriticalError,
        DomainExpectedException,
        DomainUnexpectedException,
        TechnicalExpectedException,
        TechnicalUnexpectedException
    }

    /// <summary>
    /// DistributionBoundries identify the software tier 
    /// </summary>
    public enum DistributionBoundry
    {
        None = 0,
        DataTier = 1,
        MiddleTierData = 2,
        MiddleTierManagement = 3,
        FrontEnd = 4
    }

    /// <summary>
    /// A class to handle translating enums.
    /// </summary>
    public sealed class Util
    {
        // private constructor added to avoid violating following rule: StaticHolderTypesShouldNotHaveConstructors
        private Util() { }

        /// <summary>
        /// Translates a sort order enum to the proper database sort qualifier.
        /// </summary>
        /// <param name="SortOrder">The enum value to convert.</param>
        /// <returns>The correct string representation.</returns>
        public static string TranslateSortOrderToString(SortOrder sortOrder)
        {
            switch (sortOrder)
            {
                case SortOrder.Ascending:
                    return "ASC";
                case SortOrder.Descending:
                    return "DESC";
                default:
                    return "ASC";
            }
        }

        /// <summary>
        /// Converts integer code values to the proper enumeration.
        /// </summary>
        /// <param name="code">The integer to convert.</param>
        /// <returns>The equivalent enumerated value.</returns>
        [Obsolete("Use a direct cast instead - this method should have never existed - it is unnecessary")]
        public static Status TranslateCodeToStatus(int code)
        {
            return (Status)code;
            //			switch (code
            //			{
            //				case 1:
            //					return Status.InActive;
            //
            //				case 2:
            //					return Status.Active;
            //
            //				case 3:
            //					return Status.UnderConstruction;
            //
            //				case 4:
            //					return Status.WaitingApproval;
            //
            //				case 5:
            //					return Status.Approved;
            //
            //				case 6:
            //					return Status.UnderReview;
            //
            //				case 7:
            //					return Status.Published;
            //
            //				case 8:
            //					return Status.InProgress;
            //
            //				case 9:
            //					return Status.PendingReassessment;
            //
            //				case 10:
            //					return Status.Complete;
            //
            //				case 11:
            //					return Status.NotStarted;
            //
            //				case 12:
            //					return Status.WaitingForReassessment;
            //
            //				case 13:
            //					return Status.SubmittedForCredit;
            //
            //				default:
            //					return Status.InActive;
            //			}
        }

        /// <summary>
        /// Converts a status code enumerated value to an integer value.
        /// </summary>
        /// <param name="StatusCode">The enumerated value to convert.</param>
        /// <returns>The equivalent integer value.</returns>
        [Obsolete("Cast the code directly to an integer instead - this method is unnecessary.")]
        public static int TranslateStatusToCode(Status statusCode)
        {
            return (int)statusCode;
            //			switch (statusCode)
            //			{
            //				case Status.InActive:
            //					return 1;
            //
            //				case Status.Active:
            //					return 2;
            //
            //				case Status.UnderConstruction:
            //					return 3;
            //
            //				case Status.WaitingApproval:
            //					return 4;
            //
            //				case Status.Approved:
            //					return 5;
            //
            //				case Status.UnderReview:
            //					return 6;
            //
            //				case Status.Published:
            //					return 7;
            //
            //				case Status.InProgress:
            //					return 8;
            //
            //				case Status.PendingReassessment:
            //					return 9;
            //
            //				case Status.Complete:
            //					return 10;
            //
            //				case Status.NotStarted:
            //					return 11;
            //
            //				case Status.WaitingForReassessment:
            //					return 12;
            //
            //				case Status.SubmittedForCredit:
            //					return 13;
            //
            //				default:
            //					return 1;
            //			}
        }

        /// <summary>
        /// Converts a string to its equivalent enumerated value.
        /// </summary>
        /// <param name="t">The enumeration the value is based on.</param>
        /// <param name="Value">The string to convert.</param>
        /// <returns>A proper enumerated value.</returns>
        public static object StringToEnum(Type myType, string value)
        {
            if (myType == null)
                throw new CECityArgumentOutOfRangeException("myType", "null", CECityResourceManager.GetCECityResourceManager().GetString("NullParameter", "StringToEnum()", "myType"));

            foreach (FieldInfo fi in myType.GetFields())
                if (fi.Name == value)
                    return fi.GetValue(null);
            // We use null because
            // enumeration values
            // are static

            throw new SystemTechnicalException(CECityResourceManager.GetCECityResourceManager().GetString("CastingError", "StringToEnum()", "value, myType"), DistributionBoundry.MiddleTierData, WebEventCustomCode.TechnicalUnexpectedException);
        }

        /// <summary>
        /// Converts a status enumerated value to its string representation.
        /// </summary>
        /// <param name="StatusCode">The enumerated value.</param>
        /// <returns>The equivalent string.</returns>
        public static string TranslateStatusToString(Status statusCode)
        {
            return statusCode.ToString();
        }


        public static string FormatDate(object dateValue)
        {
            string DateString = "";
            try
            { DateString = Convert.ToDateTime(dateValue, CultureInfo.InvariantCulture).ToShortDateString(); }
            catch (System.InvalidCastException)
            { DateString = ""; }
            catch (Exception)
            { DateString = ""; }

            if (String.IsNullOrEmpty(DateString) || DateString.Contains("12/31/9999") || DateString.Contains("1/1/0001"))
            {
                DateString = "&nbsp;";
            }

            return DateString;

        }

        // returns the given date in long form without the day of the week.
        public static string FormatDateString(string dateValue, bool printTime)
        {
            string DateString = "";
            DateTime dt = DateTime.MinValue;
            try
            { dt = Convert.ToDateTime(dateValue, CultureInfo.InvariantCulture); }
            catch (System.InvalidCastException)
            { DateString = ""; }
            catch (Exception)
            { DateString = ""; }

            DateString = dt.ToLongDateString();
            if (printTime)
                DateString += " " + dt.ToLongTimeString();

            if (String.IsNullOrEmpty(DateString) || DateString.Contains("9999") || DateString.Contains("0001"))
            {
                DateString = "&nbsp;";
            }

            return DateString.Substring(DateString.IndexOf(',') + 2);
        }

        // returns the given date in long form without the day of the week.
        public static string FormatDateString(DateTime dateValue, bool printTime)
        {
            string DateString = dateValue.ToLongDateString();
            if (printTime)
                DateString += " " + dateValue.ToLongTimeString();

            if (String.IsNullOrEmpty(DateString) || DateString.Contains("9999") || DateString.Contains("0001"))
            {
                DateString = "&nbsp;";
            }

            return DateString.Substring(DateString.IndexOf(',') + 2);
        }

        public static string GenerateTextTag(int TextTagType, int TextOrderSeq)
        {
            string returnStr = "";

            switch (TextTagType)
            {
                case 0: // none
                    returnStr = "";
                    break;

                case 1: // numeric
                    returnStr = TextOrderSeq.ToString();
                    break;

                case 2: // Alpha Upper Case
                    returnStr = TranslateIntToASCII(TextOrderSeq, false);
                    break;

                case 3: // Alpha LowerCase
                    returnStr = TranslateIntToASCII(TextOrderSeq, true);
                    break;

                case 4: // Roman Upper Case
                    returnStr = IntToRoman(TextOrderSeq, false);
                    break;

                case 5: // Roman Lower Case
                    returnStr = IntToRoman(TextOrderSeq, true);
                    break;

                default: // invalid type
                    returnStr = "Invalid Choice Tag Type";
                    break;
            }

            return returnStr;
        }

        private static string IntToRoman(int number, bool lowerC)
        {
            string RomanNumeral = "";
            int temp;

            if (number > 3999 || number < 1)
                return "Not a Roman Numeral";

            string[] ones = { " ", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };
            string[] tens = { " ", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC" };
            string[] hundreds = { " ", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM" };
            /* thousands are done through replication */

            RomanNumeral = Replicate("M", (number / 1000));
            number %= 1000;
            temp = (number / 100);
            if (temp != 0)
                RomanNumeral = RomanNumeral + hundreds[temp];
            number %= 100;
            temp = (number / 10);
            if (temp != 0)
                RomanNumeral = RomanNumeral + tens[temp];
            number = (number % 10);
            if (number != 0)
                RomanNumeral = RomanNumeral + ones[number];

            if (lowerC)
                return RomanNumeral.ToLower();
            else
                return RomanNumeral;
        }

        private static string Replicate(string instr, int count)
        {
            string tempString = "";
            count = System.Math.Abs(count);
            for (int i = 1; i <= count; i++)
            {
                tempString += instr;
            }
            return tempString;
        }

        private static string TranslateIntToASCII(int number, bool lowerC)
        {
            string retStr = "";
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            if (number < 1)
            {
                retStr = "0";
            }
            else if (number <= 26)
            {
                byte[] buffer = new byte[1];

                if (lowerC)
                    buffer[0] = (byte)(number + 96);
                else
                    buffer[0] = (byte)(number + 64);


                retStr = encoding.GetString(buffer);
            }
            else
            {
                int multiples = (number / 26) + 1;
                int charcode = number % 26;
                if (charcode == 0)
                {
                    charcode = 26;
                    multiples -= 1;
                }
                for (int i = 1; i <= multiples; i++)
                {
                    byte[] buffer = new byte[1];

                    if (lowerC)
                        buffer[0] = (byte)(charcode + 96);
                    else
                        buffer[0] = (byte)(charcode + 64);


                    retStr += encoding.GetString(buffer);
                }
            }

            return retStr;
        }
    }
}
