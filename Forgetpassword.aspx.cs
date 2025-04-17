using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static System.Net.WebRequestMethods;

namespace Online_Exam_System
{
    public partial class Forgetpassword : System.Web.UI.Page
    { 
        OnlineeExamSystemEntities1 dbo=new OnlineeExamSystemEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["OTP"] != null)
            {
                txtOtp.Visible = true;
                btnVerifyOtp.Visible = true;
                lblTimer.Visible = true;
            }

        }
        protected void btnforget(object sender,EventArgs e)
        {
            var user=dbo.Students.Where(x=>x.Email==Email.Text).FirstOrDefault();
            if (user != null)
            {
                string otp = Utility.GenerateOtp();
                Session["OTP"] = otp;
                Session["OTP_Time"] = DateTime.Now;
                Session["Email"] = user.Email;
                SendMail sendMail = new SendMail()
                {
                    Subject = "Password Reset OTP - Online Exam System",
                    ToEmail = user.Email,
                    Body = $@"
                    <body style='font-family: Arial, sans-serif; background-color: #f5f5f5; padding: 20px;'>
                    <div style='max-width: 600px; margin: auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);'>
                    <h2 style='color: #28a745;'>Online Exam System - Password Reset</h2>
                    <p>Dear <strong>{user.FullName}</strong>,</p>
                    <p>We received a request to reset your password for your account associated with this email.</p>
                    <p style='font-size: 18px;'>Your OTP for password reset is:</p>
                    <p style='font-size: 28px; font-weight: bold; color: #28a745; letter-spacing: 3px;'>{otp}</p>
                   <p>Please enter this OTP in the system to proceed with resetting your password. This OTP is valid for the next 10 minutes.</p>
                   <p>If you did not request a password reset, please ignore this email.</p>
                   <br />
                   <p>Regards,<br />Online Exam System Team</p>
                   </div>
                  </body>"
                };
                SendMail sendMail1 = new SendMail();
                sendMail1.SendEmail(sendMail);

                if (Session["OTP"] != null && Session["OTP_Time"] != null)
                {
                    txtOtp.Visible = true;
                    btnVerifyOtp.Visible = true;
                    Email.Enabled =false ;
                    btnRegister.Enabled = false ;
                    lblTimer.Visible = true;

                    // Start Timer: set countdown to 3 mins (180 seconds)
                    ViewState["RemainingSeconds"] = 180;
                    Timer1.Enabled = true;
                }
             
            }
            else
            {
                var admin = dbo.Admins.Where(x => x.Email == Email.Text).FirstOrDefault();
                if (admin != null)
                {
                    string otp = Utility.GenerateOtp();
                    Session["OTP"] = otp;
                    Session["OTP_Time"] = DateTime.Now;
                    Session["Email"] = admin.Email;
                    SendMail sendMail = new SendMail()
                    {
                        Subject = "Password Reset OTP - Online Exam System",
                        ToEmail = admin.Email,
                        Body = $@"
                    <body style='font-family: Arial, sans-serif; background-color: #f5f5f5; padding: 20px;'>
                    <div style='max-width: 600px; margin: auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);'>
                    <h2 style='color: #28a745;'>Online Exam System - Password Reset</h2>
                    <p>Dear <strong>{admin.FullName}</strong>,</p>
                    <p>We received a request to reset your password for your account associated with this email.</p>
                    <p style='font-size: 18px;'>Your OTP for password reset is:</p>
                    <p style='font-size: 28px; font-weight: bold; color: #28a745; letter-spacing: 3px;'>{otp}</p>
                   <p>Please enter this OTP in the system to proceed with resetting your password. This OTP is valid for the next 10 minutes.</p>
                   <p>If you did not request a password reset, please ignore this email.</p>
                   <br />
                   <p>Regards,<br />Online Exam System Team</p>
                   </div>
                  </body>"
                    };
                    SendMail sendMail1 = new SendMail();
                    sendMail1.SendEmail(sendMail);

                    if (Session["OTP"] != null && Session["OTP_Time"] != null)
                    {
                        txtOtp.Visible = true;
                        btnVerifyOtp.Visible = true;
                        Email.Enabled = false;
                        btnRegister.Enabled = false;
                        lblTimer.Visible = true;

                        
                        ViewState["RemainingSeconds"] = 180;
                        Timer1.Enabled = true;

                    }
                    else
                    {
                        Response.Write("<script>alert('❎ User Not Found');</script>");

                    }
                }
            }
        }
        protected void btnVerifyOtp_Click(object sender, EventArgs e)
        {
            if (Session["OTP"] != null && Session["OTP_Time"] != null)
            {
                string sessionOtp = Session["OTP"].ToString();
                DateTime sentTime = (DateTime)Session["OTP_Time"];

                if ((DateTime.Now - sentTime).TotalMinutes <= 3)
                {
                    if (txtOtp.Text == sessionOtp)
                    {
                        Response.Write("<script>alert('✅ OTP Matched');</script>");
                        string username = Session["Email"].ToString();
                        var recoverUser = dbo.Students.Where(x => x.Email == username).FirstOrDefault();
                        if(recoverUser!=null)
                        {
                            string generatepass = Utility.PasswordGenarator();
                            SendMail sendMail = new SendMail()
                            {
                                Subject = "🔐 Temporary Password - Online Exam System",
                                ToEmail = username,
                                Body = $@"
                                       Dear {recoverUser.FullName},<br/><br/>
                                       Your OTP has been successfully verified.<br/><br/>
                                       A temporary password has been generated for your account. Please use the following credentials to log in:<br/><br/>
                                       <strong>Email:</strong> {username}<br/>
                                       <strong>Temporary Password:</strong> {generatepass}<br/><br/>
                                      ⚠️ <strong>Important:</strong> After logging in, please go to your profile/settings and <strong>change your password</strong> immediately for security reasons.<br/><br/>
                                      If you did not request a password reset, please ignore this email or contact support.<br/><br/>
                                      Best regards,<br/>
                                      <b>Online Exam System Team</b>"
                            };
                            SendMail sendMail1 = new SendMail();
                            sendMail1.SendEmail(sendMail);
                            recoverUser.PasswordHash = Utility.HashPassword(generatepass);
                            if(dbo.SaveChanges()>0)
                            {
                                Response.Redirect("~/Student/StudentLogin.aspx");
                            }

                        }
                        else
                        {
                            var recoveradmin = dbo.Admins.Where(x => x.Email == username).FirstOrDefault();
                           if(recoveradmin!=null)
                            {
                                string generatepass = Utility.PasswordGenarator();
                                SendMail sendMail = new SendMail()
                                {
                                    Subject = "🔐 Temporary Password - Online Exam System",
                                ToEmail = username,
                                Body = $@"
                                       Dear {recoveradmin.FullName},<br/><br/>
                                       Your OTP has been successfully verified.<br/><br/>
                                       A temporary password has been generated for your account. Please use the following credentials to log in:<br/><br/>
                                       <strong>Email:</strong> {username}<br/>
                                       <strong>Temporary Password:</strong> {generatepass}<br/><br/>
                                      ⚠️ <strong>Important:</strong> After logging in, please go to your profile/settings and <strong>change your password</strong> immediately for security reasons.<br/><br/>
                                      If you did not request a password reset, please ignore this email or contact support.<br/><br/>
                                      Best regards,<br/>
                                      <b>Online Exam System Team</b>"
                            };
                            SendMail sendMail1 = new SendMail();
                            sendMail1.SendEmail(sendMail);
                                recoveradmin.PasswordHash = Utility.HashPassword(generatepass);
                                if (dbo.SaveChanges() > 0)
                                {
                                    Response.Redirect("~/Admin/AdminLogin.aspx");
                                }

                            }
                            else
                            {
                                Response.Write("<script>alert('❌ User Not Found');</script>");
                            }
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('❌ Invalid OTP');</script>");
                    }
                }
                else
                {
                    Session.Remove("OTP");
                    Session.Remove("OTP_Time");
                    Response.Write("<script>alert('⏰ OTP Expired');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('⚠️ OTP not generated or session expired.');</script>");
            }
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (ViewState["RemainingSeconds"] != null)
            {
                int seconds = (int)ViewState["RemainingSeconds"];
                if (seconds > 0)
                {
                    seconds--;
                    ViewState["RemainingSeconds"] = seconds;
                    int minutes = seconds / 60;
                    int secs = seconds % 60;
                    lblTimer.Text = $"⏳ OTP valid for: {minutes:D2}:{secs:D2}";
                }
                else
                {
                    Timer1.Enabled = false;
                    lblTimer.Text = "❌ OTP Expired";
                    btnVerifyOtp.Enabled = false;
                    Session.Remove("OTP");
                    Session.Remove("OTP_Time");
                    Response.Write("<script>alert('⏰ OTP Expired');</script>");
                }
            }
        }

    }
}