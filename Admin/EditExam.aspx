<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditExam.aspx.cs" Inherits="Online_Exam_System.Admin.EditExam" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card shadow-lg p-4 rounded">
                <h3 class="text-center text-primary mb-4">Edit Exam</h3>

                <div class="mb-3">
                    <label for="txtTitle" class="form-label">Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label for="ddlCreatedBy" class="form-label">Created By</label>
                         <asp:TextBox ID="txtCreatedBy" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>

                <div class="mb-3">
                    <label for="txtDuration" class="form-label">Duration (in minutes)</label>
                    <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" TextMode="Number" />
                </div>

                <div class="mb-3">
                    <label for="txtDate" class="form-label">Exam Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>

                <div class="mb-3">
                    <label for="txtTime" class="form-label">Start Time</label>
                    <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time" />
                </div>

                <div class="text-center">
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success px-5" Text="Update Exam" OnClick="btnUpdate_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
