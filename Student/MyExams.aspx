<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentDashboard.Master" AutoEventWireup="true" CodeBehind="MyExams.aspx.cs" Inherits="Online_Exam_System.Student.MyExams" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server"> MyExams
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-iF4xk0N5n+dNfjhNFi5zMI+VV9XrJ6c6sBz6fK+pLhMPJTkK2/FuFV1P1F+CFN7bdl8GZZXrs1gTRFwZlDv+9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
    /* Ensure cards have consistent styling */
    .card {
        transition: transform 0.3s ease-in-out;
    }
    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Styling for the "Start Exam" button */
    .btn-success {
        background-color: #28a745;
        border-color: #28a745;
    }
    .btn-success:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }

    /* Add some spacing between cards on smaller screens */
    .card-body {
        padding: 20px;
    }

    /* Ensure the cards are not too wide */
    @media (max-width: 576px) {
        .card {
            max-width: 100%;
        }
    }
</style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Enrolled Exams Section -->
<div class="container mt-5">
    <h2 class="text-center mb-4">Your Enrolled Exams</h2>
    <div class="row">
        <asp:Repeater ID="rptEnrolledExams" runat="server">
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 mb-4">
                    <!-- Card Design -->
                    <div class="card shadow-lg border-primary h-100">
                        <div class="card-body">
                            <!-- Exam Title -->
                            <h5 class="card-title text-primary">
                                <i class="fas fa-file-alt"></i> <%# Eval("Title") %>
                            </h5>

                            <!-- Exam Duration -->
                            <p class="card-text mb-1">
                                <i class="fas fa-hourglass-start"></i> <strong>Duration:</strong> <%# Eval("Duration") %> minutes
                            </p>
                            <!-- Exam Date -->
                            <p class="card-text mb-1">
                                <i class="fas fa-calendar-alt"></i> <strong>Exam Date:</strong> <%# Eval("ExamDate", "{0:dd MMM yyyy}") %>
                            </p>
                            <!-- Exam Start Time -->
                            <p class="card-text mb-1">
                                <i class="fas fa-clock"></i> <strong>Start Time:</strong> <%# DateTime.Today.Add((TimeSpan)Eval("StartTime")).ToString("hh:mm tt") %>
                            </p>
                            <!-- Enroll Date -->
                            <p class="card-text mb-3">
                                <i class="fas fa-user"></i> <strong>Enrolled On:</strong> <%# Eval("EnrollmentDate", "{0:dd MMM yyyy}") %>
                            </p>
                            
                            <!-- Start Exam Button -->
                           <asp:Button ID="btnStartExam" runat="server" OnClick="btnStartExam_Click" Text="Start Exam" CommandName="StartExam" CommandArgument='<%# Eval("ExamID") %>' CssClass="btn btn-success w-100" OnClientClick="return confirm('Are you sure you want to start the exam?')" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

</asp:Content>
