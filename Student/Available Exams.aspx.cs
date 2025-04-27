using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Student
{
    public partial class Available_Exams : System.Web.UI.Page
    { OnlineeExamSystemEntities2 dbo=new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAvailableExams();
            }
        }

        private void LoadAvailableExams()
        {
            var today = DateTime.Now.Date;

            var availableExams = dbo.Exams
         .Where(x => x.ExamDate >= today)
         .Join(dbo.Admins,  // Assuming you have a Users table
               exam => exam.CreatedBy,  // This is the ID field in the Exams table
               user => user.AdminID,  // Assuming UserID is the primary key in Users table
               (exam, user) => new
               {
                   exam.ExamID,
                   exam.Title,
                   exam.Duration,
                   exam.ExamDate,
                   exam.StartTime,
                   CreatedByName = user.FullName, // Replace 'Name' with the correct field for the user's name
                   DaysLeft = System.Data.Entity.SqlServer.SqlFunctions.DateDiff("day", today, exam.ExamDate)
               })
         .ToList();

            rptAvailableExams.DataSource = availableExams;
            rptAvailableExams.DataBind();
        }

        // Handling Enroll Button click
        protected void rptAvailableExams_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Enroll")
            {
                int examId = Convert.ToInt32(e.CommandArgument);
                int studentId = int.Parse(Session["StdId"].ToString());

                // Check if already enrolled
                var alreadyEnrolled = dbo.StudentExamEnrollments
                                        .Any(en => en.ExamID == examId && en.StudentID == studentId);

                if (!alreadyEnrolled)
                {
                    dbo.StudentExamEnrollments.Add(new StudentExamEnrollment
                    {
                        StudentID = studentId,
                        ExamID = examId,
                        EnrollmentDate = DateTime.Now,
                        IsExamCompleted=false
                        
                    });

                    dbo.SaveChanges();

                    Response.Write("<script>alert('✅ Enrolled Successfully!');</script>");
                      
                }
                else
                {
                    Response.Write("<script>alert('❎ You have already enrolled in this exam.');</script>");
                }
                LoadAvailableExams(); // Re-load the exams list
                rptAvailableExams.DataBind();
            }
        }

    }
}