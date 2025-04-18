using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System
{
    public partial class Reply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmail.Text = Session["ReplyEmail"].ToString();
            txtSubject.Text = "Thank You For Your Valuable Feedback";
            txtMessage.Text = "Best Regards,\nOnline Exam System Team";
        }
        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            { 
            SendMail sendMail = new SendMail()
            {
                Subject = txtSubject.Text,
                ToEmail = txtEmail.Text,
                Body =txtMessage.Text
            };
            SendMail sendMail1 = new SendMail();
            sendMail1.SendEmail(sendMail);
            Response.Write("<script>alert('Email sent successfully');window.close();</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
        }
}
    }
}