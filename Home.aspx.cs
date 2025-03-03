using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void LoadStudentLogin(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/StudentLogin.aspx");
        }
        protected void LoadAdminLogin(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AdminLogin.aspx");
        }
        protected void LoadRegisterPage(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

    }
}