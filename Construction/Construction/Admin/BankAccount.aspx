<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="BankAccount.aspx.cs" Inherits="Construction.Admin.BankAccount" Title="Bank Account" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Bank Account Setup
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
                Bank
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlBank" Width="120px"
                DataSourceID="sqlBank" DataTextField="Code" DataValueField="BankID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlBank" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="Select BankID,Code From Banks Where isDelete = 0"></asp:SqlDataSource>
                <asp:RequiredFieldValidator runat="server" ID="rfvBank"
                ControlToValidate="ddlBank" Text="*" ErrorMessage="Require Bank.">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Account Code :
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
                Account User : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUser">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvDesp"
                ControlToValidate="txtUser" Text="*" ErrorMessage="Require Description." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>      
    <p>
    <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" />
    <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
    OnClick="btnCancel_Click" />              
    </p>                
    <p>
    <asp:GridView ID="gvBankAccount" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BankAccountID"
        ForeColor="#333333" GridLines="None" Width="600px" DataSourceID="sqlBankAccount">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Bank" HeaderText="Bank" SortExpression="Bank" />
            <asp:BoundField DataField="BankCode" HeaderText="Bank Account Code" SortExpression="BankCode" />
            <asp:BoundField DataField="UserName" HeaderText="Bank Account Name" SortExpression="UserName" />
            <asp:HyperLinkField DataNavigateUrlFields="BankAccountID,BankID,BankCode,UserName" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=E&amp;Bank={1}&amp;Code={2}&amp;User={3}"
                Text="Edit">
                <ItemStyle Width="15px" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="BankAccountID,BankID,BankCode,UserName" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=D&amp;Bank={1}&amp;Code={2}&amp;User={3}"
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
        <asp:SqlDataSource ID="sqlBankAccount" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="SELECT [BankID], [BankAccountID], [BankCode], [UserName], [Bank] FROM [BankAccounts_vw]"></asp:SqlDataSource>
    </p>
</asp:Content>
