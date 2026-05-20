<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Invoice" %>
<%@ page import="model.InvoiceItem" %>
<%@ page import="java.util.List" %>

<%
    Invoice invoice = (Invoice) request.getAttribute("invoice");
    List<InvoiceItem> items = invoice.getItems();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn thanh toán</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f4f8;
            padding: 30px;
        }

        .invoice-container {
            max-width: 950px;
            margin: auto;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0px 5px 18px rgba(0,0,0,0.12);
        }

        .header {
            display: flex;
            justify-content: space-between;
            border-bottom: 2px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
            color: #2c3e50;
            font-size: 28px;
        }

        .header p {
            margin: 4px 0;
            color: #555;
        }

        .shop-info {
            font-size: 14px;
            color: #555;
        }

        .invoice-info {
            text-align: right;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-bottom: 25px;
        }

        .info-box {
            background: #f8f9fb;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #e6e6e6;
        }

        .info-box p {
            margin: 6px 0;
            font-size: 14px;
            color: #333;
        }

        .info-box span {
            font-weight: bold;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table thead {
            background: #2c3e50;
            color: white;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            font-size: 14px;
            text-align: center;
        }

        table tbody tr:nth-child(even) {
            background: #f9f9f9;
        }

        .total-section {
            margin-top: 25px;
            display: flex;
            justify-content: flex-end;
        }

        .total-box {
            width: 380px;
            background: #f8f9fb;
            padding: 18px;
            border-radius: 10px;
            border: 1px solid #e6e6e6;
        }

        .total-box p {
            display: flex;
            justify-content: space-between;
            margin: 8px 0;
            font-size: 14px;
        }

        .total-box .grand-total {
            font-size: 17px;
            font-weight: bold;
            color: #e74c3c;
            border-top: 2px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }

        input[type="number"] {
            width: 120px;
            padding: 6px;
            border-radius: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .note-section {
            margin-top: 25px;
        }

        .note-section label {
            font-weight: bold;
            color: #2c3e50;
        }

        .note-section textarea {
            width: 100%;
            margin-top: 8px;
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ccc;
            font-size: 14px;
            resize: none;
            height: 90px;
        }

        .btn-area {
            margin-top: 25px;
            text-align: center;
        }

        .btn-success {
            background: #27ae60;
            color: white;
            padding: 14px 30px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-success:hover {
            background: #1e8449;
        }

        .footer {
            margin-top: 25px;
            text-align: center;
            font-size: 13px;
            color: #777;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }
    </style>
</head>

<body>

<div class="invoice-container">

    <div class="header">
        <div class="shop-info">
            <h1>HÓA ĐƠN THUÊ TRUYỆN</h1>
            <p><strong>Cửa hàng:</strong> Nhà sách / Thuê truyện ABC</p>
            <p><strong>Địa chỉ:</strong> Thanh Hóa</p>
            <p><strong>Hotline:</strong> 0373 894 107</p>
        </div>

        <div class="invoice-info">
            <p><strong>Mã phiếu thuê:</strong> <%= invoice.getInvoiceCode() %></p>
            <p><strong>Ngày lập:</strong> <%= invoice.getCreatedDate() %></p>
            <p><strong>Trạng thái:</strong> <span style="color:orange;font-weight:bold;">Chưa thanh toán</span></p>
        </div>
    </div>

    <div class="info-grid">
        <div class="info-box">
            <p>Mã khách hàng: <span><%= invoice.getCustomerCode() %></span></p>
            <p>Họ tên khách hàng: <span><%= invoice.getCustomerName() %></span></p>
        </div>

        <div class="info-box">
            <p>Mã nhân viên: <span><%= invoice.getStaffCode() %></span></p>
            <p>Nhân viên lập phiếu: <span><%= invoice.getStaffName() %></span></p>
        </div>
    </div>

    <div class="info-grid">
        <div class="info-box">
            <p>Ngày thuê: <span><%= invoice.getRentDate() %></span></p>
        </div>

        <div class="info-box">
            <p>Ngày trả: <span><%= invoice.getReturnDate() %></span></p>
        </div>
    </div>

    <h3 style="color:#2c3e50;margin-bottom:10px;">Danh sách truyện thuê</h3>

    <table>
        <thead>
        <tr>
            <th>Mã truyện</th>
            <th>Tên truyện</th>
            <th>Số lượng</th>
            <th>Đơn giá/ngày</th>
            <th>Thành tiền</th>
        </tr>
        </thead>

        <tbody>
        <%
            for (InvoiceItem item : items) {
        %>
        <tr>
            <td>TR<%= item.getBookId() %></td>
            <td><%= item.getBookTitle() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getPricePerDay() %> đ</td>
            <td><%= item.getMoney() %> đ</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- FORM THANH TOÁN -->
    <form action="<%=request.getContextPath()%>/confirmPayment" method="post" id="paymentForm">
        <input type="hidden" name="selectedIds" value="<%=request.getAttribute("selectedIds")%>">
        <input type="hidden" name="finalTotal" id="finalTotalInput">

        <div class="total-section">
            <div class="total-box">
                <p>
                    <span>Tổng tiền thuê:</span>
                    <span id="rentMoney"><%= invoice.getTotalMoney() %></span> đ
                </p>

                <p>
                    <span>Tiền phạt:</span>
                    <span>
                        <input type="number" id="fineMoney" name="fineMoney" value="0" min="0"> đ
                    </span>
                </p>

                <p class="grand-total">
                    <span>Tổng tiền thanh toán:</span>
                    <span><span id="finalTotal"><%= invoice.getTotalMoney() %></span> đ</span>
                </p>
            </div>
        </div>

        <!-- NOTE -->
        <div class="note-section">
            <label>Ghi chú của nhân viên:</label>
            <textarea name="note" placeholder="Nhập ghi chú (ví dụ: khách trả trễ 2 ngày, truyện bị rách bìa...)"></textarea>
        </div>

        <!-- BUTTON -->
        <div class="btn-area">
            <button type="submit" class="btn-success">
                ✔ Thanh toán thành công
            </button>
        </div>
    </form>

    <div class="footer">
        <p>Xin cảm ơn quý khách đã sử dụng dịch vụ! Hẹn gặp lại.</p>
    </div>

</div>

<script>
    function updateFinalTotal() {
        let rentMoney = parseFloat(document.getElementById("rentMoney").innerText);
        let fineMoney = parseFloat(document.getElementById("fineMoney").value);

        if (isNaN(fineMoney) || fineMoney < 0) {
            fineMoney = 0;
            document.getElementById("fineMoney").value = 0;
        }

        let total = rentMoney + fineMoney;

        document.getElementById("finalTotal").innerText = total;
        document.getElementById("finalTotalInput").value = total;
    }

    document.getElementById("fineMoney").addEventListener("input", updateFinalTotal);

    updateFinalTotal();
</script>

</body>
</html>