<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm khách hàng</title>

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

    .btn-group {
        margin-top: 22px;
        display: flex;
        justify-content: space-between;
        gap: 12px;
    }

    .btn {
        flex: 1;
        text-align: center;
        padding: 12px;
        border: none;
        border-radius: 14px;
        font-weight: bold;
        cursor: pointer;
        font-size: 15px;
        transition: 0.25s;
        text-decoration: none;
        display: inline-block;
    }

    .btn-back {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
        box-shadow: 0px 6px 18px rgba(37, 117, 252, 0.25);
    }

    .btn-save {
        background: linear-gradient(135deg, #11998e, #38ef7d);
        color: white;
        box-shadow: 0px 6px 18px rgba(56, 239, 125, 0.25);
    }

    .btn:hover {
        transform: translateY(-2px);
        opacity: 0.95;
    }

    .btn:active {
        transform: scale(0.98);
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

        .btn-group {
            flex-direction: column;
        }
    }
</style>

</head>
<body>

<div class="container">

    <span class="icon">👤</span>
    <h2>THÊM KHÁCH HÀNG</h2>

    <form action="<%=request.getContextPath()%>/addCustomer" method="post">

        <label>📌 Họ tên</label>
        <input type="text" name="fullname" required placeholder="Nhập họ tên khách hàng">

        <label>📞 Số điện thoại</label>
        <input type="text" name="phone" required placeholder="Nhập số điện thoại">

        <label>📅 Ngày đăng kí</label>
        <input type="date" name="registerDate" required>

        <div class="btn-group">
            <a class="btn btn-back" href="<%=request.getContextPath()%>/customers">⬅ Quay lại</a>
            <button class="btn btn-save" type="submit">💾 Lưu khách hàng</button>
        </div>

    </form>

    <div class="note">
        Vui lòng nhập đúng thông tin khách hàng để quản lý hiệu quả ✨
    </div>

</div>

</body>
</html>