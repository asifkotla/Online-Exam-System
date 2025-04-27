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
    public partial class StdHome : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();

        protected void Page_Load(object sender, EventArgs e)
        {
            int stdid = int.Parse(Session["StdId"].ToString());
            int cntenroll = dbo.StudentExamEnrollments.Where(x => x.StudentID == stdid).Count();
            Label1.Text = cntenroll.ToString();
            int cntcomp = dbo.StudentExamEnrollments.Where(x => x.StudentID == stdid && x.IsExamCompleted == true).Count();
            Label2.Text = cntcomp.ToString();
            int cntpending = dbo.StudentExamEnrollments.Where(x => x.StudentID == stdid && (x.IsExamCompleted == false|| x.IsExamCompleted == null)).Count();
            Label3.Text = cntpending.ToString();
            if (!IsPostBack)
            {
                var upcomingExams = dbo.Exams
                .Where(exam => exam.ExamDate >= DateTime.Today
                    && dbo.StudentExamEnrollments.Any(enroll => enroll.StudentID == stdid && enroll.ExamID == exam.ExamID))
                .OrderBy(exam => exam.StartTime)
                .Take(2)
                .ToList();

                if (upcomingExams != null && upcomingExams.Count > 0)
                {
                    rptUpcomingExams.DataSource = upcomingExams;
                    rptUpcomingExams.DataBind();
                }
                else
                {
                    // No exams enrolled
                    rptUpcomingExams.DataSource = null;
                    rptUpcomingExams.DataBind();

                    lblNoExamMessage.Visible = true; // Show a label like "No exams enrolled"
                }
            }
        }
        protected void StartExam_Click(object sender, CommandEventArgs e)
        {
            //string examId = e.CommandArgument.ToString();
            //// Redirect to Exam Page
            //Response.Redirect("ExamStart.aspx?examId=" + examId);
        }
    }
}