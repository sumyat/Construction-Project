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
using System.Data.SqlClient;

namespace Construction
{
    public partial class Staff : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                lblUser.Text = Get_UserInfo().Rows[0]["StaffName"].ToString();
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Home.aspx");
        }
        #region Data Method
        private SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Construction"].ConnectionString
            );
        private SqlCommand command;
        public DataTable Get_UserInfo()
        {
            DataTable dt = new DataTable();
            try
            {
                command = new SqlCommand("Select_UserInfo", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@Type", SqlDbType.Char).Value = 'S';
                command.Parameters.Add("@ID", SqlDbType.Char).Value = Session["UserID"].ToString();

                connection.Open();
                dt.Load(command.ExecuteReader(CommandBehavior.CloseConnection));
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
            return dt;
        }
        #endregion Data Method
    }
}
