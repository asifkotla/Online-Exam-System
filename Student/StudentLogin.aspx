<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentLogin.aspx.cs" Inherits="Online_Exam_System.Student.StudentLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/assets/StylestdLogin.css") %>?v=1" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>Student Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container" class="container d-flex justify-content-center align-items-center vh-100 ">
            <div class="row justify-content-center align-items-center g-0">
                <div class="col-md-5 ">
                    <img src="../assets/4957136_4957136.jpg" class="img-fluid image" alt="Login Image" />
                </div>
                <div class="col-md-3     login">
                    <div>
                        <h3 class="welcome  ms-0">Welcome Back</h3>
                    </div>
                    <div class="login-form">
                        <h1>Student Login</h1>
                        <p>Login To Your Account</p>
                        <input type="text" id="Username" value="" name="username" class="form-control" placeholder="Username" />
                        <br />
                        <input type="password" id="password" value="" name="password" class="form-control" placeholder="Password" />

                        <div class="text-end">
                            <a class="btn-link forgot-password" href="#">Forgot Password?</a>
                        </div>
                        <br />
                        <div class="text-center">
                            <input type="submit" id="submit" value="Login" class="btn btn-color" />
                            <br />
                            <br />
                            <br />
                            <a class="btn-link create-account" href="../Register.aspx">Create Account</a>
                        </div>
                    </div>
                </div>
            </div>


        </div>


    </form>
</body>
</html>
