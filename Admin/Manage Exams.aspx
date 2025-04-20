<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Manage Exams.aspx.cs" Inherits="Online_Exam_System.Admin.Manage_Exams" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Manage Exams
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/manageuser.js"></script> 
       <script type="text/javascript">
       var searchBoxClientID = '<%= SearchBox.ClientID %>';
       </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .custom-btn {
            height: 200px;
            background-color: #040F0F;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 2rem;
            transition: background 0.4s ease-in-out;
            position: relative;
            overflow: hidden;
            color: white;
            font-size: 3rem;
        }

            .custom-btn::before {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(circle at center, rgba(255, 255, 255, 0.2), transparent 70%);
                opacity: 0;
                transition: opacity 0.4s ease-in-out;
                z-index: 0;
            }

            .custom-btn:hover::before {
                opacity: 1;
            }

            .custom-btn i {
                z-index: 1;
            }

            .custom-btn:hover {
                color: black;
            }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-between aling-items-center mb-3">
        <h2 class="mb-0">Manage Exam</h2>
    </div>
    <div class="row g-3 mb-auto">
        <a href="AddExam.aspx" style="text-decoration: none;">
        <div class="btn col mx-auto shadow rounded-5 bg-gradient custom-btn text-center">
            <div><i class="fa-solid fa-square-plus "></i></div>
            <div>
                <h2 class="mt-2 mb-0">Add Exam<p>.xlsx</p></h2>
            </div>
        </div>
            </a>
    </div>
    <div class="row g-3 mb-auto mt-2">
        <div class="col mx-auto">
            <div class="card shadow rounded-4 border-0">
                <div class="card-header d-flex justify-content-between align-items-center bg-white text-black rounded-top-4">
                    <h4 class="mb-0 text-center text-md-start fw-semibold">All Exams</h4>

                    <div class="d-flex align-items-center gap-2">

                        <asp:TextBox ID="SearchBox" AutoPostBack="true" placeholder="Search By Titlr"  OnTextChanged="txtSearch_TextChanged" CssClass="form-control " runat="server"></asp:TextBox>
                        <asp:Button ID="Search" runat="server" CssClass="btn btn-outline-success" OnClick="btnSearch" Text="Search" />
                    </div>
                </div>
                <div class="card-body p-0">
                    <asp:GridView ID="AllExams" runat="server" AutoGenerateColumns="false"
                        CssClass="table table-striped table-hover table-bordered mb-0 table-responsive-md"
                        AllowPaging="true" PageSize="15"
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
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                        OnClick="btnEdit1"
                                        CommandArgument='<%# Eval("ExamID") %>'
                                        CssClass="btn btn-info btn-sm me-2" />

                                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                        OnClick="btnDelete"
                                        CommandArgument='<%# Eval("ExamID") %>'
                                        CssClass="btn btn-danger btn-sm" />
                                </itemtemplate>
                            </asp:TemplateField>
                        </columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>
       <script src="../Scripts/manageuser.js"></script> 
</asp:Content>
