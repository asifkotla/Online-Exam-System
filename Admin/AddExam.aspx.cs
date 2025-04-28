using System;
using System.Web.UI;
using OfficeOpenXml;
using System.Web.UI.WebControls;
using Online_Exam_System.Models;
using Microsoft.Web.Helpers;
using FileUpload = Microsoft.Web.Helpers.FileUpload;
using System.IO;
using ExcelDataReader;

namespace Online_Exam_System.Admin
{
    public partial class UploadExam : Page // 🔴 Ensure this extends Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileExt = Path.GetExtension(FileUpload1.FileName);
                if (fileExt != ".xlsx")
                {
                    Response.Write("<script>alert('❌ Only .xlsx files are allowed.');</script>");
                    return;
                }

                using (var stream = FileUpload1.FileContent)
                {
                    System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
                    using (IExcelDataReader reader = ExcelReaderFactory.CreateReader(stream))
                    {
                        var result = reader.AsDataSet();
                        var table = result.Tables[0];

                        if (table.Rows.Count < 2)
                        {
                            Response.Write("<script>alert('❌ Excel must have exam info and questions.');</script>");
                            return;
                        }

                        try
                        {
                            // 1️⃣ Extract Exam Info
                            string title = table.Rows[1][0].ToString();

                            if (!int.TryParse(table.Rows[1][1].ToString(), out int duration))
                            {
                                Response.Write("<script>alert('❌ Invalid duration format');</script>");
                                return;
                            }

                            string password = table.Rows[1][2].ToString();

                            if (!DateTime.TryParse(table.Rows[1][3].ToString(), out DateTime examDate))
                            {
                                Response.Write("<script>alert('❌ Invalid exam date');</script>");
                                return;
                            }
                            string rawValue = table.Rows[1][4].ToString().Trim();

                            if (!DateTime.TryParse(rawValue, out DateTime dateTime))
                            {
                                Response.Write("<script>alert('❌ Invalid start time');</script>");
                                return;
                            }

                            TimeSpan startTime = dateTime.TimeOfDay;

                            var exam = new Models.Exam
                            {
                                Title = title,
                                Duration = duration,
                                ExamPassword = Utility.HashPassword(password),
                                ExamDate = examDate,
                                StartTime = startTime,
                                CreatedBy = int.Parse(Session["adminId"].ToString())
                            };

                            dbo.Exams.Add(exam);
                            dbo.SaveChanges();
                            int newExamId = exam.ExamID;

                            // 2️⃣ Add Questions
                            for (int i = 2; i < table.Rows.Count; i++)
                            {
                                var qRow = table.Rows[i];

                                if (qRow[5] == null || string.IsNullOrWhiteSpace(qRow[5].ToString()))
                                    continue; // skip empty rows

                                var question = new Question
                                {
                                    ExamID = newExamId,
                                    QuestionText = qRow[5].ToString(),
                                    OptionA = qRow[6].ToString(),
                                    OptionB = qRow[7].ToString(),
                                    OptionC = qRow[8].ToString(),
                                    OptionD = qRow[9].ToString(),
                                    CorrectOption = qRow[10].ToString()
                                };

                                dbo.Questions.Add(question);
                            }

                            if (dbo.SaveChanges() > 0)
                            {
                                Response.Write("<script>alert('✅ Exam and questions uploaded successfully!');</script>");
                            }
                            else
                            {
                                Response.Write("<script>alert('❌ Upload failed. Please try again.');</script>");
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('❌ Error: " + ex.Message.Replace("'", "") + "');</script>");
                        }
                    }
                }
            }
        }

    }
}
