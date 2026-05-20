<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm truyện mới</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, sans-serif;
    }

    body {
        background: linear-gradient(135deg, #e3f2fd, #fce4ec);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 30px;
    }

    .container {
        width: 100%;
        max-width: 520px;
        background: rgba(255, 255, 255, 0.95);
        padding: 35px;
        border-radius: 18px;
        box-shadow: 0px 12px 35px rgba(0,0,0,0.15);
        animation: fadeIn 0.8s ease-in-out;
        border: 1px solid rgba(0,0,0,0.05);
    }

    .icon {
        font-size: 45px;
        text-align: center;
        display: block;
        margin-bottom: 10px;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #2c3e50;
        font-size: 28px;
        font-weight: 800;
        letter-spacing: 1px;
    }

    label {
        font-weight: 700;
        display: block;
        margin: 14px 0 7px;
        color: #34495e;
        font-size: 14px;
    }

    input {
        width: 100%;
        padding: 12px 14px;
        border-radius: 12px;
        border: 1px solid #dfe6e9;
        outline: none;
        font-size: 14px;
        transition: 0.25s;
        background: #f8f9fc;
    }

    input:focus {
        border-color: #2575fc;
        box-shadow: 0 0 8px rgba(37, 117, 252, 0.35);
        background: white;
        transform: scale(1.01);
    }

    .btn {
        width: 100%;
        padding: 13px;
        margin-top: 22px;
        border: none;
        border-radius: 14px;
        background: linear-gradient(135deg, #ff512f, #dd2476);
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.25s;
        box-shadow: 0px 6px 18px rgba(221, 36, 118, 0.25);
    }

    .btn:hover {
        transform: translateY(-2px);
        opacity: 0.95;
    }

    .btn:active {
        transform: scale(0.98);
    }

    .back {
        display: block;
        text-align: center;
        margin-top: 18px;
        text-decoration: none;
        font-weight: bold;
        color: #2575fc;
        transition: 0.25s;
    }

    .back:hover {
        color: #6a11cb;
        text-decoration: underline;
    }

    .note {
        margin-top: 15px;
        text-align: center;
        font-size: 13px;
        color: #7f8c8d;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(25px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media(max-width: 600px) {
        .container {
            padding: 25px;
        }

        h2 {
            font-size: 22px;
        }
    }
</style>

</head>
<body>

<div class="container">
    <span class="icon">📚</span>
    <h2>THÊM TRUYỆN MỚI</h2>

    <form action="<%=request.getContextPath()%>/addBook" method="post">

        <label> Tên truyện</label>
        <input type="text" name="title" placeholder="Nhập tên truyện..." required>

        <label> Tác giả</label>
        <input type="text" name="author" placeholder="Nhập tên tác giả...">

        <label> Thể loại</label>
        <input type="text" name="category" placeholder="Nhập thể loại truyện...">

        <label> Số lượng</label>
        <input type="number" name="quantity" placeholder="Nhập số lượng..." required min="0">

        <label> Giá thuê/ngày (VNĐ)</label>
        <input type="number" name="rentPricePerDay" placeholder="Nhập giá thuê/ngày..." required min="0">

        <label> Tình trạng truyện</label>
        <input type="text" name="status" placeholder="Ví dụ: Còn hàng / Hết hàng..." required>

        <button type="submit" class="btn">➕ Thêm truyện</button>
    </form>

    <a class="back" href="<%=request.getContextPath()%>/books">⬅ Quay lại danh sách</a>

    <div class="note">
        Hãy nhập đầy đủ thông tin để quản lý truyện hiệu quả 📖
    </div>
</div>

</body>
</html>