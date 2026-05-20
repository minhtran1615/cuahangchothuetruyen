<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách truyện</title>

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
        max-width: 1200px;
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
        gap: 15px;
        margin-bottom: 25px;
    }

    .btn-group {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
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

    .btn-rental {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
    }

    .btn-customer {
        background: linear-gradient(135deg, #11998e, #38ef7d);
        color: white;
    }

    .btn-add {
        background: linear-gradient(135deg, #ff512f, #dd2476);
        color: white;
    }

    /* SEARCH BOX */
    .search-box {
        display: flex;
        gap: 10px;
        background: #f5f7fa;
        padding: 8px 10px;
        border-radius: 12px;
        box-shadow: inset 0px 2px 6px rgba(0,0,0,0.1);
    }

    .search-box input {
        border: none;
        outline: none;
        background: transparent;
        padding: 8px;
        width: 220px;
        font-size: 14px;
    }

    .search-box button {
        border: none;
        outline: none;
        padding: 8px 14px;
        border-radius: 10px;
        background: linear-gradient(135deg, #007bff, #00c6ff);
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: 0.25s;
    }

    .search-box button:hover {
        opacity: 0.9;
        transform: scale(1.05);
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

    /* STATUS */
    .status {
        padding: 6px 10px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: bold;
        display: inline-block;
    }

    .status.available {
        background: #d4edda;
        color: #155724;
    }

    .status.unavailable {
        background: #f8d7da;
        color: #721c24;
    }

    /* ACTION BUTTON */
    .action a {
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 10px;
        margin: 0 4px;
        font-weight: bold;
        font-size: 13px;
        transition: 0.2s;
        display: inline-block;
    }

    .edit {
        background: linear-gradient(135deg, #ffb347, #ffcc33);
        color: #2c3e50;
    }

    .delete {
        background: linear-gradient(135deg, #ff416c, #ff4b2b);
        color: white;
    }

    .edit:hover {
        transform: scale(1.08);
    }

    .delete:hover {
        transform: scale(1.08);
    }

    /* RESPONSIVE */
    @media(max-width: 768px) {
        .search-box input {
            width: 150px;
        }

        th, td {
            font-size: 12px;
            padding: 10px;
        }

        h2 {
            font-size: 22px;
        }
    }

</style>

</head>
<body>

<div class="container">

    <h2>📚 DANH SÁCH TRUYỆN TRONG CỬA HÀNG</h2>

    <div class="top-bar">

        <div class="btn-group">
            <a class="btn btn-rental" href="<%=request.getContextPath()%>/rentalReceipts">📄 Quản lý phiếu thuê</a>
            <a class="btn btn-customer" href="<%=request.getContextPath()%>/customers">👤 Quản lý khách hàng</a>
            <a class="btn btn-add" href="<%=request.getContextPath()%>/addBook">➕ Thêm truyện mới</a>
        </div>

        <form class="search-box" action="<%=request.getContextPath()%>/searchBook" method="get">
            <input type="text" name="keyword" placeholder="🔍 Nhập tên truyện..." required>
            <button type="submit">Tìm</button>
        </form>

    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Tên truyện</th>
            <th>Tác giả</th>
            <th>Thể loại</th>
            <th>Số lượng</th>
            <th>Giá thuê/ngày</th>
            <th>Tình trạng</th>
            <th>Hành động</th>
        </tr>

    <%
        List<Book> list = (List<Book>) request.getAttribute("books");

        if(list != null && !list.isEmpty()) {
            for(Book b : list) {
                String status = b.getStatus();
                boolean available = status != null && status.toLowerCase().contains("còn");
    %>

        <tr>
            <td><%=b.getId()%></td>
            <td><%=b.getTitle()%></td>
            <td><%=b.getAuthor()%></td>
            <td><%=b.getCategory()%></td>
            <td><%=b.getQuantity()%></td>
            <td><b><%=b.getRentPricePerDay()%> VNĐ</b></td>

            <td>
                <span class="status <%= available ? "available" : "unavailable" %>">
                    <%=b.getStatus()%>
                </span>
            </td>

            <td class="action">
                <a class="edit" href="<%=request.getContextPath()%>/editBook?id=<%=b.getId()%>">✏️ Sửa</a>

                <a class="delete"
                   href="<%=request.getContextPath()%>/deleteBook?id=<%=b.getId()%>"
                   onclick="return confirm('Bạn có chắc muốn xóa truyện này không?')">
                   🗑 Xóa
                </a>
            </td>
        </tr>

    <%
            }
        } else {
    %>

        <tr>
            <td colspan="8" style="padding:20px; font-weight:bold; color:#666;">
                Không có truyện nào trong thư viện 📭
            </td>
        </tr>

    <%
        }
    %>

    </table>

</div>

</body>
</html>