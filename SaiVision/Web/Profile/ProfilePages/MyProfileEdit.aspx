<%@ Page Title="" Language="C#" MasterPageFile="~/ProfilePages/ProfileMain.Master" AutoEventWireup="true" CodeBehind="MyProfileEdit.aspx.cs" Inherits="SaiVision.Web.Profile.ProfilePages.MyProfileEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <table>
        <tr>
            <td>
                <asp:Label ID="lblName" runat="server" Text="Name" />               
            </td>
            <td>
                <asp:TextBox ID="txtName" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblZipCode" Text="Postal Code" runat="server" />               
            </td>
            <td>
                <asp:TextBox ID="txtZipCode" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblColor" Text="Color" runat="server" />               
            </td>
            <td>
                <asp:DropDownList ID="ddlColor" runat="server">
                    <asp:ListItem Text="White" Value="White" />
                    <asp:ListItem Text="Blue" Value="Blue" />
                    <asp:ListItem Text="Yellow" Value="Yellow" />
                    <asp:ListItem Text="Green" Value="Green" />
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
