using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;

namespace SaiVision.Web.Profile.ProfilePages
{
    public class MyProfileClass : ProfileBase
    {
        /*
        public string Name
        {
            get { return base["Name"].ToString(); }
            set { base["Name"] = value; }
        }

        public int PostalCode
        {
            get { return int.Parse(base["PostalCode"].ToString()); }
            
            set { base["PostalCode"] = value; }
        }

        public string ColorPreference
        {
            get { return base["ColorPreference"].ToString(); }
            set { base["ColorPreference"] = value; }
        }
        */

        private MyProfileInfo mpi;
        public MyProfileInfo ProfileInfo
        {
            get 
            {
                if (mpi == null)
                {
                    mpi = new MyProfileInfo();
                    mpi.Name = base["Name"].ToString();
                    mpi.PostalCode = int.Parse(base["PostalCode"] == null ? "0" : base["PostalCode"].ToString());
                    mpi.ColorPreference = base["ColorPreference"] == null ? string.Empty : base["ColorPreference"].ToString();
                }
                return mpi; 
            }
        } 

        public static MyProfileClass GetProfile()
        {
            return (MyProfileClass)HttpContext.Current.Profile;
        }

        public override void Save()
        {
            base["Name"] = ProfileInfo.Name;
            //base["PostalCode"] = ProfileInfo.PostalCode.ToString();
            base["ColorPreference"] = ProfileInfo.ColorPreference;            
            //base["ProfileInfo"] = ProfileInfo;
            base.Save();
        }
    }
}