using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Student
{
    public partial class MyExams : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEnrolledExams();
            }
        }

        private void LoadEnrolledExams()
        {
            int studentId = int.Parse(Session["StdId"].ToString());

            var enrolledExams = dbo.StudentExamEnrollments
                                    .Where(se => se.StudentID == studentId)
                                    .Join(dbo.Exams,
                                          enrollment => enrollment.ExamID,
                                          exam => exam.ExamID,
                                          (enrollment, exam) => new
                                          {
                                              exam.ExamID,
                                              exam.Title,
                                              exam.Duration,
                                              exam.ExamDate,
                                              exam.StartTime,
                                              EnrollmentDate = enrollment.EnrollmentDate
                                          })
                                    .ToList();

            rptEnrolledExams.DataSource = enrolledExams;
            rptEnrolledExams.DataBind();
        }

        protected void btnStartExam_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null)
            {
                string examIdStr = btn.CommandArgument; // Get ExamID from CommandArgument
                if (!string.IsNullOrEmpty(examIdStr))
                {
                    int examId = Convert.ToInt32(examIdStr);
                    int studentId = int.Parse(Session["StdId"].ToString());

                    Session["ExamID"] = examId;
                    Session["UserID"] = studentId;

                    Response.Redirect($"~/ExamPanel/ExamPanel1.aspx");
                }
            }
        }

    }
}