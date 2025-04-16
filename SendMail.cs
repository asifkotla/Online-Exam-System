using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;

namespace Online_Exam_System
{
    public class SendMail
    {
        public string Subject { get; set; }
        public string ToEmail { get; set; }
        public string Body { get; set; }


        string fromemail = "employeeemanagementsystem@gmail.com";
        string frompass = "hnnq loam hhja romh";

        public void SendEmail(SendMail sendMail)
        {
            try
            {
                MailMessage message = new MailMessage();
                message.From = new MailAddress(fromemail);
                message.Subject = sendMail.Subject;
                message.To.Add(new MailAddress(sendMail.ToEmail));
                message.Body = sendMail.Body;
                message.IsBodyHtml = true;

                var smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential(fromemail, frompass),
                    EnableSsl = true
                };
                smtpClient.Send(message);
                //Utility.DisplaySuccessMessage("Mail Sent");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Something Went Wrong" + ex.Message);
                    
            }

        }
    }
}