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

namespace Construction.Customer
{
    public partial class EditProfile : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            Update();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/EditProfile.aspx");
        }
        #endregion Events

        #region Data Method
        private SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Construction"].ConnectionString
            );
        private SqlCommand command;
        private SqlTransaction trans;
        private void Update()
        {
            connection.Open();
            trans = connection.BeginTransaction();
            try
            {
                Delete_Address();
                String address = Insert_Address();

                command = new SqlCommand("Customer_Update", connection, trans);
                command.CommandType = CommandType.StoredProcedure;

                //command.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = txtName.Text;
                //command.Parameters.Add("@Password", SqlDbType.NVarChar).Value = txtPass.Text;
                command.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = txtFirstName.Text;
                command.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = txtLastName.Text;
                command.Parameters.Add("@NRCNo", SqlDbType.NVarChar).Value = txtNRC.Text;
                command.Parameters.Add("@Email", SqlDbType.NVarChar).Value = txtEmail.Text;
                command.Parameters.Add("@AddressID", SqlDbType.Char).Value = address;
                command.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = txtPhone.Text;
                command.Parameters.Add("@Remark", SqlDbType.NVarChar).Value = txtRemark.Text;

                command.ExecuteNonQuery();
                trans.Commit();
                lblMessage.Text = "Successful Update.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                trans.Rollback();
            }
            finally
            {
                connection.Close();
            }

        }
        private String Insert_Address()
        {
            String result = "";
            try
            {
                command = new SqlCommand("Address_Insert", connection, trans);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@DivisionStateID", SqlDbType.Char).Value = ddlDS.SelectedValue;
                command.Parameters.Add("@CityTownshipID", SqlDbType.Char).Value = ddlTC.SelectedValue;
                command.Parameters.Add("@Address", SqlDbType.NVarChar).Value = txtAddress.Text;

                result = command.ExecuteScalar().ToString();
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private void Delete_Address()
        {
            try
            {
                command = new SqlCommand("Address_Delete", connection, trans);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@AddressID", SqlDbType.Char).Value = ddlDS.SelectedValue;

                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        #endregion Data Method
    }
}
