using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Student
{
    public partial class StudentDashboard : System.Web.UI.MasterPage
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Session["stdEmailid"].ToString();
            var stduser = dbo.Students.Where(x => x.Email == email).FirstOrDefault();
            Label1.Text = stduser.FullName;
            if (!IsPostBack)
            {

                var user = dbo.Students.Where(x => x.Email == email).FirstOrDefault();
                var profileImagePath = Utility.ConvertByteArrayToImage(user.ProfileImage);
                if (stduser.ProfileImage != null && stduser.ProfileImage.Length > 0)
                {
                    string base64String = Convert.ToBase64String(stduser.ProfileImage);
                    imgProfile.Src = "data:image/png;base64," + base64String;
                }
                else
                {
                    imgProfile.Src = "../assets/default-profile1.png"; // fallback
                }
            }
        }
        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Home.aspx");
        }
     
            
    }
}