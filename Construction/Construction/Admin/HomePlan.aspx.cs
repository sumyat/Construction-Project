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
    public partial class HomePlan : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["tmpImage"] = null;
                if (HomePlanID != string.Empty)
                {
                    SelectByPlanID();
                    //changeUI(Status);
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
        protected void btnRoom_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (gvRoom.SelectedIndex < 0)
            {
                IsNewRow = true;
                AddNewRows(tblRoom);
            }
        }

        #region Grid view Event
        protected void gvRoom_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblMessage.Text = "";
            try
            {
                gvRoom.SelectedIndex = e.NewEditIndex;
                gvRoom.EditIndex = e.NewEditIndex;
                gvRoom_DataBind();

                DropDownList ddl = (DropDownList)gvRoom.Rows[e.NewEditIndex].FindControl("ddlRoomType");
                TextBox txtWidth = (TextBox)gvRoom.Rows[e.NewEditIndex].FindControl("txtWidth");
                TextBox txtLength = (TextBox)gvRoom.Rows[e.NewEditIndex].FindControl("txtLength");
                TextBox txtHeight = (TextBox)gvRoom.Rows[e.NewEditIndex].FindControl("txtHeight");
                TextBox txtQty = (TextBox)gvRoom.Rows[e.NewEditIndex].FindControl("txtQuantity");

                DataRow dr = GetTempTableDataRow(gvRoom.SelectedValue.ToString());

                ddl.SelectedValue = dr["RoomType"].ToString();
                txtWidth.Text = dr["Width"].ToString();
                txtLength.Text = dr["Length"].ToString();
                txtHeight.Text = dr["Height"].ToString();
                txtQty.Text = dr["Quantity"].ToString();

            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

        protected void gvRoom_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            lblMessage.Text = "";
            DataTable dt = tblRoom;

            dt.Rows.Remove(dt.Rows[e.RowIndex]);
            TempTableDeserializedKey();
            gvRoom_DataBind();
        }

        protected void gvRoom_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lblMessage.Text = "";
            DataTable dt = tblRoom;

            if (IsNewRow)
            {
                dt.Rows.Remove(dt.Rows[e.RowIndex]);
                TempTableDeserializedKey();
                IsNewRow = false;
            }

            gvRoom.SelectedIndex = -1;
            gvRoom.EditIndex = -1;
            gvRoom_DataBind();
        }

        protected void gvRoom_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            lblMessage.Text = "";
            try
            {
                DropDownList ddl = (DropDownList)gvRoom.Rows[e.RowIndex].FindControl("ddlRoomType");
                TextBox txtWidth = (TextBox)gvRoom.Rows[e.RowIndex].FindControl("txtWidth");
                TextBox txtLength = (TextBox)gvRoom.Rows[e.RowIndex].FindControl("txtLength");
                TextBox txtHeight = (TextBox)gvRoom.Rows[e.RowIndex].FindControl("txtHeight");
                TextBox txtQty = (TextBox)gvRoom.Rows[e.RowIndex].FindControl("txtQuantity");

                DataRow dr = GetTempTableDataRow(gvRoom.SelectedValue.ToString());

                dr["RoomName"] = ddl.SelectedItem.te
;
                dr["RoomType"] = ddl.SelectedValue;
                dr["Width"] = Convert.ToDecimal(txtWidth.Text);
                dr["Length"] = Convert.ToDecimal(txtLength.Text);
                dr["Height"] = Convert.ToDecimal(txtHeight.Text);
                dr["Quantity"] = Convert.ToInt32(txtQty.Text);

                gvRoom.SelectedIndex = -1;
                gvRoom.EditIndex = -1;
                gvRoom_DataBind();

                IsNewRow = false;
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Gridview Event
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
        }

        private void gvRoom_DataBind()
        {
            gvRoom.DataSource = tblRoom;
            gvRoom.DataBind();
        }

        private void Create_tblRoom()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Key", typeof(int));
            dt.Columns.Add("RoomName", typeof(string));
            dt.Columns.Add("RoomType", typeof(String));
            dt.Columns.Add("Width", typeof(double));
            dt.Columns.Add("Length", typeof(double));
            dt.Columns.Add("Height", typeof(double));
            dt.Columns.Add("Quantity", typeof(int));

            ViewState["tblRoom"] = dt;
        }
        public DataRow GetTempTableDataRow(string key)
        {
            DataTable dt = tblRoom;

            DataRow[] dr = dt.Select("Key= '" + key + "'");

            if (dr.Length < 0)
                dr[0] = dt.NewRow();
            return dr[0];

        }
        public void ClearTemptable()
        {
            tblRoom.Clear();
        }
        public void AddNewRows(DataTable dt)
        {
            DataRow dr = dt.NewRow();
            dr["Key"] = dt.Rows.Count + 1;
            dt.Rows.Add(dr);

            gvRoom.SelectedIndex = dt.Rows.Count - 1;
            gvRoom.EditIndex = dt.Rows.Count - 1;
            gvRoom_DataBind();
        }
        public void TempTableDeserializedKey()
        {
            DataTable dt = tblRoom;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["Key"] = i + 1;
            }
        }
        #endregion Helper Methods

        #region Properties
        bool IsNewRow
        {
            get
            {
                if (ViewState["IsNewRow"] == null)
                    ViewState["IsNewRow"] = false;
                return (bool)ViewState["IsNewRow"];
            }
            set
            {
                ViewState["IsNewRow"] = value;
            }

        }
        public DataTable tblRoom
        {
            get
            {
                if (ViewState["tblRoom"] == null)
                    Create_tblRoom();
                return (DataTable)ViewState["tblRoom"];
            }
            set
            {
                ViewState["tblTemp"] = value;
            }
        }
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
        public String HomePlanID
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

            command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = HomePlanID;

            connection.Open();
            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader(CommandBehavior.CloseConnection));
            ViewState["tblTemp"] = dt;
        }
        private void SelectRoomByPlanID()
        {
        }
        private void Insert()
        {
            try
            {
                command = new SqlCommand("Plan_Insert", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@HomeTypeID", SqlDbType.Char).Value = ddlType.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Width", SqlDbType.Float).Value = Convert.ToDecimal(txtWidth.Text);
                command.Parameters.Add("@Length", SqlDbType.Float).Value = Convert.ToDecimal(txtLength.Text);
                command.Parameters.Add("@Height", SqlDbType.Float).Value = Convert.ToDecimal(txtHeight.Text);
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@PlanType", SqlDbType.Char).Value = 'H';
                command.Parameters.Add("@SampleImage", SqlDbType.Image).Value = (Byte[])Session["tmpImage"];

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/HomePlan.aspx");
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

                command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = HomePlanID;
                command.Parameters.Add("@HomeTypeID", SqlDbType.Char).Value = ddlType.SelectedValue;
                command.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Text;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
                command.Parameters.Add("@Width", SqlDbType.Float).Value = Convert.ToDecimal(txtWidth.Text);
                command.Parameters.Add("@Length", SqlDbType.Float).Value = Convert.ToDecimal(txtLength.Text);
                command.Parameters.Add("@Height", SqlDbType.Float).Value = Convert.ToDecimal(txtHeight.Text);
                command.Parameters.Add("@Desp", SqlDbType.NVarChar).Value = txtDesp.Text;
                command.Parameters.Add("@PlanType", SqlDbType.Char).Value = 'H';
                command.Parameters.Add("@SampleImage", SqlDbType.Image).Value = (Byte[])Session["tmpImage"];

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                Response.Redirect("~/Admin/HomePlan.aspx");
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

                command.Parameters.Add("@PlanID", SqlDbType.Char, 36).Value = HomePlanID;

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("~/Admin/HomePlan.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
        #endregion Data Method
    }
}
