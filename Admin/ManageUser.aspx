<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="ManageUser.aspx.cs" Inherits="Online_Exam_System.Admin.ManageUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Manage User
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />

    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript">
        var searchBoxClientID = '<%= SearchBox.ClientID %>';
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="myCustomLoader" style="display: none; position: fixed; z-index: 9999; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(255,255,255,0.6);">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%);">
            <img src="../assets/Infinite Loader.gif" alt="Loading..." style="width: 80px; height: 80px;" />
        </div>
    </div>


    <div class="d-flex justify-content-between aling-items-center mb-3">
        <h2 class="mb-0">Manage User </h2>
        <asp:Button ID="btnExportPdf" runat="server" Text="Export to PDF"
    CssClass="btn btn-success mb-3" OnClick="btnExportPdf_Click" />
    </div>
    <div class="row g-3 mb-auto">
        <div class="col mx-auto">
            <div class="card shadow rounded-4 border-0">
               <div class="card-header d-flex justify-content-between align-items-center bg-white text-black rounded-top-4">
    <h4 class="mb-0 text-center text-md-start fw-semibold">Last 10 Registered Students</h4>

    <div class="d-flex align-items-center gap-2">
      
        <asp:TextBox ID="SearchBox" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"  placeholder="Search By Name" CssClass="form-control " runat="server"></asp:TextBox>
        <asp:Button ID="Search" runat="server" CssClass="btn btn-outline-success" OnClick="btnSearch"   Text="Search" />
    </div>
</div>
                <div class="card-body p-0">
                    <asp:GridView ID="gvallStudents" runat="server" AutoGenerateColumns="false"
                        CssClass="table table-striped table-hover table-bordered mb-0 table-responsive-md"
                        AllowPaging="true" PageSize="20"
                        AllowSorting="true" OnSorting="gvStudents_Sorting"
                        OnPageIndexChanging="gvStudents_PageIndexChanging"
                        GridLines="None"
                        HeaderStyle-CssClass="table-dark text-center"
                        RowStyle-CssClass="text-center align-middle">
                        <Columns>
                            <asp:BoundField DataField="StudentId" HeaderText="ID" SortExpression="StudentId" />
                            <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName"/>
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName"/>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                        OnClick="btnDelete_Click"
                                        
                                        CommandArgument='<%# Eval("StudentId") %>'
                                        CssClass="btn btn-danger btn-sm" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

     <script src="../Scripts/manageuser.js"></script> 
</asp:Content>
