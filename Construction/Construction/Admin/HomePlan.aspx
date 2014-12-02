<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="HomePlan.aspx.cs" Inherits="Construction.Admin.HomePlan" Title="Home Plan" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="server">
    <h3>Home Plan</h3>
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
                Home Type :
            </td>
            <td>
                 <asp:DropDownList runat="server" ID="ddlType" Width="120px"
                DataSourceID="sqlHomeType" DataTextField="Desp" DataValueField="HomeTypeID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlHomeType" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
            SelectCommand="Select HomeTypeID,Description + ' - ' + Code as Desp From HomeType&#13;&#10;WHERE isDelete = 0"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Name:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtName">
                </asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvName"
                 ControlToValidate="txtName" ErrorMessage="Require Name." Text="*">
                </asp:RequiredFieldValidator>
            </td>
            <td>
                Upload Files :
            </td>
            <td rowspan="3" valign="top">
                <asp:FileUpload ID="fupFile" runat="server"/>
                <asp:Button runat="server" ID="btnUpload" Text="Upload" CausesValidation="false" OnClick="btnUpload_Click" />
                <p align="right">
                    <asp:Image runat="server" ID="imgSample" Height="100px" ImageUrl="~/Image.aspx" />
                </p>
            </td>
        </tr>
        <tr>
            <td>
                Size - W L H: 
            </td>
            <td colspan="2">
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
        <asp:Button runat="server" ID="btnRoom" Text="Add Room" CausesValidation="False" OnClick="btnRoom_Click" />
    </p>
    <p>
        <asp:GridView runat="server" ID="gvRoom" DataKeyNames="Key" Width="700px"
        AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" OnRowCancelingEdit="gvRoom_RowCancelingEdit" 
        OnRowDeleting="gvRoom_RowDeleting" OnRowEditing="gvRoom_RowEditing" 
        OnRowUpdating="gvRoom_RowUpdating" >
            <Columns>
                <asp:TemplateField HeaderText="RoomType">
                    <EditItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlRoomType" Width="120px"
                        DataSourceID="sqlRoomType" DataTextField="Desp" DataValueField="RoomTypeID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sqlRoomType" runat="server" ConnectionString="<%$ ConnectionStrings:Construction %>"
                    SelectCommand="Select RoomTypeID,Description + ' - ' + Code as Desp From RoomType&#13;&#10;WHERE isDelete = 0&#13;&#10;"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblRoom" Text='<%# Eval("RoomName") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size (W * L * H)">
                    <EditItemTemplate>
                         <asp:TextBox runat="server" ID="txtWidth" Text='<%# Eval("Width") %>'
                        Width="30px" ValidationGroup="Room"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="rfvWidth"
                        ControlToValidate="txtWidth" Text="*" InitialValue="0" ValidationGroup="Room">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="cpvWidth" ControlToValidate="txtWidth"
                        Text="*" Operator="dataTypeCheck" Type="integer" ValidationGroup="Room">
                        </asp:CompareValidator> 
                         <asp:TextBox runat="server" ID="txtLength" Text='<%# Eval("Length") %>'
                        Width="30px" ValidationGroup="Room"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="rfvLength"
                        ControlToValidate="txtLength" Text="*" InitialValue="0" ValidationGroup="Room">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="cpvLength" ControlToValidate="txtLength"
                        Text="*" Operator="dataTypeCheck" Type="integer" ValidationGroup="Room">
                        </asp:CompareValidator> 
                        <asp:TextBox runat="server" ID="txtHeight" Text='<%# Eval("Height") %>'
                        Width="30px" ValidationGroup="Room"></asp:TextBox>
                        <asp:CompareValidator runat="server" ID="cpvHeight" ControlToValidate="txtHeight"
                        Text="*" Operator="dataTypeCheck" Type="integer" ValidationGroup="Room">
                        </asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblWidth" Text='<%# Eval("Width") %>'>
                        </asp:Label>X
                        <asp:Label runat="server" ID="lblLength" Text='<%# Eval("Length") %>'>
                        </asp:Label>X
                        <asp:Label runat="server" ID="lblHeight" Text='<%# Eval("Height") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="txtQuantity" Text='<%# Eval("Quantity") %>'
                        Width="50px" ValidationGroup="Room"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="rfvQuantity"
                        ControlToValidate="txtQuantity" Text="*" InitialValue="0"  ValidationGroup="Room">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ID="cpvQuantity" ControlToValidate="txtQuantity"
                        Text="*" Operator="dataTypeCheck" Type="integer" ValidationGroup="Room">
                        </asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblQuantity" Text='<%# Eval("Quantity") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Link" ShowDeleteButton="True" 
                    ShowEditButton="True" ItemStyle-Width="50" ValidationGroup="Room" >
                </asp:CommandField>
                <asp:TemplateField>
                    <EditItemTemplate>
                    </EditItemTemplate>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="center" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#999999" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        </asp:GridView>
    </p>     
     <div width="600px">
        <asp:Button runat="server" ID="btnAdd" Text="Save" OnClick="btnAdd_Click" />
        <asp:Button runat="server" Id="btnCancel" Text="Cancel" CausesValidation="false"
        OnClick="btnCancel_Click" />              
    </div>  
</asp:Content>
