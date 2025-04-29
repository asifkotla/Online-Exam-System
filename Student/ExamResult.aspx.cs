using iTextSharp.text.pdf;
using iTextSharp.text;
using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.IO;
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
                string[] args = e.CommandArgument.ToString().Split('|');
                int examId = int.Parse(args[0]);
                // Set examId in Session to use in GeneratePDF()
                Session["ExamID"] = examId;
                GeneratePDF();

            }
            else
            {

                Response.Write("<script>alert('❎ Something Went Wrong while Generating Your PDF Please Try Again');</script>");
            }
        }
        private void GeneratePDF()
        {
            int userId = Convert.ToInt32(Session["StdId"]);
            int examId = Convert.ToInt32(Session["ExamID"]);
            var student = dbo.Students.FirstOrDefault(s => s.StudentID == userId);
            var exam = dbo.Exams.FirstOrDefault(e => e.ExamID == examId);

            // File name generation
            string fileName = $"{student.FullName.Replace(" ", "_")}_Result.pdf";
            string directoryPath = Server.MapPath("~/Results/");

            // Ensure directory exists
            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }

            string filePath = Path.Combine(directoryPath, fileName);

            using (FileStream fs = new FileStream(filePath, FileMode.Create))
            {
                Document doc = new Document(PageSize.A4, 36f, 36f, 180f, 36f); // header space
                PdfWriter writer = PdfWriter.GetInstance(doc, fs);

                // Add header
                writer.PageEvent = new PDFHeaderFooter(exam.Title);

                doc.Open();

                // Student Details
                doc.Add(new Paragraph($"Student Name: {student.FullName}", FontFactory.GetFont("Arial", 12)));
                doc.Add(new Paragraph($"Email: {student.Email}", FontFactory.GetFont("Arial", 12)));
                doc.Add(new Paragraph($"Date: {DateTime.Now:dd MMMM yyyy hh:mm tt}", FontFactory.GetFont("Arial", 12)));
                doc.Add(new Chunk("\n"));

                // Table setup
                PdfPTable table = new PdfPTable(4);
                table.WidthPercentage = 100;
                table.SetWidths(new float[] { 10, 50, 20, 20 });

                // Table Header
                Font headerFont = FontFactory.GetFont("Arial", 12, Font.BOLD);
                table.AddCell(new PdfPCell(new Phrase("No", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Question", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Your Answer", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Correct Answer", headerFont)));

                int counter = 1;
                var studentresult=dbo.GetStudentExamAnswers(userId,examId).ToList();

                foreach (var item in studentresult)
                {
                    

                    table.AddCell(counter.ToString());
                    table.AddCell(item.QuestionText);
                    table.AddCell(item.SelectedOptionText);
                    table.AddCell(item.CorrectOptionText);
                    counter++;
                }
               
                doc.Add(table);
                doc.Add(new Chunk("\n"));
                 var counts =dbo.GetStudentExamStats(userId,examId).FirstOrDefault();   
                // Summary
                Font summaryFont = FontFactory.GetFont("Arial", 12, Font.BOLD);
                doc.Add(new Paragraph($"Total Questions: {counts.TotalQuestions}", summaryFont));
                doc.Add(new Paragraph($"Attempted: {counts.Attempted}", summaryFont));
                doc.Add(new Paragraph($"Correct Answers: {counts.Correct}", summaryFont));
                doc.Add(new Paragraph($"Wrong Answers: {counts.Wrong}", summaryFont));

                doc.Close();
            }

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}");
            Response.TransmitFile(filePath);
            Response.End();
        }

    }
}