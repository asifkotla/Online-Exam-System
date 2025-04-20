<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadExam.aspx.cs" Inherits="Online_Exam_System.Admin.UploadExam" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(to right, #6dd5ed, #2193b0);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            margin-top: 100px;
            border-radius: 20px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.2);
        }
        .form-label {
            font-weight: 600;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border-radius: 30px;
        }
        .btn-cust{
            border-radius: 30px;

        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container d-flex justify-content-center">
            <div class="card p-4 col-md-6 bg-light">
                <h3 class="text-center mb-4 text-primary"><i class="fa-solid fa-upload"></i> Upload Exam Excel</h3>

                <div class="mb-3">
                    <label for="FileUpload1" class="form-label"><i class="fa-solid fa-table"></i> Select Excel File</label>
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                </div>

               <div class="text-center mt-3 row">
    <div class="col">
        <asp:Button ID="btnUpload" runat="server" Text="Upload Exam" CssClass="btn btn-custom px-4 w-100" OnClick="btnUpload_Click" />
    </div>
    <div class="col">
        <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-cust btn-danger px-4 w-100" OnClientClick="window.location.href='Manage Exams.aspx'; return false;" />
    </div>
</div>
            </div>
        </div>
    </form>
</body>
</html>
