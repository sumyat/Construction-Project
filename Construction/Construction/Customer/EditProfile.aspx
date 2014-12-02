<%@ Page Language="C#" MasterPageFile="~/Customer_Master.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="Construction.Customer.EditProfile" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Registration Form 
    </h3>
    <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
    <asp:ValidationSummary runat="server" ForeColor="Red" ID="vlError" />
    <table style="border:double 3px #909090;" cellpadding="10">
        <tr>
            <td>
            Full Name* :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtFirstName" Width="180px">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1"
                ControlToValidate="txtFirstName" Text="*" ErrorMessage="Require First Name." >
                </asp:RequiredFieldValidator> 
                <asp:TextBox runat="server" ID="txtLastName" Width="180px">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                NRC No.* :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtNRC" Width="400px">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2"
                ControlToValidate="txtNRC" Text="*" ErrorMessage="Require NRC number." >
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                E-mail* :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail" Width="400px">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3"
                ControlToValidate="txtEmail" Text="*" ErrorMessage="Require Email address." >
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
            <td colspan="2">
            <hr />
            </td>
        </tr>
        <tr>
            <td>
                Address :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtAddress" TextMode="MultiLine" Width="400px">
                </asp:TextBox>   
            </td>
        </tr>
        <tr>
            <td>
                Division / Township :
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlDS" Width="200px"
                DataSourceID="sqlDivsionState" DataTextField="Desp" DataValueField="DivisionStateID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDivsionState" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>" 
                SelectCommand="SELECT DivisionStateID,Code + ' | ' + Description as Desp From DivisionStates WHERE isDelete = 0">
                </asp:SqlDataSource> / 
                <asp:DropDownList runat="server" ID="ddlTC" Width="200px"
                DataSourceID="sqlCityTownship" DataTextField="Desp" DataValueField="CityTownshipID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlCityTownship" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>" 
                SelectCommand="Select CityTownshipID,Code + ' | ' + Description as Desp From CityTownship WHERE isDelete = 0">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Phone No.(s) :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPhone" Width="300px">
                </asp:TextBox> <i>"," per phone</i>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <hr />
            </td>
        </tr>
         <tr>
            <td colspan="2">
                Other Infomration: <br />
                <asp:TextBox runat="server" ID="txtRemark" TextMode="MultiLine" Width="530px" Height="100px">
                </asp:TextBox>   
            </td>
        </tr>
    </table>     
        <i>Note: "*" is a require field.</i>
    <p>
    <asp:Button runat="server" ID="btnAdd" Text="Update" OnClick="btnAdd_Click" />
    <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
    OnClick="btnCancel_Click" />              
    </p>
</asp:Content>
