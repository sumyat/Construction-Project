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

namespace Construction.Admin
{
    public partial class BankAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (BankAccountID != string.Empty)
                    changeUI(Status);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            switch (btnAdd.Text)
            {
                case "Delete":
                    Delete();
                    break;
                case "Update":
                    Update();
                    break;
                default:
                    Insert();
                    break;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            changeUI('C');
        }

        #region Helper Methods
        private void changeUI(Char _status)
        {
            switch (_status)
            {
                case 'E':
                    ddlBank.Enabled = true;
                    txtCode.Enabled = true;
                    txtUser.Enabled = true;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    ddlBank.SelectedValue = Bank;
                    txtCode.Text = Code;
                    txtUser.Text = User;
                    break;
                case 'D':
                    ddlBank.Enabled = false;
                    txtCode.Enabled = false;
                    txtUser.Enabled = false;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    btnAdd.Text = "Delete";
                    btnCancel.Text = "No delete";
                    ddlBank.SelectedValue = Bank;
                    txtCode.Text = Code;
                    txtUser.Text = User;
                    break;
                default:
                    ddlBank.Enabled = true;
                    txtCode.Enabled = true;
                    txtUser.Enabled = true;
                    btnAdd.Text = "Add";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = "";
                    txtUser.Text = "";
                    break;
            }
            gvBankAccount.DataBind();
        }
        #endregion Helper Methods

        #region Properties
        public String Bank
        {
            get
            {
                if (Request.QueryString["Bank"] != null)
                    return Request.QueryString["Bank"];
                return string.Empty;
            }
        }
        public String Code
        {
            get
            {
                if (Request.QueryString["Code"] != null)
                    return Request.QueryString["Code"];
                return string.Empty;
            }
        }
        public String User
        {
            get
            {
                if (Request.QueryString["User"] != null)
                    return Request.QueryString["User"];
                return string.Empty;
            }
        }
        public String BankAccountID
        {
            get
            {
                if (Request.QueryString["ID"] != null)
                    return Request.QueryString["ID"];
                return string.Empty;
            }
        }
        public Char Status
        {
            get
            {
                if (Request.QueryString["Status"] != null)
                    return Request.QueryString["Status"][0];
                return 'C';
            }
        }
        #endregion Properties

        #region Data Method
        private SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["Construction"].ConnectionString
            );
        private SqlCommand command;
        private void Insert()
        {
            try
            {
                command = new SqlCommand("BankAccount_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@BankID", SqlDbType.Char, 36).Value = this.ddlBank.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtUser.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/BankAccount.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }

        }
        private void Update()
        {
            try
            {
                command = new SqlCommand("BankAccount_Update", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@BankAccountID", SqlDbType.Char, 36).Value = BankAccountID;
                command.Parameters.Add("@BankID", SqlDbType.Char, 36).Value = this.ddlBank.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtUser.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/BankAccount.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        private void Delete()
        {
            try
            {
                command = new SqlCommand("BankAccount_Delete", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@BankAccountID", SqlDbType.Char, 36).Value = BankAccountID;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/BankAccount.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
