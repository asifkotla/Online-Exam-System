using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
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
                rblOptions.Items.Add(new ListItem("A) " + q.OptionA, "A"));
                rblOptions.Items.Add(new ListItem("B) " + q.OptionB, "B"));
                rblOptions.Items.Add(new ListItem("C) " + q.OptionC, "C"));
                rblOptions.Items.Add(new ListItem("D) " + q.OptionD, "D"));

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
            // You can add logic to flag it for Review (optional, store in Session or Dictionary)
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
            int notVisited = questionList.Count - answered;
            int notAnswered = questionList.Count(x => !userAnswers.ContainsKey(x.QuestionID));

            lblAnswered.Text = answered.ToString();
            lblNotAnswered.Text = notAnswered.ToString();
            lblNotVisited.Text = notVisited.ToString();
            // lblMarkedReview.Text = ... (if you track marked questions separately)
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

        }

    }
}