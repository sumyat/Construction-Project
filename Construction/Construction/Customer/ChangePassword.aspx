<%@ Page Language="C#" MasterPageFile="~/Customer_Master.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Construction.Customer.ChangePassword" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Registration Form 
    </h3>
    <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
    <asp:ValidationSummary runat="server" ForeColor="Red" ID="vlError" />
    <table style="border:double 3px #909090;" cellpadding="10">
        <tr>
            <td>
            Old Password* : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtOPass" TextMode="Password" Width="400px">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1"
                ControlToValidate="txtOPass" Text="*" ErrorMessage="Require Pasword." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            New Password* : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPass" TextMode="Password" Width="400px">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvPass"
                ControlToValidate="txtPass" Text="*" ErrorMessage="Require Pasword." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            Retype Password* : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtRPass" TextMode="Password" Width="400px">
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
</asp:Content>
