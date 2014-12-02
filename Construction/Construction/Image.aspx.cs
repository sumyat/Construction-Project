using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Construction
{
    public partial class Image : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["tmpImage"] != null)
                    CreateImage((Byte[])Session["tmpImage"]);
            }
            catch
            {
            }
        }
        private void CreateImage(Byte[] data)
        {

            if (data.Length > 0)
            {
                Response.ClearContent();
                Response.ContentType = "image/gif";
                Response.BinaryWrite(data);
            }
        }
    }
}
