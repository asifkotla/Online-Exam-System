<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="AdminDasboard.aspx.cs" Inherits="Online_Exam_System.Admin.AdminDasboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    DashBoard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .card-box {
            border-radius: 10px;
            color: white;
            padding: 20px;
            min-height: 200px; /* Set this to desired height */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .card-blue {
            background-color: #007bff;
        }

        .card-green {
            background-color: #28a745;
        }

        .card-yellow {
            background-color: #ffc107;
        }

        .btnadd {
            height: 40px;
            width: auto;
        }
    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex justify-content-between aling-items-center mb-3">
        <h2 class="mb-0">Dashboard Overview</h2>
        <button class="  btn btn-primary btnadd  "> <i class="fa-solid fa-plus"></i>Add Exam</button>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card-box card-blue text-center">
                <h6>TOTAL USERS</h6>
                <h1>
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></h1>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-box card-green text-center">
                <h6>ACTIVE EXAMS</h6>
                <h1>
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></h1>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-box card-yellow text-center">
                <h6>Total Enrollment</h6>
                <h1>
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></h1>
            </div>
        </div>
    </div>
    <div class="row g-3 mb-4">
       <div class="col-md-4 mx-auto text-center">
    <div class="card shadow-lg rounded-4 border-0">
        <div class="card-body">
            <h4 class="mb-4 text-primary fw-bold">📊 Exam Results Overview</h4>
            
            <div class="d-flex justify-content-around align-items-center mb-3">
                <div>
                    <asp:Label ID="Label4" runat="server" CssClass="fw-bold fs-5 text-success">0</asp:Label><br />
                    <span class="text-muted">Passed</span>
                </div>

                <div>
                    <asp:Label ID="Label5" runat="server" CssClass="fw-bold fs-5 text-info">0</asp:Label> /
                    <asp:Label ID="Label6" runat="server" CssClass="fw-bold fs-5 text-danger">0</asp:Label><br />
                    <span class="text-muted">Merit & Failed</span>
                </div>
            </div>

            <div style="max-width: 300px; height: 200px; margin: auto;">
                <canvas id="examChart" style="width: 100%; height: 100%;"></canvas>
            </div>

            <asp:Literal ID="litChartScript" runat="server"></asp:Literal>
        </div>
    </div>
</div>


       <div class="col-md-7 mx-auto">
    <div class="card shadow rounded-4 border-0">
        <div class="card-header bg-white text-black rounded-top-4">
    <h4 class="mb-0 text-center text-md-start fw-semibold">Last 10 Registered Students</h4>
</div>
        <div class="card-body p-0">
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="false"
                CssClass="table table-striped table-hover table-bordered mb-0 table-responsive-md"
                AllowPaging="true" PageSize="5"
                OnPageIndexChanging="gvStudents_PageIndexChanging"
                GridLines="None"
                HeaderStyle-CssClass="table-dark text-center"
                RowStyle-CssClass="text-center align-middle">
                <Columns>
                    <asp:BoundField DataField="StudentId" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

    </div>


    <div class="row g-3 mb-4">
               <div class="col-md-8 mx-auto text-center">
    <div class="card shadow-lg rounded-4 border-0">
        <div class="card-body">
            <h4 class="mb-4 text-primary fw-bold">Monthly Student Registration</h4>
            <div style="max-width: 300px; height: 200px; margin: auto;">
                <canvas id="barChart" style="width: 100%; height: 100%;"></canvas>
            </div>

            <asp:Literal ID="litBarChartBar" runat="server"></asp:Literal>
        </div>
    </div>
</div>

               <div class="col-md-4 mx-auto text-center">
    <div class="card shadow-lg rounded-4 border-0">
        <div class="card-body">
            <h4 class="mb-4 text-primary fw-bold">Exam Enrollment Trend </h4>
            
      

            <div style="max-width: 300px; height: 200px; margin: auto;">
                <canvas id="lineChart" style="width: 100%; height: 100%;"></canvas>
            </div>

            <asp:Literal ID="litLineChartLine" runat="server"></asp:Literal>
        </div>
    </div>
</div>

    </div>
    


    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


     💬 Latest Feedback or Complaints
</asp:Content>
