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
using System.IO;

namespace Construction.Admin
{
    public partial class DeckPlan : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["tmpImage"] = null;
                if (DeckPlanID != string.Empty)
                {
                    SelectByPlanID();
                    changeUI(Status);
                }
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
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Session["tmpImage"] = fupFile.FileBytes;
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
                    txtWidth.Enabled = true;
                    txtLength.Enabled = true;
                    txtHeight.Enabled = true;
                    txtDesp.Enabled = true;
                    fupFile.Enabled = true;
                    btnAdd.Text = "Update";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = tblTemp.Rows[0]["Code"].ToString();
                    txtName.Text = tblTemp.Rows[0]["Name"].ToString();
                    txtWidth.Text = tblTemp.Rows[0]["Width"].ToString();
                    txtLength.Text = tblTemp.Rows[0]["Length"].ToString();
                    txtHeight.Text = tblTemp.Rows[0]["Height"].ToString();
                    txtDesp.Text = tblTemp.Rows[0]["Description"].ToString();
                    Session["tmpImage"] = tblTemp.Rows[0]["SampleImage"];
                    break;
                case 'D':
                    txtCode.Enabled = false;
                    txtName.Enabled = false;
                    txtWidth.Enabled = false;
                    txtLength.Enabled = false;
                    txtHeight.Enabled = false;
                    txtDesp.Enabled = false;
                    fupFile.Enabled = false;
                    btnAdd.Text = "Delete";
                    btnCancel.Text = "No delete";
                    txtCode.Text = tblTemp.Rows[0]["Code"].ToString();
                    txtName.Text = tblTemp.Rows[0]["Name"].ToString();
                    txtWidth.Text = tblTemp.Rows[0]["Width"].ToString();
                    txtLength.Text = tblTemp.Rows[0]["Length"].ToString();
                    txtHeight.Text = tblTemp.Rows[0]["Height"].ToString();
                    txtDesp.Text = tblTemp.Rows[0]["Description"].ToString();
                    Session["tmpImage"] = tblTemp.Rows[0]["SampleImage"];
                    break;
                default:
                    txtCode.Enabled = true;
                    txtName.Enabled = true;
                    txtWidth.Enabled = true;
                    txtLength.Enabled = true;
                    txtHeight.Enabled = true;
                    txtDesp.Enabled = true;
                    fupFile.Enabled = true;
                    btnAdd.Text = "Add";
                    btnCancel.Text = "Cancel";
                    txtCode.Text = "";
                    txtName.Text = "";
                    txtWidth.Text = "0";
                    txtLength.Text = "0";
                    txtHeight.Text = "0";
                    txtDesp.Text = "";
                    Session["tmpImage"] = null;
                    break;
            }
            gvDeckPlan.DataBind();
        }
        #endregion Helper Methods

        #region Properties
        public DataTable tblTemp
        {
            get
            {
                if (ViewState["tblTemp"] == null)
                    return new DataTable();
                return (DataTable)ViewState["tblTemp"];
            }
            set
            {
                ViewState["tblTemp"] = value;
            }
        }
        public String DeckPlanID
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
        private void SelectByPlanID()
        {
            string strQuery = "SELECT * FROM Plans WHERE PlanID = @PlanID";
            command = new SqlCommand(strQuery, connection);
            command.CommandType = CommandType.Text;

            command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = DeckPlanID;

            connection.Open();
            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader(CommandBehavior.CloseConnection));
            ViewState["tblTemp"] = dt;
        }
        private void Insert()
        {
            try
            {
                command = new SqlCommand("Plan_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@HomeTypeID", SqlDbType.Char).Value = null;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Width", SqlDbType.Float).Value = Convert.ToDecimal(txtWidth.Text);
                command.Parameters.Add("@Length", SqlDbType.Float).Value = Convert.ToDecimal(txtLength.Text);
                command.Parameters.Add("@Height", SqlDbType.Float).Value = Convert.ToDecimal(txtHeight.Text);
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@PlanType", SqlDbType.Char).Value = 'D';
                command.Parameters.Add("@SampleImage", SqlDbType.Image).Value = (Byte[])Session["tmpImage"];

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/DeckPlan.aspx");
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
                command = new SqlCommand("Plan_Update", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = DeckPlanID;
                command.Parameters.Add("@HomeTypeID", SqlDbType.Char).Value = null;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Width", SqlDbType.Float).Value = Convert.ToDecimal(txtWidth.Text);
                command.Parameters.Add("@Length", SqlDbType.Float).Value = Convert.ToDecimal(txtLength.Text);
                command.Parameters.Add("@Height", SqlDbType.Float).Value = Convert.ToDecimal(txtHeight.Text);
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@PlanType", SqlDbType.Char).Value = 'D';
                command.Parameters.Add("@SampleImage", SqlDbType.Image).Value = (Byte[])Session["tmpImage"];

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/DeckPlan.aspx");
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
                command = new SqlCommand("Plan_Delete", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = DeckPlanID;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/DeckPlan.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
