<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách khách hàng</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #e3f2fd, #fce4ec);
        padding: 40px 0;
        min-height: 100vh;
    }

    .container {
        width: 92%;
        max-width: 1100px;
        margin: auto;
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 18px;
        box-shadow: 0px 10px 30px rgba(0,0,0,0.15);
    }

    h2 {
        text-align: center;
        font-size: 28px;
        font-weight: 800;
        color: #2c3e50;
        margin-bottom: 25px;
        letter-spacing: 1px;
    }

    /* TOP BAR */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 12px;
        margin-bottom: 20px;
    }

    .btn {
        text-decoration: none;
        padding: 10px 16px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 14px;
        transition: 0.25s;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        box-shadow: 0px 4px 12px rgba(0,0,0,0.12);
    }

    .btn:hover {
        transform: translateY(-2px);
        opacity: 0.95;
    }

    .btn-back {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
    }

    .btn-add {
        background: linear-gradient(135deg, #11998e, #38ef7d);
        color: white;
    }

    /* INFO */
    .info {
        margin-bottom: 15px;
        padding: 12px 16px;
        border-radius: 12px;
        background: #f5f7fa;
        box-shadow: inset 0px 2px 6px rgba(0,0,0,0.1);
        font-weight: bold;
        color: #2c3e50;
        width: fit-content;
    }

    /* TABLE */
    table {
        width: 100%;
        border-collapse: collapse;
        overflow: hidden;
        border-radius: 14px;
        box-shadow: 0px 6px 20px rgba(0,0,0,0.12);
    }

    th {
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        color: white;
        padding: 14px;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    td {
        padding: 14px;
        font-size: 14px;
        text-align: center;
        color: #2c3e50;
        border-bottom: 1px solid #eee;
    }

    tr:nth-child(even) {
        background: #f8f9fc;
    }

    tr:hover {
        background: #e3f2fd;
        transition: 0.2s;
    }

    /* DELETE BUTTON */
    .btn-delete {
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 10px;
        font-weight: bold;
        font-size: 13px;
        background: linear-gradient(135deg, #ff416c, #ff4b2b);
        color: white;
        display: inline-block;
        transition: 0.2s;
    }

    .btn-delete:hover {
        transform: scale(1.08);
        opacity: 0.95;
    }

    /* RESPONSIVE */
    @media(max-width: 768px) {
        h2 {
            font-size: 22px;
        }

        th, td {
            font-size: 12px;
            padding: 10px;
        }

        .top-bar {
            flex-direction: column;
            align-items: stretch;
        }

        .btn {
            justify-content: center;
        }
    }

</style>

</head>
<body>

<div class="container">

    <h2>👤 DANH SÁCH KHÁCH HÀNG</h2>

    <div class="top-bar">
        <a class="btn btn-back" href="<%=request.getContextPath()%>/books">⬅ Quay lại danh sách truyện</a>
        <a class="btn btn-add" href="<%=request.getContextPath()%>/addCustomer">➕ Thêm khách hàng</a>
    </div>

    <%
        List<Customer> list = (List<Customer>) request.getAttribute("customers");
    %>

    <div class="info">
        📌 Số lượng khách hàng: <%= (list == null ? 0 : list.size()) %>
    </div>

    <table>
        <tr>
            <th>Mã khách hàng</th>
            <th>Họ tên</th>
            <th>Số điện thoại</th>
            <th>Ngày đăng kí</th>
            <th>Xóa</th>
        </tr>

        <%
            if(list != null && !list.isEmpty()) {
                for(Customer c : list) {
        %>

        <tr>
           <td>MKH<%= c.getCustomerId() %></td>
            <td><%=c.getFullname()%></td>
            <td><%=c.getPhone()%></td>
            <td><%=c.getRegisterDate()%></td>

            <td>
                <a class="btn-delete"
                   href="<%=request.getContextPath()%>/deleteCustomer?id=<%=c.getCustomerId()%>"
                   onclick="return confirm('Bạn có chắc muốn xóa khách hàng này không?');">
                   🗑 Xóa
                </a>
            </td>
        </tr>

        <%
                }
            } else {
        %>

        <tr>
            <td colspan="5" style="padding:20px; font-weight:bold; color:#666;">
                Không có khách hàng nào 📭
            </td>
        </tr>

        <%
            }
        %>

    </table>

</div>

</body>
</html>