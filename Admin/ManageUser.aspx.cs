using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using iText.Kernel.Colors;
using System.IO;
using iText.IO.Font.Constants;
using iText.Kernel.Font;

using iText.IO.Font;



namespace Online_Exam_System.Admin
{
    public partial class ManageUser : System.Web.UI.Page
    {
        private DataTable AllUsers;

        OnlineeExamSystemEntities1 dbo = new OnlineeExamSystemEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AllUsers = GetUserList(); // load all users
                ViewState["Users"] = AllUsers; // store in ViewState
                BindUsers(AllUsers);
                BindAllStudent();
            }

        }
        private void BindUsers(DataTable dt) 
        {
            gvallStudents.DataSource = dt;
            gvallStudents.DataBind();
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string searchTerm = SearchBox.Text.Trim().ToLower();
            DataTable dt = ViewState["Users"] as DataTable;

            if (dt != null)
            {
                var filteredRows = dt.AsEnumerable()
                    .OrderByDescending(r => r["FullName"].ToString().ToLower().StartsWith(searchTerm))
                    .ThenBy(r => r["FullName"].ToString());

                if (filteredRows.Any())
                    BindUsers(filteredRows.CopyToDataTable());
                else
                    BindUsers(dt.Clone()); // Show empty result with same structure
            }
        }
        private string SortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void gvStudents_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = ViewState["Users"] as DataTable;
            if (dt != null)
            {
                dt.DefaultView.Sort = e.SortExpression + " " + SortDirection;
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
                BindUsers(dt.DefaultView.ToTable());
            }
        }
        private DataTable GetUserList()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("StudentId");
            dt.Columns.Add("FullName");
            dt.Columns.Add("Email");
            dt.Columns.Add("UserName");


            using (OnlineeExamSystemEntities1 db = new OnlineeExamSystemEntities1())
            {
                var users = db.Students.ToList(); // or db.Users if you're storing in Users table

                foreach (var user in users)
                {
                    dt.Rows.Add(user.StudentID, user.FullName, user.Email,user.UserName);
                }
            }

            return dt;

        }
        private void BindAllStudent()
        {
            var students = dbo.Students.ToList();
            gvallStudents.DataSource = students;
            gvallStudents.DataBind();
        }
        protected void gvStudents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvallStudents.PageIndex = e.NewPageIndex;
            BindAllStudent(); // Rebind data
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int id = int.Parse(btn.CommandArgument);
            var delStudent = dbo.Students.FirstOrDefault(x => x.StudentID == id);
            if (delStudent == null)
            {
                Response.Write("<script>alert('❎ User Not Found');</script>");
            }
            else
            {
              dbo.Students.Remove(delStudent);
                if(dbo.SaveChanges()>0)
                {
                    Response.Write("<script>alert('✅ User Deleted Successfully');</script>");
                    BindAllStudent();
                    
                }
                else
                {
                    Response.Write("<script>alert('❎ Something Went Wrong Please Try Again');</script>");
                }
            }
        }
        protected void btnSearch(object sender, EventArgs e)
        {
            txtSearch_TextChanged(sender, e);
        }
        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            DataTable dt = ViewState["Users"] as DataTable;
            if (dt == null || dt.Rows.Count == 0)
                return;

            using (MemoryStream ms = new MemoryStream())
            {
               

                PdfWriter writer = new PdfWriter(ms); // ✔ No smart mode used
                PdfDocument pdf = new PdfDocument(writer);
                Document doc = new Document(pdf);
                PdfFont boldFont = PdfFontFactory.CreateFont(StandardFonts.HELVETICA_BOLD);
                // Heading
                Paragraph heading = new Paragraph("All Students List")
       .SetTextAlignment(TextAlignment.CENTER)
       .SetFontSize(16)
       .SetFont(boldFont)
       .SetMarginBottom(20);
                doc.Add(heading);

                // Table
                iText.Layout.Element.Table table = new iText.Layout.Element.Table(dt.Columns.Count).UseAllAvailableWidth();

                // Add headers
                foreach (DataColumn col in dt.Columns)
                {
                    Cell headerCell = new Cell()
                        .Add(new Paragraph(col.ColumnName).SetFont(boldFont))
                        .SetBackgroundColor(ColorConstants.LIGHT_GRAY);
                    table.AddHeaderCell(headerCell);
                }

                // Add rows
                foreach (DataRow row in dt.Rows)
                {
                    foreach (var cellData in row.ItemArray)
                    {
                        table.AddCell(new Cell().Add(new Paragraph(cellData.ToString())));
                    }
                }

                doc.Add(table);
                doc.Close();

                byte[] bytes = ms.ToArray();

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=StudentsList.pdf");
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }

    }
}