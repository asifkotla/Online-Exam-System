<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentDashboard.Master" AutoEventWireup="true" CodeBehind="ExamResult.aspx.cs" Inherits="Online_Exam_System.Student.ExamResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Exam Result
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Exams</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <style>
        .card { border-radius: 10px; margin-bottom: 20px; }
        .card-body { background-color: #f9f9f9; }
        .card-title { font-size: 1.25rem; font-weight: bold; }
        .btn-outline-primary { color: #007bff; border-color: #007bff; }
        .btn-outline-primary:disabled { color: #6c757d; border-color: #6c757d; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="container mt-5">
    <h2 class="mb-4">My Exams</h2>
    <asp:Repeater ID="rptExamResults" runat="server">
        <ItemTemplate>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="card-title"><i class="fas fa-book"></i> <%# Eval("Title") %></h5>
                    <p><strong>Status:</strong> <%# Eval("Status") %></p>
                    <p><strong>Enrollment Date:</strong> <%# Eval("EnrollmentDate", "{0:dd MMM yyyy}") %></p>
                    <asp:Button ID="btnDownloadPDF" runat="server" Text="Download PDF" 
                                CommandName="DownloadPDF" CommandArgument='<%# Eval("ExamID") %>' 
                                CssClass="btn btn-outline-primary" 
                                Enabled='<%# Eval("IsExamCompleted") != null && (bool)Eval("IsExamCompleted") %>' />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>
