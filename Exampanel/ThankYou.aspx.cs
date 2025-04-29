using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Exam_System.Exampanel
{
   
        public partial class ThankYou : System.Web.UI.Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    if (Session["ResultPDFPath"] != null)
                    {
                        lnkDownloadPDF.NavigateUrl = Session["ResultPDFPath"].ToString();
                    }
                    else
                    {
                        lnkDownloadPDF.Text = "PDF not available";
                        lnkDownloadPDF.Enabled = false;
                    }
                }
            }

            protected void btnLogout_Click(object sender, EventArgs e)
            {
                Session.Clear();
                Response.Redirect("~/Home.aspx");
            }
        }
    }
