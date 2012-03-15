using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SaiVision.Web.Profile.ProfilePages
{
    public partial class ProfileMain : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MyProfileClass mpc = MyProfileClass.GetProfile();

            if (!string.IsNullOrEmpty(mpc.ProfileInfo.Name))
            {
                hypName.Text = mpc.ProfileInfo.Name;
            }
            if (!string.IsNullOrEmpty(mpc.ProfileInfo.ColorPreference))
            {                    
                pnlProfile.Style.Clear();
                pnlProfile.Style.Add("background-color", mpc.ProfileInfo.ColorPreference);
                //pnlProfile.Style.Add("padding", "20px 20px 20px 20px");
            }
        }
    }
}