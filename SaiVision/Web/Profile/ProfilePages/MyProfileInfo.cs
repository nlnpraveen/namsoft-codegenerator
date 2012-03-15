using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SaiVision.Web.Profile.ProfilePages
{
    [Serializable]
    public class MyProfileInfo
    {
        public string Name
        {
            get
            ;
            set;
        }

        public int PostalCode
        {
            get
            ;
            set;
        }

        public string ColorPreference
        {
            get
            ;
            set;
        }

    }
}