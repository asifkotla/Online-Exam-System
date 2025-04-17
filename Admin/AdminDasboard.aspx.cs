using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    public partial class AdminDasboard : System.Web.UI.Page
    {
        OnlineeExamSystemEntities1 dbo = new OnlineeExamSystemEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
          int cntUser=dbo.Students.Count(); 
           Label1.Text = cntUser.ToString();
            int cntExam=dbo.Exams.Count();
            Label2.Text = cntExam.ToString();
        }
    }
}