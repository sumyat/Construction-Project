<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Construction.ContactUs" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphBody" runat="server">
<table>
	<tr>
		<td>
			<h2>Construction Company</h2>
			<asp:Image runat="server" ID="imgMap" ImageUrl="~/Style/images/Map.png" AlternateText="No Image"
			ToolTip="Construction Company" Height="400px" />
		</td>
		<td valign="bottom">
			<p>
				<b><u>Address</u></b>
				<address>No.(57) Sagawah Street, Dagon Township, Yangon , Myanmar</address>
			</p>
			<p>
				<b><u>Phone Numbers</u></b>
				<br />
				<br />
				(956)-(01)-350343, (01)-342030, (09)-5129030
			</p>
			<p>
				<b><u>E-mail Address</u></b>
				<br />
				<br />
				administrator@ConstructionCompany.com<br />
				Staff@ConstructionCompany.com
			</p>
			<p>
				<b><u>Fax</u></b>
				<br />
				<br />
				(956)-(01)-342030
			</p>
		</td>
	</tr>
</table>
</asp:Content>
