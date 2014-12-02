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
    public partial class _Default : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Login_Click(object sender, EventArgs e)
        {
            Check_Login();
        }
        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
        #endregion Events

        #region Data Method
        private SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Construction"].ConnectionString
            );
        private SqlCommand command;
        private void Check_Login()
        {
            try
            {
                command = new SqlCommand("Check_Login", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@Type", SqlDbType.Char).Value = ddlType.SelectedValue;
                command.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = txtName.Text;

                connection.Open();
                SqlDataReader sdr = command.ExecuteReader(CommandBehavior.CloseConnection);
                if (sdr.Read())
                {
                    if (String.Equals(sdr["UserName"].ToString(), txtName.Text, StringComparison.OrdinalIgnoreCase) &&
                        String.Equals(sdr["Password"].ToString(), txtPassword.Text, StringComparison.OrdinalIgnoreCase))
                    {
                        Session["UserID"] = sdr["ID"];
                        switch (ddlType.SelectedValue)
                        {
                            case "C":
                                Response.Redirect("~/Customer/OrderStatus.aspx");
                                break;
                            case "S":
                                Response.Redirect("~/Admin/OrderRequest.aspx");
                                break;
                            default:
                                Response.Redirect("~/Default.aspx");
                                break;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Invalid user or password.";
                    }
                }
                sdr.Close();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
