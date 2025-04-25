<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Exam Analsis.aspx.cs" Inherits="Online_Exam_System.Admin.Exam_Analsis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Exam Analysis
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
        }
        .card-custom:hover {
            transform: translateY(-5px);
        }
        .icon {
            font-size: 30px;
            margin-right: 10px;
        }
        .green {
            background: linear-gradient(45deg, #28a745, #218838);
            color: white;
        }
        .red {
            background: linear-gradient(45deg, #dc3545, #c82333);
            color: white;
        }
        .yellow {
            background: linear-gradient(45deg, #ffc107, #e0a800);
            color: white;
        }
        .blue {
            background: linear-gradient(45deg, #007bff, #0069d9);
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="d-flex justify-content-between aling-items-center mb-3">
        <h2 class="mb-0">Manage  Analysis</h2>
    </div>

    <div class="row g-3 mb-auto mt-2">
    <div class="col mx-auto">
        <div class="card shadow rounded-4 border-0">
            <div class="card-header d-flex justify-content-between align-items-center bg-white text-black rounded-top-4">
                <h4 class="mb-0 text-center text-md-start fw-semibold">All Exams</h4>

                <div class="d-flex align-items-center gap-2">

                    <asp:TextBox ID="SearchBox" AutoPostBack="true" placeholder="Search By Title"  OnTextChanged="txtSearch_TextChanged" CssClass="form-control " runat="server"></asp:TextBox>
                    <asp:Button ID="Search" runat="server" CssClass="btn btn-outline-success" OnClick="btnSearch" Text="Search" />
                </div>
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="AllExams" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-striped table-hover table-bordered mb-0 table-responsive-md"
                    AllowPaging="true" PageSize="5"
                    AllowSorting="true" OnSorting="AllExam_Sorting"
                    OnPageIndexChanging="AllExam_PageIndexChanging"
                    GridLines="None"
                    HeaderStyle-CssClass="table-dark text-center"
                    RowStyle-CssClass="text-center align-middle">
                    <columns>
                        <asp:BoundField DataField="ExamID" HeaderText="Exam ID" SortExpression="ExamID" />
                        <asp:BoundField DataField="Title" HeaderText="Exam Title" SortExpression="Title" />
                        <asp:BoundField DataField="CreatedBy" HeaderText="Created By" SortExpression="CreatedBy" />
                        <asp:BoundField DataField="Duration" HeaderText="Duration in Min"  />
                          <asp:BoundField DataField="ExamDate" HeaderText=" Exam Date" />
                          <asp:BoundField DataField="StartTime" HeaderText=" Start Time"  />
                        <asp:TemplateField HeaderText="Action">
                            <itemtemplate>
                                <asp:Button ID="btnSelect" runat="server" Text="Select"
                                    OnClick="btnSelect1"
                                    CommandArgument='<%# Eval("ExamID") %>'
                                    CssClass="btn btn-primary btn-sm me-2" />
                                </itemtemplate>
                        </asp:TemplateField>
                    </columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
    <div style="background-color: #f2f6fc;">
   
        <div class="container my-5">
                <div class="d-flex justify-content-between aling-items-center mb-3">
    <h2 class="mb-0">
        <asp:Label ID="title" runat="server" Text="Exam Title"></asp:Label>
    </h2>
</div>
            <div class="row g-4">

                <!-- Total Candidates Enrolled -->
                <div class="col-md-4">
                    <div class="card card-custom green p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-people-fill"></i>
                            <div>
                                <h5 class="mb-0">Total Candidates</h5>
                          
                                <h3><asp:Label runat="server" Text="Label" ID="LTotCand">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Attended Candidates -->
                <div class="col-md-4">
                    <div class="card card-custom blue p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-check-circle-fill"></i>
                            <div>
                                <h5 class="mb-0">Attended Candidates</h5>
                           
                                <h3><asp:Label runat="server" Text="Label" ID="LAttendedCand">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Absent Candidates -->
                <div class="col-md-4">
                    <div class="card card-custom red p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-x-circle-fill"></i>
                            <div>
                                <h5 class="mb-0">Absent Candidates</h5>
                                
                                <h3><asp:Label runat="server" Text="Label" ID="Labsent">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Max Marks -->
                <div class="col-md-4">
                    <div class="card card-custom yellow p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-trophy-fill"></i>
                            <div>
                                <h5 class="mb-0">Maximum Marks</h5>
                                
                                <h3> <asp:Label runat="server" Text="Label" ID="LmaxMarks">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Passing Marks -->
                <div class="col-md-4">
                    <div class="card card-custom green p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-award-fill"></i>
                            <div>
                                <h5 class="mb-0">Passing Marks</h5>
                            
                                <h3> <asp:Label runat="server" Text="Label" ID="LPassingmarks">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Questions -->
                <div class="col-md-4">
                    <div class="card card-custom blue p-4">
                        <div class="d-flex align-items-center">
                            <i class="icon bi bi-list-ol"></i>
                            <div>
                                <h5 class="mb-0">Total Questions</h5>
                            
                                <h3> <asp:Label runat="server" Text="Label" ID="LTotQ">0</asp:Label></h3>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    <div class="row g-3 mb-auto mt-2">
    <div class="col mx-auto">
        <div class="card shadow rounded-4 border-0">
            <div class="card-header d-flex justify-content-between align-items-center bg-white text-black rounded-top-4">
                <h4 class="mb-0 text-center text-md-start fw-semibold">Student Exam Analysis</h4>
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="StudentExamResultGrid" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-striped table-hover table-bordered mb-0 table-responsive-md"
                    AllowPaging="true" PageSize="10"
                    AllowSorting="true"
                    GridLines="None"
                    HeaderStyle-CssClass="table-dark text-center"
                    RowStyle-CssClass="text-center align-middle">
                    <Columns>
                        <asp:BoundField DataField="StudentName" HeaderText="Student Name"  />
                        <asp:BoundField DataField="TotalQuestions" HeaderText="Total Questions"  />
                        <asp:BoundField DataField="TotalCorrect" HeaderText="Total Correct Answers"  />
                        <asp:BoundField DataField="TotalWrong" HeaderText="Total Wrong Answers"  />
                        <asp:TemplateField HeaderText="Result">
                            <ItemTemplate>
                                <asp:Label ID="lblResult" runat="server" Text='<%# Eval("Results") %>' 
                                    CssClass='<%# Eval("Results").ToString() == "Passed" ? "badge bg-success" : 
                                               Eval("Results").ToString() == "Aggregate" ? "badge bg-warning text-dark" : 
                                               "badge bg-danger" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>

    <!-- Bootstrap & Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</div>
   <script src="../Scripts/manageuser.js"></script> 
</asp:Content>
