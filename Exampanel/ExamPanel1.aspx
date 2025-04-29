<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamPanel1.aspx.cs" Inherits="Online_Exam_System.Exampanel.ExamPanel1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Online Exam Panel</title>
    <script src="Exampanel/examPapplication.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Highlight selected question
            $(".question-btn").click(function () {
                $(".question-btn").removeClass("btn-primary");
                $(this).addClass("btn-primary");
            });

            // Optional: Tooltips to explain meaning
            $(".question-btn").each(function () {
                const btn = $(this);
                if (btn.hasClass("btn-success")) {
                    btn.attr("title", "Answered");
                } else if (btn.hasClass("btn-warning")) {
                    btn.attr("title", "Marked for Review");
                } else {
                    btn.attr("title", "Not Visited");
                }
            });

            // Initialize Bootstrap tooltips (if you're using Bootstrap)
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .question-btn {
            width: 40px;
            height: 40px;
            margin: 5px;
            border-radius: 50%;
        }

        .selected-option {
            background-color: #d1e7dd !important;
        }

        .timer {
            font-weight: bold;
            font-size: 1.2rem;
            color: red;
        }

        .option-card:hover {
            cursor: pointer;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body style="overflow: hidden;">
    <form id="form2" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img id="logo" class="img-fluid " src="/assets/Owl%20of%20Wisdom.png" alt="LOGO" style="width: 45px; height: auto; border-radius: 50%; margin-right: 12px;" />
                    <h3>QuizNest</h3>
                </a>

                <div class="d-flex align-items-center">

                    <asp:ScriptManager ID="ScriptManager1" runat="server" />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="bagde bg-success rounded p-1"> Time Left</asp:Label>
                            <asp:Label ID="lblTimer" runat="server" CssClass="timer me-3"></asp:Label>
                            <asp:Timer ID="ExamTimer" runat="server" Interval="1000" OnTick="ExamTimer_Tick"></asp:Timer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <img id="imgProfile" runat="server" src="../assets/profile.png" alt="Profile" width="40" height="40" class="rounded-circle"
                        onerror="this.onerror=null; this.src='../assets/default-profile1.png';" />
                    <asp:Label ID="lblUserName" runat="server" Text="Label" CssClass="text-white ms-2"></asp:Label>
                </div>
            </div>
        </nav>

        <!-- Second Header -->
        <div class="bg-light p-3 text-center">
            <h4>
                <asp:Label ID="lblExamTitle" runat="server" Text="Exam Title Here"></asp:Label></h4>
        </div>

        <!-- Main Area -->
        <div class="container-fluid mt-3">
            <div class="row">

                <!-- Left Panel (Questions) -->
                <div class="col-md-8">
                    <asp:Label ID="lblQuestionNo" runat="server" CssClass="fw-bold mb-2 d-block"></asp:Label>
                    <asp:Label ID="lblQuestionText" runat="server" CssClass="h5"></asp:Label>

                    <div class="mt-4">

                        <!-- RadioButtonList -->
                        <asp:RadioButtonList ID="rblOptions" runat="server">
                            <asp:ListItem Text="Option A" Value="A"></asp:ListItem>
                            <asp:ListItem Text="Option B" Value="B"></asp:ListItem>
                            <asp:ListItem Text="Option C" Value="C"></asp:ListItem>
                            <asp:ListItem Text="Option D" Value="D"></asp:ListItem>
                        </asp:RadioButtonList>

                    </div>

                </div>

                <!-- Right Panel (Status + Questions List) -->
                <div class="col-md-4">
                    <div class="mb-3">
                        <span class="badge bg-success mb-2 d-block">Answered:
                            <asp:Label ID="lblAnswered" runat="server" Text="0"></asp:Label></span>
                        <span class="badge bg-danger mb-2 d-block">Not Answered:
                            <asp:Label ID="lblNotAnswered" runat="server" Text="0"></asp:Label></span>
                        <span class="badge bg-warning mb-2 d-block">Not Visited:
                            <asp:Label ID="lblNotVisited" runat="server" Text="0"></asp:Label></span>
                        <span class="badge bg-primary mb-2 d-block">Marked for Review:
                            <asp:Label ID="lblMarkedReview" runat="server" Text="0"></asp:Label></span>
                    </div>
                    <!-- Repeater with Buttons (inside the form) -->

                <div class="card p-2" style="height: 400px; overflow-y: scroll;">
    <div class="d-flex flex-wrap gap-2">
        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <asp:Button ID="btnQuestion" runat="server"
                    CssClass="btn btn-outline-primary question-btn"
                    Text='<%# Eval("QuestionNo") %>'
                    CommandArgument='<%# Eval("QuestionID") %>'
                    OnClick="btnQuestion_Click" />
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
                </div>

            </div>
        </div>


        <!-- Footer Buttons -->
        <div class="bg-light text-center p-3 fixed-bottom">
            <asp:Button ID="btnMarkReview" runat="server" Text="Mark for Review" CssClass="btn btn-warning me-2" OnClick="btnMarkReview_Click" />
            <asp:Button ID="btnClearResponse" runat="server" Text="Clear Response" CssClass="btn btn-secondary me-2" OnClick="btnClearResponse_Click" />
            <asp:Button ID="btnSaveNext" runat="server" Text="Save and Next" CssClass="btn btn-success me-2" OnClick="btnSaveNext_Click" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-danger" OnClick="btnSubmit_Click" />
        </div>

        <!-- ASP.NET Timer for Countdown -->



        <!-- Bootstrap Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    </form>
</body>
</html>
