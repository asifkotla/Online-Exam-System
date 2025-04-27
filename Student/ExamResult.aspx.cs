using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Student
{
    public partial class ExamResult : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadExamResults();
            }
        }

        private void LoadExamResults()
        {
            int studentId = int.Parse(Session["StdId"].ToString());

            var examResults = dbo.StudentExamEnrollments
                .Where(enrollment => enrollment.StudentID == studentId)
                .Join(dbo.Exams,
                      enrollment => enrollment.ExamID,
                      exam => exam.ExamID,
                      (enrollment, exam) => new
                      {
                          exam.ExamID,
                          exam.Title,
                          enrollment.EnrollmentDate,
                          enrollment.IsExamCompleted,
                          Status = (bool)enrollment.IsExamCompleted ? "Completed" : "Yet Not Started"
                      })
                .ToList();

            rptExamResults.DataSource = examResults;
            rptExamResults.DataBind();
        }

        // Handle Download PDF button click
        protected void rptExamResults_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DownloadPDF")
            {
                int examId = Convert.ToInt32(e.CommandArgument);

                // Implement PDF generation logic here
                // For example, you can use iTextSharp or Rotativa to generate the PDF

                // Example of redirect to a PDF generation page (implement as needed)
                // Response.Redirect("~/DownloadExamResult.aspx?ExamID=" + examId);
            }
        }
    }
}