<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập nhân viên</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;

            /* Ảnh bìa nền */
            background: url("https://images.unsplash.com/photo-1522202176988-66273c2fd55f")
                        no-repeat center center/cover;
            position: relative;
        }

        /* Lớp phủ tối để chữ dễ nhìn */
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.55);
            z-index: 0;
        }

        .login-container {
            position: relative;
            z-index: 1;
            width: 420px;
            padding: 35px;
            border-radius: 18px;

            /* Glass effect */
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            box-shadow: 0px 10px 30px rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }

        h2 {
            text-align: center;
            margin-bottom: 10px;
            font-size: 26px;
            font-weight: 700;
        }

        .sub-title {
            text-align: center;
            font-size: 14px;
            margin-bottom: 25px;
            opacity: 0.9;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            font-size: 14px;
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            outline: none;
            font-size: 15px;
            background: rgba(255,255,255,0.9);
        }

        input:focus {
            box-shadow: 0px 0px 10px rgba(37,117,252,0.8);
        }

        button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #2575fc, #6a11cb);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.3);
        }

        .error {
            background: rgba(255,0,0,0.2);
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            font-weight: bold;
            color: #ffdddd;
            margin-bottom: 15px;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 13px;
            opacity: 0.85;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 25px;
            }
        }
    </style>
</head>

<body>

<div class="login-container">
    <h2>🔐 Đăng nhập hệ thống</h2>
    <p class="sub-title">Vui lòng nhập tài khoản để tiếp tục</p>

    <%
        String error = (String) request.getAttribute("error");
        if(error != null){
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <form action="<%=request.getContextPath()%>/login" method="post">

        <div class="form-group">
            <label>Tên đăng nhập</label>
            <input type="text" name="username" placeholder="Nhập tên đăng nhập..." required>
        </div>

        <div class="form-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" placeholder="Nhập mật khẩu..." required>
        </div>

        <button type="submit">Đăng nhập</button>
    </form>

    <div class="footer">
        © 2026 Hệ thống quản lý - Nhân viên
    </div>
</div>

</body>
</html>