<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="AdminDasboard.aspx.cs" Inherits="Online_Exam_System.Admin.AdminDasboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    DashBoard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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

    .card-blue { background-color: #007bff; }
    .card-green { background-color: #28a745; }
    .card-yellow { background-color: #ffc107; }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Dashboard Overview</h2>
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
          <h6>PENDING RESULTS</h6>
          <h1>5</h1>
        </div>
      </div>
    </div>

 


</asp:Content>
