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
    public partial class Bank : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (BankID != string.Empty)
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
        #endregion Events

        #region Helper Methods
        private void changeUI(Char _status)
        {
            switch (_status)
            {
                case 'E':
                    txtCode.Enabled = false;
                    txtDesp.Enabled = true;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = Code;
                    txtDesp.Text = Desp;
                    break;
                case 'D':
                    txtCode.Enabled = false;
                    txtDesp.Enabled = false;
                    btnAdd.Text = "Delete";
                    btnCancel.Text = "No delete";
                    txtCode.Text = Code;
                    txtDesp.Text = Desp;
                    break;
                default:
                    txtCode.Enabled = true;
                    txtDesp.Enabled = true;
                    btnAdd.Text = "Add";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = "";
                    txtDesp.Text = "";
                    break;
            }
            gvBank.DataBind();
        }
        #endregion Helper Methods

        #region Properties
        public String Code
        {
            get
            {
                if (Request.QueryString["Code"] != null)
                    return Request.QueryString["Code"];
                return string.Empty;
            }
        }
        public String Desp
        {
            get
            {
                if (Request.QueryString["Desp"] != null)
                    return Request.QueryString["Desp"];
                return string.Empty;
            }
        }
        public String BankID
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
                command = new SqlCommand("Bank_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/Bank.aspx");
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
                command = new SqlCommand("Bank_Update", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@BankID", SqlDbType.Char, 36).Value = BankID;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/Bank.aspx");
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
                command = new SqlCommand("Bank_Delete", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@BankID", SqlDbType.Char, 36).Value = BankID;
                
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/Bank.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
