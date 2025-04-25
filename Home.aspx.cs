using Online_Exam_System.Models;
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

        OnlineeExamSystemEntities2 dbo=new OnlineeExamSystemEntities2();  

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
        protected void Button1Submit_Click(object sender, EventArgs e)
        {
            Feedback fd= new Feedback();    
            fd.Name=Name.Text;
            fd.Email=email.Text;
            fd.feedback1=feedback.Text;
            fd.Date = DateTime.Now;
            dbo.Feedbacks.Add(fd);
            
            if(dbo.SaveChanges()>0)
            {
                Response.Write("<script>alert(' ✅ Thank You For Your FeedBack');</script>");
            }
            else
            {
                Response.Write("<script>alert(' ❎ Something Went Wrong Please Try Again!!!');</script>");
            }
        }

    }
}