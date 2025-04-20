using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    public partial class Manage_Exams : System.Web.UI.Page
    {
        private DataTable AllUsers; 

        OnlineeExamSystemEntities1 dbo=new OnlineeExamSystemEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                AllUsers = GetUserList(); // load all users
                ViewState["Users"] = AllUsers;
                BindExam1(AllUsers);
                BindExams();
            }

        }
        private void BindExam1(DataTable dt)
        {
           AllExams.DataSource = dt;
            AllExams.DataBind();
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string searchTerm = SearchBox.Text.Trim().ToLower();
            DataTable dt = ViewState["Users"] as DataTable;

            if (dt != null)
            {
                var filteredRows = dt.AsEnumerable()
                    .OrderByDescending(r => r["Title"].ToString().ToLower().StartsWith(searchTerm))
                    .ThenBy(r => r["Title"].ToString());

                if (filteredRows.Any())
                    BindExam1(filteredRows.CopyToDataTable());
                else
                    BindExam1(dt.Clone()); // Show empty result with same structure
            }
        }
        private DataTable GetUserList()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ExamID");
            dt.Columns.Add("Title");
            dt.Columns.Add("CreatedBy");
            dt.Columns.Add("Duration");
            dt.Columns.Add("ExamDate");
            dt.Columns.Add("StartTime");

            var exams = dbo.Exams.Include("Admin")
             .Select(e => new
            {
                e.ExamID,
                e.Title,
                CreatedBy = e.Admin.FullName,
                e.Duration,
                e.ExamDate,
                e.StartTime
             }).ToList(); 

            foreach (var user in exams)
                {
                    dt.Rows.Add(user.ExamID, user.Title, user.CreatedBy, user.Duration,user.ExamDate,user.StartTime);
                }
            
            return dt;

        }
        private void BindExams()
        {
            var exams = dbo.Exams
        .Include("Admin") 
        .Select(e => new
        {
            e.ExamID,
            e.Title,
            CreatedBy = e.Admin.FullName, 
            e.Duration,
            e.ExamDate,
            e.StartTime
        })
        .ToList();
            
            AllExams.DataSource = exams;
            AllExams.DataBind();
        }
        private string SortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }


        protected void AllExam_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            AllExams.PageIndex = e.NewPageIndex;
            BindExams();
        }
        protected void btnSearch(object sender, EventArgs e)
        {
            txtSearch_TextChanged(sender, e);
        }
     

        protected void AllExam_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = ViewState["Users"] as DataTable;
            if (dt != null)
            {
                dt.DefaultView.Sort = e.SortExpression + " " + SortDirection;
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
                BindExam1(dt.DefaultView.ToTable());
            }
        }
        protected void btnEdit1(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int id = int.Parse(btn.CommandArgument);
            Session["ExamId"] = id;
            Response.Redirect("~/Admin/EditExam.aspx");
        }
        protected void btnDelete(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int id = int.Parse(btn.CommandArgument);
            var delExam = dbo.Exams.FirstOrDefault(x => x.ExamID == id);
            if (delExam == null)
            {
                Response.Write("<script>alert('❎ Exam Not Found');</script>");
            }
            else
            {
                dbo.Exams.Remove(delExam);
                if (dbo.SaveChanges() > 0)
                {
                    Response.Write("<script>alert('✅ Exam Deleted Successfully');</script>");
                    BindExams();

                }
                else
                {
                    Response.Write("<script>alert('❎ Something Went Wrong Please Try Again');</script>");
                }
            }

        }
    }

}