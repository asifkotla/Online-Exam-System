<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="Online_Exam_System.Admin.Results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Results
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Results</h1>
    1️⃣ View All Results (Admin Panel)
Show a list of all completed exams by students.

Grid Columns:

🧑 Student Name

🆔 Exam Title

📅 Date Attempted

✅ Correct Answers

❌ Wrong Answers

📊 Score / Percentage

📄 View Details (Button)

2️⃣ View Result Details (Per Student)
When admin clicks “View Details”, show:

Student Name, Exam Title, Date

Total Questions

Correct / Incorrect Answers

Time Taken

List of questions with:

Question Text

Student's Answer

Correct Answer

✅/❌ icon (for right/wrong)
     Export / Download Result (Optional)
    ✅ Pass – if correct answers ≥ 75%

⚠️ Average – if correct answers are around 50%

❌ Fail – if correct answers < 50%
</asp:Content>
