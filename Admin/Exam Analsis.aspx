<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Exam Analsis.aspx.cs" Inherits="Online_Exam_System.Admin.Exam_Analsis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Exam Analysis
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Exam Analysis</h1>
    Metric	Description
✅ Total Enrolled	Students registered for the exam
🧑‍🏫 Total Present	Students who attempted (submitted the exam)
🚫 Total Absent	Enrolled but didn't appear
🟢 Total Passed	Based on score ≥ 75%
🟡 Total Average	Score between 45% - 74%
🔴 Total Failed	Score < 45%
</asp:Content>
