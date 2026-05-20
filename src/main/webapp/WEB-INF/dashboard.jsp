<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<body>
    <h1>Dashboard</h1>
    <h2>Xin chào: ${user}</h2>

    <a href="<%=request.getContextPath()%>/logout">Đăng xuất</a>
</body>
</html>