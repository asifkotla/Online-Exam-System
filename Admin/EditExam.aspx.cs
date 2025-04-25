using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    public partial class EditExam : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["ExamId"] != null)
                {
                    int examid = int.Parse(Session["ExamId"].ToString());
                    var exam = dbo.Exams.Where(x => x.ExamID == examid).FirstOrDefault();
                    Session["adminId"] = exam.CreatedBy;
                    txtTitle.Text = exam.Title;
                    txtTime.Text = exam.StartTime.ToString();
                    if (exam.ExamDate != null)
                    {
                        txtDate.Text = Convert.ToDateTime(exam.ExamDate).ToString("yyyy-MM-dd");
                    }
                    txtCreatedBy.Text = exam.Admin.FullName;
                    txtDuration.Text = exam.Duration.ToString();
                }
                else
                {
                    Response.Write("<script>alert('No exam selected to edit.');</script>");
                    Response.Redirect("~/Admin/Manage Exams.aspx");
                }

            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int examId = int.Parse(Session["ExamId"].ToString());

            // Step 1: Fetch existing exam
            var exam = dbo.Exams.FirstOrDefault(x => x.ExamID == examId);
            if (exam != null)
            {
                exam.ExamID= int.Parse(Session["ExamId"].ToString());
                exam.Title = txtTitle.Text;
                exam.StartTime = TimeSpan.Parse(txtTime.Text);
                exam.CreatedBy = int.Parse(Session["adminId"].ToString());
                exam.Duration = int.Parse(txtDuration.Text);
                exam.ExamDate = DateTime.Parse(txtDate.Text);
                if (dbo.SaveChanges() > 0)
                {
                    Response.Write("<script>alert('✅ Exam Details Updated Successfully');</script>");
                    Session.Remove("ExamId");
                    Response.Redirect("~/Admin/Manage Exams.aspx");
                }
                else
                {
                    Response.Write("<script>alert('❌ Something went wrong while updating exam details');</script>");
                    Session.Remove("ExamId");
                    Response.Redirect("~/Admin/Manage Exams.aspx");
                }

        
        }
    else
    {
        Response.Write("<script>alert('❌ Exam not found');</script>");
        Response.Redirect("~/Admin/Manage Exams.aspx");
    }


}
    }
}