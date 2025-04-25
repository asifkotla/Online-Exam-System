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
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {
          int cntUser=dbo.Students.Count(); 
           Label1.Text = cntUser.ToString();
            int cntExam=dbo.Exams.Count();
            Label2.Text = cntExam.ToString();
            int cntenrollment = dbo.StudentExamEnrollments.Count();
            Label3.Text = cntenrollment.ToString();

            if (!IsPostBack)
            {
                BarChart();
                LineChart();
                BindStudents();
                RoundChart();
                BindFeedBack();


            }
        }
        private void BindStudents()
        {
            var students = dbo.Students
                     .OrderByDescending(s => s.StudentID)  // Assuming StudentId is identity/auto-increment
                     .Take(10)
                     .ToList();
            gvStudents.DataSource = students;
            gvStudents.DataBind();
        }
        protected void gvStudents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStudents.PageIndex = e.NewPageIndex;
            BindStudents(); // Rebind data
        }
        protected void gvStudents_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            gvStudents.PageIndex = e.NewPageIndex;
            BindFeedBack(); // Rebind data
        }
        private void LineChart()
        {
            var enrollmentData = dbo.StudentExamEnrollments
            .GroupBy(e => new { e.EnrollmentDate.Value.Year, e.EnrollmentDate.Value.Month })
            .Select(g => new {
                Month = g.Key.Month,
                Year = g.Key.Year,
                Count = g.Count()
            })
            .OrderBy(x => x.Year).ThenBy(x => x.Month)
            .ToList();

            var labels = string.Join(",", enrollmentData.Select(d => $"'{System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(d.Month)}'"));
            var values = string.Join(",", enrollmentData.Select(d => d.Count));

            litLineChartLine.Text = $@"
        <script>
        var ctx = document.getElementById('lineChart').getContext('2d');
        var lineChart = new Chart(ctx, {{
            type: 'line',
            data: {{
                labels: [{labels}],
                datasets: [{{
                    label: 'Exam Enrollment Trend',
                    data: [{values}],
                    borderColor: '#28a745',
                    backgroundColor: 'rgba(40, 167, 69, 0.2)',
                    fill: true,
                    tension: 0.3
                }}]
            }},
            options: {{
                responsive: true,
                scales: {{
                    y: {{
                        beginAtZero: true
                    }}
                }}
            }}
        }});
        </script>";
        }
        private void BarChart()
        {
            var studentData = dbo.Students
            .GroupBy(s => new { s.RegisterDate.Year, s.RegisterDate.Month })
            .Select(g => new {
                Month = g.Key.Month,
                Year = g.Key.Year,
                Count = g.Count()
            })
            .OrderBy(x => x.Year).ThenBy(x => x.Month)
            .ToList();

            var labels = string.Join(",", studentData.Select(d => $"'{System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(d.Month)}'"));
            var values = string.Join(",", studentData.Select(d => d.Count));

            litBarChartBar.Text = $@"
        <script>
        var ctx = document.getElementById('barChart').getContext('2d');
        var barChart = new Chart(ctx, {{
            type: 'bar',
            data: {{
                labels: [{labels}],
                datasets: [{{
                    label: 'Monthly Student Registrations',
                    data: [{values}],
                    backgroundColor: '#0d6efd'
                }}]
            }},
            options: {{
                responsive: true,
                scales: {{
                    y: {{
                        beginAtZero: true
                    }}
                }}
            }}
        }});
        </script>";
        }
        private void RoundChart()
        {
            int merit = 76;
            int passed = 68;
            int failed = 15;

            // Injecting the Chart.js script with dynamic values
            string script = $@"
                              <script>
                              var ctx = document.getElementById('examChart').getContext('2d');
                              var examChart = new Chart(ctx, {{
                              type: 'doughnut',
                              data: {{
                              labels: ['Merit', 'Passed', 'Failed'],
                              datasets: [{{
                              data: [{merit}, {passed}, {failed}],
                              backgroundColor: ['#0d6efd', '#28a745', '#dc3545']
                                         }}]
                                     }},
                              options: {{
                              responsive: true,
                              maintainAspectRatio: false,
                              plugins: {{
                              legend: {{
                              position: 'bottom'
                                      }}
                                    }}
                                  }}
                               }});
                  </script>";

            // Assign to Literal control
            litChartScript.Text = script;
           

        }
        private void BindFeedBack()
        {
            var feedback = dbo.Feedbacks.OrderByDescending(x=>x.Date).ToList();
            FeedBack.DataSource = feedback;
            FeedBack.DataBind();
        }
        protected void btnReply_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string email = btn.CommandArgument;
            Session["ReplyEmail"] = email;
            Response.Redirect("~/Reply.aspx");
        }
    }
}           


