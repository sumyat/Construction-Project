<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Construction._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Construction</title>
    <script type="text/javascript" src="Script/script.js"></script>
    <link rel="stylesheet" href="Style/style.css" type="text/css" media="screen" />
</head>
<body>
<form runat="server" id="frm">
<div class="PageBackgroundSimpleGradient">
    </div>
    <div class="PageBackgroundGlare">
        <div class="PageBackgroundGlareImage"></div>
    </div>
    <div class="Main">
        <div class="Sheet">
            <div class="Sheet-tl"></div>
            <div class="Sheet-tr"></div>
            <div class="Sheet-bl"></div>
            <div class="Sheet-br"></div>
            <div class="Sheet-tc"></div>
            <div class="Sheet-bc"></div>
            <div class="Sheet-cl"></div>
            <div class="Sheet-cr"></div>
            <div class="Sheet-cc"></div>
            <div class="Sheet-body">
                <div class="Header">
                    <div class="Header-png"></div>
                    <div class="Header-jpeg" style="left: 0px; top: 0px"></div>
                    <div class="logo" style="left: 10px; top: 42px">
                    </div> 
                </div>
                <div class="nav">
                </div>
                <div class="contentLayout">
                    <div class="content" style="width:500px;">
                        <h2>Login</h2>
                        <asp:Label runat="server" ID="lblMessage" ForeColor="Red"></asp:Label>
                        <asp:ValidationSummary runat="server" ForeColor="Red" ID="vlError" />
                        <fieldset>
                            <legend style="font-weight:bold;">User Information</legend>
                            <table cellspacing="10px" cellpadding="10px">
                            <tr>
                                <td>
                                    User Type
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlType" Width="200px">
                                        <asp:ListItem value="C">Customer</asp:ListItem>
                                        <asp:ListItem value="S">Staff</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    User Name
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtName" Width="200px">
                                    </asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Password 
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPassword" Width="200px" TextMode="password">
                                    </asp:TextBox>
                                </td>
                            </tr>
                       </table>
                       <p>
                        Please enter your username and password.<asp:HyperLink runat="server" ID="hlkRegister"
                        NavigateUrl="~/Registration.aspx" > Register
                        </asp:HyperLink> if you don't have an account. 
                        </p>
                        </fieldset>
                        <p align="right">
                        <asp:Button runat="server" ID="btnLogin" Text="Login" OnClick="Login_Click" />
                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" OnClick="Cancel_Click" />
                       </p>
                    </div>
                </div>
                <div class="cleared"></div><div class="Footer">
                    <div class="Footer-inner">
                        <div class="Footer-text">
                            <p>
                                Copyright &copy; 2011 ---. All Rights Reserved.</p>
                        </div>
                    </div>
                    <div class="Footer-background"></div>
                </div>
            </div>
        </div>
        <div class="cleared"></div>
        <p class="page-footer"></p>
    </div>
</form>
</body>
</html>
