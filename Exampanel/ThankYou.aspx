<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThankYou.aspx.cs" Inherits="Online_Exam_System.Exampanel.ThankYou" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <title>Thank You</title>
    <style>
        body { font-family: Arial; padding: 50px; text-align: center; }
        .box { padding: 30px; border: 1px solid #ccc; display: inline-block; background-color: #f9f9f9; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <h2>Thank you for completing the exam!</h2>
            <p>Your responses have been recorded.</p>
            <asp:HyperLink ID="lnkDownloadPDF" runat="server" Target="_blank" Text="Download Result PDF" />
            <br /><br />
            <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger" Text="Logout" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
