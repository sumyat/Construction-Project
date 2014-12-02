<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="RoomType.aspx.cs" Inherits="Construction.Admin.RoomType" Title="Room Type" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>RoomType Setup
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
            Description : 
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtDesp" TextMode="multiLine">
                </asp:TextBox><asp:RequiredFieldValidator runat="server" ID="rfvDesp"
                ControlToValidate="txtDesp" Text="*" ErrorMessage="Require Description." >
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
    <asp:GridView ID="gvRoomType" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RoomTypeID"
        ForeColor="#333333" GridLines="None" Width="500px" DataSourceID="sqlRoomType">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:HyperLinkField DataNavigateUrlFields="RoomTypeID,Code,Description" DataNavigateUrlFormatString="?ID={0}&amp;Status=E&amp;Code={1}&amp;Desp={2}"
                Text="Edit">
                <ItemStyle Width="15px" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="RoomTypeID,Code,Description" 
            DataNavigateUrlFormatString="?ID={0}&amp;Status=D&amp;Code={1}&amp;Desp={2}"
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
        <asp:SqlDataSource ID="sqlRoomType" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="Select * From RoomType Where isDelete = 0"></asp:SqlDataSource>
    </p>
</asp:Content>
