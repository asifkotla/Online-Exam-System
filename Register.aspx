<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Online_Exam_System.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <script href="Content/register.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            width: 100vw;
            overflow: hidden auto;
            font-family: "Poppins", sans-serif !important;
            background-image: url('assets/—Pngtree—purple abstract background fluid gradient_1202137.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }

        #bluredbg {
            text-align: center;
            align-content: center;
            color: aliceblue;
            font-family: 'Sitka Banner';
            backdrop-filter: blur(20px);
            padding: 20px;
            box-shadow: -5px 0px 10px rgba(0, 0, 0, 0.5);
            height: 500px;
            width: 400px;
            border-radius: 40px 0px 0px 40px;
        }

        h1 {
            font-size: 50px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        #regis {
            height: auto;
            width: auto;
        }

        #regis {
            color: white;
        }

        @media screen and (max-width: 1000px) {
            #bluredbg {
                display: none;
            }

            #regis {
                height: auto;
                width: auto;
            }
        }
    </style>
</head>
<body>

    <form id="studentRegistration" runat="server" novalidate="novalidate">

        <div id="container" class="container d-flex justify-content-center align-items-center vh-100">
            <div class="row justify-content-center align-items-center g-4">
                <div id="bluredbg" class="col-md-5">
                    <h1>Begin Your Journey To Success
                        <br />
                        Register Now And Get Exam-ready !</h1>
                </div>
                <div id="regis" class="col-md-5">
                    <h3>Student Registration</h3>
                    <div class="form-group mb-3">

                        <label for="txtPRN">UserName&nbsp;&nbsp;&nbsp; </label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPRN" Display="Dynamic" ErrorMessage="User Name Cannot be Empty" ForeColor="Red">User Name Cannot be Empty</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtPRN" runat="server" CssClass="form-control" required="true" />

                        <label for="txtFullName">Full Name&nbsp;&nbsp;&nbsp; </label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFullName" Display="Dynamic" ErrorMessage="Name Can not Be Empty" ForeColor="Red">Name Can not Be Empty</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />

                        <label for="txtEmail">Email&nbsp;&nbsp;&nbsp; </label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email Cannot Be Empty" ForeColor="Red">Email Cannot Be Empty</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email ID Is Not Valid" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Email ID Is Not Valid</asp:RegularExpressionValidator>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required="true" />

                        <label for="txtPassword">Create Password&nbsp;&nbsp;&nbsp; </label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPassword" Display="Dynamic" ErrorMessage="Passsword Can not be Empty" ForeColor="Red">Passsword Can not be Empty</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="true" />

                        <label for="txtPassword">Confrim Password&nbsp;&nbsp;&nbsp; </label>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="checkpass" Display="Dynamic" ErrorMessage="Create Password and Confrim Password are not Matched." ForeColor="Red">Create Password and Confrim Password are not Matched.</asp:CompareValidator>
                        <asp:TextBox ID="checkpass" runat="server" CssClass="form-control" required="true" />

                        <label for="fuProfileImage">
                            Profile Image</label>
                        <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="form-control" accept="image/png, image/jpeg, image/jpg, image/gif" />
                    </div>

                    <div class="d-grid">
                        <br />

                        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success" OnClick="btnRegister_Click" CausesValidation="true" />
                    </div>

                </div>

            </div>

        </div>
    </form>
    <script href="Content/register.js"></script>
</body>
</html>
