<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirect...</title>
</head>
<body>

<%
    response.sendRedirect(request.getContextPath() + "/login");
%>

</body>
</html>