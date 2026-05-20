<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Phiếu Thuê</title>

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
            max-width: 750px;
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

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
            color: #2c3e50;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            transition: 0.2s;
        }

        input:focus {
            border-color: #2575fc;
            box-shadow: 0px 0px 6px rgba(37, 117, 252, 0.4);
        }

        /* BOOK AREA */
        .book-area {
            margin-top: 20px;
            padding: 15px;
            border-radius: 14px;
            background: #f8f9fc;
            border: 1px solid #ddd;
        }

        .book-area h3 {
            margin-bottom: 12px;
            color: #2c3e50;
            font-size: 18px;
        }

        .book-row {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }

        .book-row input {
            flex: 1;
        }

        .btn-remove {
            background: #ff4b2b;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 14px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-remove:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }

        .btn-add-book {
            margin-top: 10px;
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            background: linear-gradient(135deg, #36d1dc, #5b86e5);
            color: white;
            font-size: 14px;
            transition: 0.25s;
        }

        .btn-add-book:hover {
            transform: translateY(-2px);
            opacity: 0.95;
        }

        /* BUTTON AREA */
        .btn-area {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
            gap: 12px;
        }

        .btn {
            flex: 1;
            text-decoration: none;
            padding: 12px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            border: none;
            cursor: pointer;
            transition: 0.25s;
            text-align: center;
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

        .btn-save {
            background: linear-gradient(135deg, #11998e, #38ef7d);
            color: white;
        }

        @media(max-width: 600px) {
            .btn-area {
                flex-direction: column;
            }

            .book-row {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h2>➕ THÊM PHIẾU THUÊ</h2>

    <form action="<%=request.getContextPath()%>/addRentalReceipt" method="post">

        <label>Mã khách hàng</label>
        <input type="number" name="customerId" required>

        <label>Mã nhân viên</label>
        <input type="number" name="staffId" required>

        <label>Ngày thuê</label>
        <input type="date" name="rentDate" required>

        <label>Ngày trả</label>
        <input type="date" name="returnDate" required>

        <label>Tổng tiền (VNĐ)</label>
        <input type="number" name="totalMoney" required>

        <!-- KHU VỰC TRUYỆN - SỐ LƯỢNG -->
        <div class="book-area">
            <h3>📚 Truyện thuê - Số lượng</h3>

            <div id="bookList">
                <div class="book-row">
                    <input type="number" name="bookId[]" placeholder="Nhập mã truyện" required>
                    <input type="number" name="quantity[]" placeholder="Nhập số lượng" required min="1">
                    <button type="button" class="btn-remove" onclick="removeRow(this)">X</button>
                </div>
            </div>

            <button type="button" class="btn-add-book" onclick="addBookRow()">
                ➕ Thêm truyện
            </button>
        </div>

        <div class="btn-area">
            <a class="btn btn-back" href="<%=request.getContextPath()%>/rentalReceipts">
                ⬅ Quay lại
            </a>

            <button type="submit" class="btn btn-save">
                💾 Lưu phiếu thuê
            </button>
        </div>

    </form>

</div>

<script>
    function addBookRow() {
        let bookList = document.getElementById("bookList");

        let div = document.createElement("div");
        div.className = "book-row";

        div.innerHTML = `
            <input type="number" name="bookId[]" placeholder="Nhập mã truyện" required>
            <input type="number" name="quantity[]" placeholder="Nhập số lượng" required min="1">
            <button type="button" class="btn-remove" onclick="removeRow(this)">X</button>
        `;

        bookList.appendChild(div);
    }

    function removeRow(btn) {
        let bookList = document.getElementById("bookList");

        // không cho xóa nếu chỉ còn 1 dòng
        if (bookList.children.length === 1) {
            alert("Phải có ít nhất 1 truyện thuê!");
            return;
        }

        btn.parentElement.remove();
    }
</script>

</body>
</html>