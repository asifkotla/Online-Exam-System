using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    
    public partial class Profile : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo=new OnlineeExamSystemEntities2();
        protected void Page_Load(object sender, EventArgs e)
        {
            var profileInformation = dbo.Admins.Where(x => x.AdminID == 2).FirstOrDefault();
            lblName.Text = profileInformation.FullName;
            lblEmail.Text = profileInformation.Email;
            if (!IsPostBack)
            {
                
              
                txtName.Text = profileInformation.FullName;
                txtEmail.Text = profileInformation.Email;
            }
         
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int adminid = 2;/*int.Parse(Session["adminid"].ToString());*/
            var admindetail = dbo.Admins.Where(x => x.AdminID == adminid).FirstOrDefault();
            admindetail.FullName = txtName.Text;
            admindetail.Email = txtEmail.Text;
            if(dbo.SaveChanges()>0)
            {
                Response.Write("<script>alert('✅ Profile Updated Successfully..');</script>");
                Page_Load(sender, e);
            }
            else
            {

                Response.Write("<script>alert('❎ Something Went Wrong while Updating Your Profile Please Try Again');</script>");
            }
        }
        protected void btnUpdatePassword_Click(object sender,EventArgs e)
        {
            byte[] pass = Utility.HashPassword(txtNewPassword.Text);
            int adminid = int.Parse(Session["adminid"].ToString());
            var admindetail = dbo.Admins.Where(x => x.AdminID == adminid).FirstOrDefault();
            admindetail.PasswordHash = pass;
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
            var checkemail=dbo.Admins.Where(x=>x.Email==email).FirstOrDefault();
            if (checkemail == null)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
                
            }
        }
    }
}