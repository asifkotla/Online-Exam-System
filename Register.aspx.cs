using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System
{
    public partial class Register : System.Web.UI.Page
    {
        OnlineeExamSystemEntities2 dbo = new OnlineeExamSystemEntities2();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fuProfileImage.Attributes["accept"] = "image/png, image/jpeg, image/jpg, image/gif";

            }

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string userName = txtPRN.Text.Trim();
            string name = "";
            string email = "";
            string pass = "";
            var user = dbo.Students.Where(x => x.UserName == userName).FirstOrDefault();
            if (user == null)
            {
                 name = txtFullName.Text.Trim();
                 email = txtEmail.Text.Trim();
                 pass = txtPassword.Text.Trim();
                byte[] img = null;
                if (fuProfileImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuProfileImage.FileName);
                    string tempFolder = Server.MapPath("~/TempUploads/");
                    // Ensure the TempUploads folder exists
                    if (!Directory.Exists(tempFolder))
                    {
                        Directory.CreateDirectory(tempFolder);
                    }
                    string filePath = Path.Combine(tempFolder, fileName);
                    // Save the uploaded file temporarily
                    fuProfileImage.SaveAs(filePath);
                    // Now call your existing utility method
                    img = Utility.ConvertImageToByteArray(filePath);
                    // Optionally delete the file after converting
                    File.Delete(filePath);
                    // Now you can use `img` to store in DB or anything else
                }

                Online_Exam_System.Models.Student student = new Online_Exam_System.Models.Student()
                {
                    RegisterDate = DateTime.Now,    
                    UserName = userName,
                    FullName = name,
                    Email = email,
                    PasswordHash = Utility.HashPassword(pass),  // Assuming you have a method for hashing
                    ProfileImage = img // Store the image as Base64 string
                };

                // Save the student to the database
                dbo.Students.Add(student);
                if (dbo.SaveChanges() > 0)
                {
                    Response.Write("<script>alert(' ✅ Registration Completed Successfully');</script>");

                    txtPRN.Text = "";
                    txtFullName.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Text = "";
                    checkpass.Text = "";
                    
;
                }
                else
                {
                    Response.Write("<script>alert('❎ Something Went Wrong Please Try Again');</script>");
                }
            }
            else
            {
                txtPRN.Text = "";
                Response.Write("<script>alert('❎ User Name is Already Used PLease Try Another UserNAme');</script>");
                //txtFullName.Text = name;
                //txtEmail.Text = email;
                //txtPassword.Text = pass;
             
            }

        }




    
    }
}
