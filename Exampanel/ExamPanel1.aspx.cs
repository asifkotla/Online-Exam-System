using iTextSharp.text.pdf;
using iTextSharp.text;
using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Exampanel
{
    public partial class ExamPanel1 : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 db = new OnlineeExamSystemEntities2(); // Your EF Context

        static List<Question> questionList;
        static Dictionary<int, string> userAnswers = new Dictionary<int, string>(); // QuestionID -> Selected Option
        static int currentQuestionIndex = 0;
        static DateTime examEndTime;
        static List<int> markedForReview = new List<int>();

        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Session["stdEmailid"].ToString();
            var stduser = db.Students.Where(x => x.Email == email).FirstOrDefault();
            lblUserName.Text = stduser.FullName;
            if (!IsPostBack)
            {
                var user = db.Students.Where(x => x.Email == email).FirstOrDefault();
                var profileImagePath = Utility.ConvertByteArrayToImage(user.ProfileImage);
                if (stduser.ProfileImage != null && stduser.ProfileImage.Length > 0)
                {
                    string base64String = Convert.ToBase64String(stduser.ProfileImage);
                    imgProfile.Src = "data:image/png;base64," + base64String;
                }
                else
                {
                    imgProfile.Src = "../assets/default-profile1.png"; // fallback
                } 

                int examId = Convert.ToInt32(Session["ExamID"]);
                int userId = Convert.ToInt32(Session["UserID"]);
              // lblUserName.Text = Session["UserName"].ToString();

                questionList = db.Questions.Where(q => q.ExamID == examId).ToList();

                rptQuestions.DataSource = questionList.Select((q, index) => new { QuestionNo = index + 1, QuestionID = q.QuestionID }).ToList();
                rptQuestions.DataBind();

                examEndTime = DateTime.Now.AddMinutes(30); // Set 30 min exam timer
                Session["ExamEndTime"] = examEndTime;

                LoadQuestion();
            }

            UpdateTimer();
        }

        private void UpdateTimer()
        {
            if (Session["ExamEndTime"] != null)
            {
                DateTime endTime = (DateTime)Session["ExamEndTime"];
                TimeSpan remaining = endTime - DateTime.Now;

                if (remaining.TotalSeconds <= 0)
                {
                    SubmitExam();
                }
                else
                {
                    lblTimer.Text = remaining.Minutes.ToString("00") + ":" + remaining.Seconds.ToString("00");
                }
            }
        }

        private void LoadQuestion()
        {
            if (questionList != null && questionList.Count > 0)
            {
                var q = questionList[currentQuestionIndex];
                lblExamTitle.Text = db.Exams.Where(x => x.ExamID == q.ExamID).Select(x => x.Title).FirstOrDefault();
                lblQuestionNo.Text = "Question " + (currentQuestionIndex + 1);
                lblQuestionText.Text = q.QuestionText;

                rblOptions.Items.Clear();
                rblOptions.Items.Add(new System.Web.UI.WebControls.ListItem("A) " + q.OptionA, "A"));
                rblOptions.Items.Add(new System.Web.UI.WebControls.ListItem("B) " + q.OptionB, "B"));
                rblOptions.Items.Add(new System.Web.UI.WebControls.ListItem("C) " + q.OptionC, "C"));
                rblOptions.Items.Add(new System.Web.UI.WebControls.ListItem("D) " + q.OptionD, "D"));


                // Highlight previously selected option
                if (userAnswers.ContainsKey(q.QuestionID))
                {
                    rblOptions.SelectedValue = userAnswers[q.QuestionID];
                }
            }
        }
        protected void ExamTimer_Tick(object sender, EventArgs e)
        {
            UpdateTimer();
        }

        protected void btnSaveNext_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();
            if (currentQuestionIndex < questionList.Count - 1)
            {
                currentQuestionIndex++;
                LoadQuestion();
            }
            UpdateBadges();
        }

        protected void btnMarkReview_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();

            var q = questionList[currentQuestionIndex];
            if (!markedForReview.Contains(q.QuestionID))
            {
                markedForReview.Add(q.QuestionID);
            }

            if (currentQuestionIndex < questionList.Count - 1)
            {
                currentQuestionIndex++;
                LoadQuestion();
            }
            UpdateBadges();
        }

        protected void btnClearResponse_Click(object sender, EventArgs e)
        {
            var q = questionList[currentQuestionIndex];

            if (userAnswers.ContainsKey(q.QuestionID))
                userAnswers.Remove(q.QuestionID);

            if (markedForReview.Contains(q.QuestionID))
                markedForReview.Remove(q.QuestionID);

            rblOptions.ClearSelection();
            UpdateBadges();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();
            SubmitExam();
        }

        private void SaveCurrentAnswer()
        {
            if (rblOptions.SelectedIndex != -1)
            {
                var q = questionList[currentQuestionIndex];
                userAnswers[q.QuestionID] = rblOptions.SelectedValue;
            }
        }

        protected void btnQuestion_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int qId = Convert.ToInt32(btn.CommandArgument);

            currentQuestionIndex = questionList.FindIndex(x => x.QuestionID == qId);
            LoadQuestion();
        }
        private void UpdateBadges()
        {
            int answered = userAnswers.Count;
            int marked = markedForReview.Count;
            int notAnswered = questionList.Count(q => !userAnswers.ContainsKey(q.QuestionID));
            int notVisited = questionList.Count - answered - marked;

            lblAnswered.Text = answered.ToString();
            lblNotAnswered.Text = notAnswered.ToString();
            lblNotVisited.Text = notVisited.ToString();
            lblMarkedReview.Text = marked.ToString(); // Assuming you have this label
        }

        private void SubmitExam()
        {
            int examId = Convert.ToInt32(Session["ExamID"]);
            int userId = Convert.ToInt32(Session["UserID"]);

            foreach (var ans in userAnswers)
            {
                var correctOption = db.Questions.Where(x => x.QuestionID == ans.Key).Select(x => x.CorrectOption).FirstOrDefault();

                bool isCorrect = correctOption == ans.Value;

                StudentAnswer ua = new StudentAnswer
                {
                    Studentid = userId,
                    ExamID = examId,
                    QuestionID = ans.Key,
                    SelectedOption = ans.Value,
                    
                    CreatedOn = DateTime.Now
                };
                db.StudentAnswers.Add(ua);
            }

            db.SaveChanges();

            // Generate PDF and Download
            GeneratePDF();

            Response.Redirect("ThankYou.aspx"); // Or wherever you want after exam submit
        }
        private void GeneratePDF()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int examId = Convert.ToInt32(Session["ExamID"]);
            var student = db.Students.FirstOrDefault(s => s.StudentID == userId);
            var exam = db.Exams.FirstOrDefault(e => e.ExamID == examId);

            // File name generation
            string fileName = $"{student.FullName.Replace(" ", "_")}_{exam.Title}_Result.pdf";
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

                int counter = 1, correct = 0, wrong = 0;

                foreach (var q in questionList)
                {
                    string selected = userAnswers.ContainsKey(q.QuestionID) ? userAnswers[q.QuestionID] : "Not Answered";
                    string correctAns = q.CorrectOption;
                    bool isCorrect = selected == correctAns;

                    if (selected != "Not Answered")
                    {
                        if (isCorrect) correct++;
                        else wrong++;
                    }

                    table.AddCell(counter.ToString());
                    table.AddCell(q.QuestionText);
                    table.AddCell(selected);
                    table.AddCell(correctAns);
                    counter++;
                }

                doc.Add(table);
                doc.Add(new Chunk("\n"));

                // Summary
                Font summaryFont = FontFactory.GetFont("Arial", 12, Font.BOLD);
                doc.Add(new Paragraph($"Total Questions: {questionList.Count}", summaryFont));
                doc.Add(new Paragraph($"Attempted: {userAnswers.Count}", summaryFont));
                doc.Add(new Paragraph($"Correct Answers: {correct}", summaryFont));
                doc.Add(new Paragraph($"Wrong Answers: {wrong}", summaryFont));

                doc.Close();
            }

            // Save the path in session
            Session["ResultPDFPath"] = "~/Results/" + fileName;
        }

    }
}