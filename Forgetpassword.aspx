<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgetpassword.aspx.cs" Inherits="Online_Exam_System.Forgetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
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
         background-image: url('assets/rm222batch3-mind-06.jpg');
         background-size: cover;
         background-repeat: no-repeat;
         background-position: center;
         background-attachment: fixed;
     }

       .input-underline {
        border: none !important;
        border-bottom: 2px solid black !important;
        border-radius: 0 !important;
        background-color: transparent !important;
        box-shadow: none !important;
        outline: none !important;
        padding-left: 0;
        padding-right: 0;
    }

    .input-underline:focus {
        border-bottom: 2px solid #28a745 !important; /* green on focus */
        outline: none !important;
        box-shadow: none !important;
    }


    h3{
        font-size:50px;
        font-family:cursive;
    }
    .txtbox{
        margin-top:20px;
        height:50px;
    }       

     @media screen and (max-width: 1000px) {
         #bluredbg {
             display: none;
            
         }
         img {
             display:none;
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
            <div class="row justify-content-center align-items-center g-6">
                
                    <img src="../assets/3275434.jpg" class="img-fluid image col-md-5" alt="Login Image" />
             
                <div id="regis" class="col-md-5">
                    <h3>FORGOT <br /> YOUR PASSWORD ?</h3>
                    <div class="form-group mb-3 txtbox">

                      <asp:TextBox ID="Email" runat="server" CssClass="form-control input-underline" required="true" BorderStyle="none" placeholder="Enter Your Email-ID" />
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Email" Display="Dynamic" ErrorMessage="Email Cannot Be Empty" ForeColor="Red">Email Connot Be Empty</asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email Address" EnableClientScript="True" ControlToValidate="Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Invalid Email Address</asp:RegularExpressionValidator>
                     </div>
                    <div class="d-grid">
                        <br />
                        <asp:Button ID="btnRegister" runat="server" Text="Send OTP" CssClass="btn btn-success" OnClick="btnforget"  />
                    </div>
                    <br />
               <asp:TextBox ID="txtOtp" runat="server" Placeholder="Enter OTP" CssClass="form-control input-underline" Visible="false" />
                    <div class="d-grid">
                        <br />
                        <br />
                  <asp:Button ID="btnVerifyOtp" runat="server" Text="Verify OTP" CssClass="btn btn-success " Visible="false" OnClick="btnVerifyOtp_Click" />
                       
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Label ID="lblTimer" runat="server" CssClass="text-danger fw-bold" Visible="false" />
        <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" Enabled="false" />
    </ContentTemplate>
</asp:UpdatePanel>
                    </div>

                </div>

            </div>

        </div>
    </form>
   

</body>
</html>
