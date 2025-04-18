<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reply.aspx.cs" Inherits="Online_Exam_System.Reply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Send Email Reply</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Reply to Feedback</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>
                    <div class="mb-3">
                        <label>Subject</label>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />
                    </div>
                    <asp:Button ID="btnSend" runat="server" Text="Send Email" CssClass="btn btn-success" OnClick="btnSend_Click" />
                </div>
            </div>
        </div>
    </form> 
</body>
</html>
