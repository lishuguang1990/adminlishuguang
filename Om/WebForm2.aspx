<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="Om.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script>
        $.ajax({
            type: "post",
            url: 'http://linken01.ourmod.net/api/apiactivitychart/geteverymonthaveragecost',
            success: function (data) {
                console.log(data);
            }
        });
         <%
        Response.AddHeader("Access-Control-Allow-Origin","'http://linken01.ourmod.net");
        Response.AddHeader("Access-Control-Allow-Methods","GET,POST,PUT,OPTIONS");
        Response.AddHeader("Access-Control-Allow-Credentials","true");
    %>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
