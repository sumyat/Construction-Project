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
    public partial class Staff : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (StaffID != string.Empty)
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
                    txtName.Enabled = true;
                    password.Visible = false;
                    Rpassword.Visible = false;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = Code;
                    txtName.Text = Name;
                    break;
                case 'D':
                    txtCode.Enabled = false;
                    txtName.Enabled = false;
                    password.Visible = false;
                    Rpassword.Visible = false;
                    btnAdd.Text = "Delete";
                    btnCancel.Text = "No delete";
                    txtCode.Text = Code;
                    txtName.Text = Name;
                    break;
                default:
                    txtCode.Enabled = true;
                    txtName.Enabled = true;
                    password.Visible = true;
                    Rpassword.Visible = true;
                    btnAdd.Text = "Add";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = "";
                    txtName.Text = "";
                    txtPass.Text = "";
                    txtRPass.Text = "";
                    break;
            }
            gvStaff.DataBind();
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
        public String Name
        {
            get
            {
                if (Request.QueryString["Name"] != null)
                    return Request.QueryString["Name"];
                return string.Empty;
            }
        }
        public String StaffID
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
                command = new SqlCommand("Staff_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Password", SqlDbType.NVarChar).Value = txtPass.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/Staff.aspx");
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
                command = new SqlCommand("Staff_Update", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@StaffID", SqlDbType.Char, 36).Value = StaffID;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Password", SqlDbType.NVarChar).Value = txtPass.Text;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/Staff.aspx");
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
                command = new SqlCommand("Staff_Delete", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@StaffID", SqlDbType.Char, 36).Value = StaffID;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/Staff.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
