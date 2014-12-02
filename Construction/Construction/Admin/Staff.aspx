<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="Construction.Admin.Staff" Title="Staff" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Staff Setup
    </h3>
    <table style="border:double 3px #303e3d;" cellpadding="5">
        <tr>
            <td colspan="2">
                <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
                <asp:ValidationSummary runat="server" ForeColor="Red" ID="vlError" />
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
            Staff Name : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtName">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvDesp"
                ControlToValidate="txtName" Text="*" ErrorMessage="Require StaffName." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr  runat="server" id="password">
            <td>
            Password : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPass" TextMode="Password">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvPass"
                ControlToValidate="txtPass" Text="*" ErrorMessage="Require Pasword." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr runat="server" id="Rpassword">
            <td>
            Retype Password : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtRPass" TextMode="Password">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvRPass"
                ControlToValidate="txtRPass" Text="*" ErrorMessage="Require Retype Pasword." >
                </asp:RequiredFieldValidator>
                <asp:CompareValidator runat="server" ID="cpvRpass" ControlToCompare="txtPass" 
                ControlToValidate="txtRPass" Text="*" ErrorMessage="Require Retype Password." >
                </asp:CompareValidator>
            </td>
        </tr>
    </table>     
    <p>
    <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" />
    <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
    OnClick="btnCancel_Click" />              
    </p>                     
    <p>
    <asp:GridView ID="gvStaff" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="StaffID"
        ForeColor="#333333" GridLines="None" Width="500px" DataSourceID="sqlStaff">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="StaffCode" HeaderText="Code" SortExpression="StaffCode" />
            <asp:BoundField DataField="StaffName" HeaderText="Staff Name" SortExpression="StaffName" />
            <asp:HyperLinkField DataNavigateUrlFields="StaffID,StaffCode,StaffName" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=E&amp;Code={1}&amp;Name={2}"
                Text="Edit">
                <ItemStyle Width="15px" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="StaffID,StaffCode,StaffName" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=D&amp;Code={1}&amp;Name={2}"
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
        <asp:SqlDataSource ID="sqlStaff" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="Select * From Staffs Where isDelete = 0"></asp:SqlDataSource>
    </p>
</asp:Content>
