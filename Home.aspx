<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Online_Exam_System.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Online Exam System</title>

    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/Student/StyleSheet/StyleHome.css") %>?v=1" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
   
</head>
<body>
     <form id="form1" runat="server">
   <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
   <img id="logo" class="img-fluid " src="/assets/Owl%20of%20Wisdom.png" alt="LOGO" style="width: 45px; height: auto;  border-radius: 50%;   margin-right: 12px;"/> <h3>QuizNest</h3>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon bars"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" href="#form1">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#Contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Student/StudentLogin.aspx">Student login</a>
                </li>
                <li class="nav-item">
                     <a class="nav-link" href="Admin/AdminLogin.aspx">Admin login</a>
                </li>
                <li class="nav-item">
                     <a class="nav-link" href="Register.aspx">Register</a>
                </li>
           </ul>
        </div>
    </div>
</nav>
       
   
    <section class="hero-section">
        <div class="hero-overlay">
            <div class="container text">
                <div class="col-md-6 ">
                    <span style="color: #bbb;" class="text-uppercase heading">Are You Ready to Test Your Skills?</span>
                    <!-- on small screens remove display-4 -->
                    <h1 class="mb-4 mt-2 display-4 font-weight-bold"><span style="color: #00b4d8;"> Quiz Nest</span></h1>
                    <p style="color: #bbb;">
                        A smart and secure online exam system designed for seamless assessments.
                        <br />
                        Test anytime, anywhere with accuracy and ease!
                    </p>
                    <div class="mt-5">
                        <!-- hover background-color: white; color: black; -->
                        <a href="StudentLogin.aspx" class="custom-btn">Get Started</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%--    Features--%>
    <section class="features">
        <div class="feature-box">
            <h3>Secure Exam System</h3>
            <p>Ensuring security with automatic submission on tab-switch.</p>
        </div>
        <div class="feature-box">
            <h3>Admin & Student Panels</h3>
            <p>Manage tests, students, and track results.</p>
        </div>
        <div class="feature-box">
            <h3>PDF Reports</h3>
            <p>Generate detailed exam reports in PDF format.</p>
        </div>
    </section>
         <%--About--%>
    <section id="about" class="about-section">
        <div class="container">
            <div class="row align-items-center">
                <!-- Left Side: About Text -->
                <div class="col-md-6">
                    <h2>About Quiz Nest</h2>
                    <p>	A cozy place for quizzes and exams.Our Online Exam System is a secure and user-friendly platform that enables students to take exams online and allows administrators to manage them efficiently.</p>
                    <ul>
                        <li>✅ Secure online exams</li>
                        <li>✅ Automatic submission on time expiration</li>
                        <li>✅ Easy exam creation with Excel upload</li>
                        <li>✅ PDF reports for students and admins</li>
                    </ul>
                    <h3>Our Technology Stack</h3>
                    <p>We use <span style="color: #00b4d0;">ASP.NET Web Forms with SQL Server</span>  for a robust and scalable online exam system.</p>
                </div>
                <!-- Right Side: Image -->
                <div class="col-md-6 ">
                    <img src="assets/8262066.jpg" class="img-fluid" alt="Online Exam" />
                </div>
            </div>
        </div>
    </section>

    <section id="Contact">
        <div class="container form1">
            <div class="row">
                <div class="col-md-6 ">
                    <lottie-player
                        src="<%= ResolveUrl("~/assets/customer-review.json") %>"
                        background="transparent"
                        speed="1"
                        <%--  style="width: 300px; height: 300px;"  --%>
                        loop autoplay>
                    </lottie-player>
                </div>
             
                <div class="col-md-5 ">
                    <br />
                   

                
                    <h1>Give Your Valuable Feedback </h1>
                    <br />

                    <label for="Name" class="form-label">Enter Your Full Name</label>
                    <asp:TextBox ID="Name" CssClass="form-control" name="Name"  runat="server"></asp:TextBox>
                    <p class="validators"> <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Your Name" ControlToValidate="Name" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator></p>
                   
                    <label for="Email" class="form-label">Email</label>
                    <asp:TextBox ID="email" CssClass="form-control" name="Email" runat="server"></asp:TextBox>
                    <p class="validators"><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Valid Email Addreess(eg.xyz01@xyz.com)" ControlToValidate="email" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="email" Display="Dynamic" ErrorMessage="Please Enter Your Email" ForeColor="Red"></asp:RequiredFieldValidator>
                    </p>
                    <p class="validators">&nbsp;</p>
                   
                    <label for="feedback" class="form-label">Feedback</label>
                    <asp:TextBox ID="feedback" CssClass="form-control" name="feedback" runat="server" Rows="4" TextMode="MultiLine"></asp:TextBox>
                    <p="validators">
                       
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="feedback" Display="Dynamic" ErrorMessage="Enter Feedback" ForeColor="Red"></asp:RequiredFieldValidator>
                    </p>
                    <br />
                     <asp:Button ID="Button1" CssClass="custom-btn" runat="server" Text="Submit" OnClick="Button1Submit_Click" BorderStyle="None" />
                    
                      
                </div>
            </div>
        </div>
    </section>
         <%--footer--%>

    <div class="my-5">
        <!-- Footer -->
        <footer
            class="text-center text-lg-start text-white"
            style="background-color: #0077b6">
            <!-- Grid container -->
            <div class="container p-4 pb-0">
                <!-- Section: Links -->
                <section class="">
                    <!--Grid row-->
                    <div class="row">
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Quiz Nest
                            </h6>
                            <p>
                                A smart and secure online exam system designed for seamless assessments.
                        
                        Test anytime, anywhere with accuracy and ease!
                            </p>

                        </div>
                      

                        <hr class="w-100 clearfix d-md-none" />

                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Useful links
                            </h6>
                            <p>
                                <a href="#form1" class="text-white">Home</a>
                            </p>
                            <p>
                                <a href="#about" class="text-white">About Us</a>
                            </p>
                            <p>
                                <a href="#Contact" class="text-white">Contact us</a>
                            </p>
                            <p>
                                <a href="Register.aspx" class="text-white" >Register</a>
                            </p>
                        </div>

                        <!-- Grid column -->
                        <hr class="w-100 clearfix d-md-none" />

                        <!-- Grid column -->
                        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Contact</h6>
                            <p><i class="fas fa-home mr-3"></i> India,Maharashtra,Sangli</p>
                            <p><i class="fas fa-envelope mr-3"></i> asifkotla04@gmail.com</p>
                            <p><i class="fas fa-phone mr-3"></i> + 91 7276159569</p>
                            <p><i class="fas fa-print mr-3"></i> + 91 8669131687</p>
                        </div>
                        <!-- Grid column -->
                    </div>
                    <!--Grid row-->
                </section>
                <!-- Section: Links -->

                <hr class="my-3" />

                <!-- Section: Copyright -->
                <section class="p-3 pt-0">
                    <div class="row d-flex align-items-center">
                        <!-- Grid column -->
                        <div class="col-md-7 col-lg-8 text-center text-md-start">
                            <!-- Copyright -->
                            <div class="p-3">
                                © 2025 Copyright:
              <a class="text-white" href="#">aasifKotla</a>
                            </div>
                            <!-- Copyright -->
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-md-5 col-lg-4 ml-lg-0 text-center text-md-end">
                            <!-- Facebook -->
                            <a href="https://www.linkedin.com/in/asif-kotla/"
                                class="btn btn-outline-light btn-floating m-1 text-white"
                                target="_blank"
                                rel="noopener noreferrer"
                                role="button">
                                <i class="fa-brands fa-linkedin"></i>
                            </a>

                            <a
                                href="https://github.com/asifkotla"
                                class="btn btn-outline-light btn-floating m-1 text-white"
                                rel="noopener noreferrer"
                                target="_blank"
                                role="button"><i class="fa-brands fa-github"></i></a>


                            <a
                                href="mailto:asifkotla04@gmail.com"
                                class="btn btn-outline-light btn-floating m-1 text-white"
                                rel="noopener noreferrer"
                                target="_blank"
                                role="button">
                                <i class="fa-solid fa-envelope"></i>

                            </a>


                            <a
                                href="https://www.instagram.com/aasifkotla.insta?igsh=aWtjdWs0dDd1dWZx&utm_source=qr"
                                class="btn btn-outline-light btn-floating m-1 text-white"
                                rel="noopener noreferrer"
                                target="_blank"
                                role="button"><i class="fab fa-instagram"></i></a>
                        </div>
                        <!-- Grid column -->
                    </div>
                </section>
                <!-- Section: Copyright -->
            </div>
            <!-- Grid container -->
        </footer>
        <!-- Footer -->
    </div>
         </form>
  
</body>
</html>
