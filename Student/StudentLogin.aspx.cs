using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Student
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void StudentLogin1(object sender, EventArgs e)
        {
            string username = UserName.Text.Trim();
            string password1 = pass.Text;

            var student = dbo.Students.FirstOrDefault(x => x.Email == username);
            if (student != null)
            {
                byte[] pass = student.PasswordHash;
                if (Utility.VerifyPassword(password1, pass) == true)
                {
                    Response.Write("<script>alert(' ✅ Succesfully Logged In');</script>");
                }
                else
                {
                    Response.Write("<script>alert(' ❎ Something Went Wrong Please Try Agaain');</script>");
                }
            }
        }
    }
}