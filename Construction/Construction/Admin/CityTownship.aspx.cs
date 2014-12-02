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
    public partial class CityTownship : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (CityTownshipID != string.Empty)
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
                    ddlDS.Enabled = true;
                    txtCode.Enabled = false;
                    txtDesp.Enabled = true;
                    chkCity.Enabled = true;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    ddlDS.SelectedValue = DS;
                    txtCode.Text = Code;
                    txtDesp.Text = Desp;
                    chkCity.Checked = isCity;
                    break;
                case 'D':
                    ddlDS.Enabled = false;
                    txtCode.Enabled = false;
                    txtDesp.Enabled = false;
                    chkCity.Enabled = false;
                    btnAdd.Text = "Delete";
                    btnCancel.Text = "No delete";
                    ddlDS.SelectedValue = DS;
                    txtCode.Text = Code;
                    txtDesp.Text = Desp;
                    chkCity.Checked = isCity;
                    break;
                default:
                    ddlDS.Enabled = true;
                    txtCode.Enabled = true;
                    txtDesp.Enabled = true;
                    chkCity.Enabled = true;
                    btnAdd.Text = "Add";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = "";
                    txtDesp.Text = "";
                    chkCity.Checked = false;
                    break;
            }
            gvCityTownship.DataBind();
        }
        #endregion Helper Methods

        #region Properties
        public String DS
        {
            get
            {
                if (Request.QueryString["DS"] != null)
                    return Request.QueryString["DS"];
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
        public String Desp
        {
            get
            {
                if (Request.QueryString["Desp"] != null)
                    return Request.QueryString["Desp"];
                return string.Empty;
            }
        }
        public String CityTownshipID
        {
            get
            {
                if (Request.QueryString["ID"] != null)
                    return Request.QueryString["ID"];
                return string.Empty;
            }
        }
        public Boolean isCity
        {
            get
            {
                if (Request.QueryString["City"] != null)
                    return Convert.ToBoolean(Request.QueryString["City"]);
                return false;
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
                command = new SqlCommand("CityTownship_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@DivisionStateID", SqlDbType.Char, 36).Value = ddlDS.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@isCity", SqlDbType.Bit).Value = chkCity.Checked;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/CityTownship.aspx");
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
                command = new SqlCommand("CityTownship_Update", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@CityTownshipID", SqlDbType.Char, 36).Value = CityTownshipID;
                command.Parameters.Add("@DivisionStateID", SqlDbType.Char, 36).Value = ddlDS.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@isCity", SqlDbType.Bit).Value = chkCity.Checked;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/CityTownship.aspx");
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
                command = new SqlCommand("CityTownship_Delete", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@CityTownshipID", SqlDbType.Char, 36).Value = CityTownshipID;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/CityTownship.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
