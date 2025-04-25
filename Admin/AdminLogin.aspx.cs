using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
       OnlineeExamSystemEntities2 dbo=new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void AdminLogin1(object sender, EventArgs e)
        {
            string username= UserName.Text.Trim();
            string password1=password.Text;

            var admin = dbo.Admins.FirstOrDefault(x =>x.Email == username);
            if(admin!=null)
            {
                byte[] pass=admin.PasswordHash;
                if(Utility.VerifyPassword(password1,pass)==true)
                {
                    Response.Write("<script>alert(' ✅ Succesfully Logged In');</script>");
                    Session["Emailid"] = admin.Email;
                    Session["adminId"] = admin.AdminID;
                    Response.Redirect("~/Admin/AdminDasboard.aspx");
                    
                }
                else
                {
                    Response.Write("<script>alert(' ❎ Something Went Wrong Please Try Agaain');</script>");
                }
            }
        }

    }
}