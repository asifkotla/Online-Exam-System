﻿using Online_Exam_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Admin
{
    public partial class AdminPanel : System.Web.UI.MasterPage
    {
        OnlineeExamSystemEntities1 dbo = new OnlineeExamSystemEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Session["Emailid"].ToString();
            var adminuser = dbo.Admins.Where(x => x.Email == email).FirstOrDefault();
            Label1.Text = adminuser.FullName;
        }
    }
    
}