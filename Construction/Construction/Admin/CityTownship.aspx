<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="CityTownship.aspx.cs" Inherits="Construction.Admin.CityTownship" Title="City/Township" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>City / Township Setup
    </h3>
    <table style="border:double 3px #303e3d;" cellpadding="5">
        <tr>
            <td colspan="2">
                <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
                <asp:ValidationSummary runat="server" ForeColor="red" ID="vlError" />
            </td>
        </tr>
        <tr>
            <td>
                Division State
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlDS" Width="120px"
                DataSourceID="sqlDivsionState" DataTextField="Code" DataValueField="DivisionStateID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDivsionState" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>" SelectCommand="SELECT DivisionStateID,Code From DivisionStates WHERE isDelete = 0">
                </asp:SqlDataSource>
                <asp:RequiredFieldValidator runat="server" ID="rfvBank"
                ControlToValidate="ddlDS" Text="*" ErrorMessage="Require Bank.">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Code :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtCode">
                </asp:TextBox> <asp:RequiredFieldValidator runat="server" ID="rfvCode"
                ControlToValidate="txtCode" Text="*" ErrorMessage="Require Code." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Description : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtDesp" TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvDesp"
                ControlToValidate="txtDesp" Text="*" ErrorMessage="Require Description." ></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:CheckBox runat="server" ID="chkCity" Text="Is city?" />
            </td>
        </tr>
    </table> 
  
    <p>
    <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" />
    <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
    OnClick="btnCancel_Click" />              
    </p>                   
    <p>
    <asp:GridView ID="gvCityTownship" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CityTownshipID"
        ForeColor="#333333" GridLines="None" Width="600px" DataSourceID="sqlCityTownShip">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="DivisionState" HeaderText="DivisionState" SortExpression="DivisionState" />
            <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:CheckBoxField DataField="isCity" HeaderText="isCity" SortExpression="isCity" />  <asp:HyperLinkField DataNavigateUrlFields="CityTownShipID,DivsionStateID,Code,Description,isCity" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=E&amp;DS={1}&amp;Code={2}&amp;Desp={3}&amp;City={4}"
                Text="Edit">
                <ItemStyle Width="15px" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="CityTownShipID,DivsionStateID,Code,Description,isCity"
            DataNavigateUrlFormatString="?ID={0}&amp;Status=D&amp;DS={1}&amp;Code={2}&amp;Desp={3}&amp;City={4}"
                Text="Delete">
                <ItemStyle Width="20px" />
            </asp:HyperLinkField>
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
        <asp:SqlDataSource ID="sqlCityTownShip" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="SELECT [CityTownshipID], [DivsionStateID], [Code], [Description], [DivisionState], [isCity] FROM [CityTownships_vw]"></asp:SqlDataSource>
    </p>
</asp:Content>
