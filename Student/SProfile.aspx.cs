using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Online_Exam_System.Student
{
    public partial class SProfile : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo=new OnlineeExamSystemEntities2();

        protected void Page_Load(object sender, EventArgs e)
        {
            int studentid=int.Parse(Session["StdId"].ToString());
            var studentdetails = dbo.Students.Where(x => x.StudentID == studentid).FirstOrDefault();

            Username.Text = studentdetails.UserName;
            lblName.Text = studentdetails.FullName;
            lblEmail.Text = studentdetails.Email;
            if (!IsPostBack)
            {


                txtuser.Text = studentdetails.UserName;
                txtName.Text = studentdetails.FullName;
                txtEmail.Text = studentdetails.Email;
            }
         

            var profileImagePath = Utility.ConvertByteArrayToImage(studentdetails.ProfileImage);
            if (studentdetails.ProfileImage != null && studentdetails.ProfileImage.Length > 0)
            {
                string base64String = Convert.ToBase64String(studentdetails.ProfileImage);
                imgProfile.ImageUrl = "data:image/png;base64," + base64String;
                
                imgProfileEdit.ImageUrl = "data:image/png;base64," + base64String;
            }
            else
            {
                imgProfile.ImageUrl = "../assets/default-profile1.png";
                imgProfileEdit.ImageUrl = "../assets/default-profile1.png";
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int studentid = int.Parse(Session["StdId"].ToString());
            var student = dbo.Students.Where(x => x.StudentID == studentid).FirstOrDefault();

            if (student != null)
            {
              
                student.UserName = txtuser.Text.Trim();
                student.FullName = txtName.Text.Trim();
                student.Email = txtEmail.Text.Trim();

                
                if (fuProfilePic.HasFile)
                {
                    student.ProfileImage = fuProfilePic.FileBytes;
                }

                if (dbo.SaveChanges() > 0)
                {
                    Response.Write("<script>alert('✅ Profile Updated Successfully..');</script>");
                    Page_Load(sender, e);

                }
                else
                {

                    Response.Write("<script>alert('❎ Something Went Wrong while Updating Your Profile Please Try Again');</script>");
                }
            }
        }
      
        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            byte[] pass = Utility.HashPassword(txtNewPassword.Text);
            int studid =int.Parse(Session["StdId"].ToString());
            var studentdetail = dbo.Students.Where(x => x.StudentID == studid).FirstOrDefault();
            studentdetail.PasswordHash = pass;
            if (dbo.SaveChanges() > 0)
            {
                Response.Write("<script>alert('✅ Password Changed  Successfully..');</script>");
                Page_Load(sender, e);
            }
            else
            {

                Response.Write("<script>alert('❎ Something Went Wrong while Changing  Your Password Please Try Again');</script>");
            }

        }
        protected void cvCustom_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = txtEmail.Text;
            var checkemail = dbo.Students.Where(x => x.Email == email).FirstOrDefault();
            if (checkemail == null)
            {
                args.IsValid = true;
            }
            else
            {
                //args.IsValid = false;
                Response.Write("<script>alert('❎ Email Is Taken... Please try with Different Email Adress');</script>");

            }
        }
        protected void cvCustom_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            string username = txtuser.Text;
            var checkusername = dbo.Students.Where(x => x.UserName == username).FirstOrDefault();
            if (checkusername == null)
            {
                args.IsValid = true;
            }
            else
            {
                //args.IsValid = false;
                Response.Write("<script>alert('❎ UserName Is Taken... Please try with Different User Name');</script>");
            }
        }
    }
}