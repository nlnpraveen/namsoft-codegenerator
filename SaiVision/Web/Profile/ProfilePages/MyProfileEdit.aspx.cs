using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SaiVision.Web.Profile.ProfilePages
{
    public partial class MyProfileEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MyProfileClass mpc = MyProfileClass.GetProfile();
                ddlColor.SelectedValue = mpc.ProfileInfo.ColorPreference;
                txtZipCode.Text = mpc.ProfileInfo.PostalCode.ToString();
                txtName.Text = mpc.ProfileInfo.Name;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            MyProfileClass mpc = MyProfileClass.GetProfile();
            mpc.ProfileInfo.ColorPreference = ddlColor.SelectedValue;
            mpc.ProfileInfo.PostalCode=int.Parse(txtZipCode.Text);
            mpc.ProfileInfo.Name=txtName.Text;
            mpc.Save();
            Response.Redirect("MyProfilePage.aspx");
        }
    }
}