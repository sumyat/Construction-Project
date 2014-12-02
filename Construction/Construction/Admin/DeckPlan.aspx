<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="DeckPlan.aspx.cs" Inherits="Construction.Admin.DeckPlan" Title="Deck Plan" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Deck Plan</h3>
    <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
    <asp:ValidationSummary runat="server" ForeColor="red" ID="vlError" />
    <table style="border:double 3px #303e3d;" cellpadding="10px">
        <tr>
            <td width="100">
                Code :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtCode">
                </asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvCode"
                 ControlToValidate="txtCode" ErrorMessage="Require Code." Text="*">
                </asp:RequiredFieldValidator>
            </td>
            <td>
                Name:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtName">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvName"
                 ControlToValidate="txtName" ErrorMessage="Require Name." Text="*">
                </asp:RequiredFieldValidator>
            </td>
            <td rowspan="3" valign="top" style="border-left:double 3px #303e3d;padding-left:10px;">
                <p>
                    Upload Files:
                </p>
                <p>
                    <asp:FileUpload ID="fupFile" runat="server"/>
                    <asp:Button runat="server" ID="btnUpload" Text="Upload" CausesValidation="false" OnClick="btnUpload_Click" />
                </p>
                <p>
                    <asp:Image runat="server" ID="imgSample" Height="100px" ImageUrl="~/Image.aspx" />
                </p>
            </td>
        </tr>
        <tr>
            <td>
                Size - W L H: 
            </td>
            <td colspan="3">
                <asp:TextBox runat="server" ID="txtWidth" Width="50px" Text="0">
                </asp:TextBox>
                <asp:CompareValidator runat="server" ID="cpvWidth" ControlToValidate="txtWidth"
                Type="integer" Operator="dataTypeCheck" Text="*" ErrorMessage="Width must be number" >
                </asp:CompareValidator>
                 X <asp:TextBox runat="server" ID="txtLength" Width="50px" Text="0">
                </asp:TextBox><asp:CompareValidator runat="server" ID="CompareValidator1" ControlToValidate="txtLength"
                Type="integer" Operator="dataTypeCheck" Text="*" ErrorMessage="Width must be number">
                </asp:CompareValidator> X 
                <asp:TextBox runat="server" ID="txtHeight" Width="50px" Text="0">
                </asp:TextBox><asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtHeight"
                Type="integer" Operator="dataTypeCheck" Text="*" ErrorMessage="Width must be number">
                </asp:CompareValidator>
                (ft)
            </td>
        </tr>
        <tr>
            <td>
                Description :
            </td>
            <td colspan="3">
                <asp:TextBox runat="server" ID="txtDesp" TextMode="multiLine" Width="300px" >
                </asp:TextBox>
            </td>
        </tr>
    </table> 
    <p>
    <asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" />
    <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
    OnClick="btnCancel_Click" />              
    </p>     
    <p>
    <asp:GridView ID="gvDeckPlan" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" 
        ForeColor="#333333" GridLines="None" Width="800px" DataSourceID="sqlDeckPlan">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="PlanSize" HeaderText="Size" SortExpression="PlanSize" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:HyperLinkField DataNavigateUrlFields="PlanID" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=E"
                Text="Edit">
                <ItemStyle Width="15px" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="PlanID" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=D"
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
        <asp:SqlDataSource ID="sqlDeckPlan" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="Select PlanID,Code,Name,PlanSize = (str(Width) + ' X ' + str(Length) + ' X ' + str(Height)),Description&#13;&#10;From Plans&#13;&#10;WHERE PlanType = 'D' AND &#13;&#10;isDelete = 0"></asp:SqlDataSource>
    </p>
</asp:Content>
