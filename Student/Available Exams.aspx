<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentDashboard.Master" AutoEventWireup="true" CodeBehind="Available Exams.aspx.cs" Inherits="Online_Exam_System.Student.Available_Exams" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Available Exams
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-iF4xk0N5n+dNfjhNFi5zMI+VV9XrJ6c6sBz6fK+pLhMPJTkK2/FuFV1P1F+CFN7bdl8GZZXrs1gTRFwZlDv+9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        transition: all 0.3s ease-in-out;
    }
    .badge {
        font-size: 0.8rem;
        padding: 0.5em 0.7em;
    }
</style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
    <h2 class="text-center mb-4">📚 Available Exams</h2>
    <div class="row">
        <asp:Repeater ID="rptAvailableExams" runat="server" OnItemCommand="rptAvailableExams_ItemCommand">
            <ItemTemplate>
                <div class="col-md-4 mb-4">
                   <div class="card shadow-sm h-100 border-primary position-relative">
    <!-- Badge at top-right corner -->
    <span class="badge bg-danger position-absolute top-0 end-0 m-3">
        <%# Eval("DaysLeft") %> Days Left
    </span>
                        

                        <div class="card-body">
                            <h5 class="card-title text-primary">
                                <i class="fas fa-file-alt"></i> <%# Eval("Title") %>
                            </h5>
                            <p class="card-text mb-1">
                                <i class="fas fa-hourglass-start"></i> <strong>Duration:</strong> <%# Eval("Duration") %> minutes
                            </p>
                            <p class="card-text mb-1">
                                <i class="fas fa-calendar-alt"></i> <strong>Exam Date:</strong> <%# Eval("ExamDate", "{0:dd MMM yyyy}") %>
                            </p>
                            <p class="card-text mb-1">
<i class="fas fa-clock"></i> <strong>Start Time:</strong> <%# DateTime.Today.Add((TimeSpan)Eval("StartTime")).ToString("hh:mm tt") %>
                            </p>
                           <p class="card-text mb-3">
    <i class="fas fa-user"></i> <strong>Created By:</strong> <%# Eval("CreatedByName") %>
</p>

                            <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now" 
                                CommandName="Enroll" CommandArgument='<%# Eval("ExamID") %>'
                                CssClass="btn btn-outline-primary w-100" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

</asp:Content>
