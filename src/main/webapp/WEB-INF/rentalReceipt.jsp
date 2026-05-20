<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.RentalReceipt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Phiếu Thuê Truyện</title>

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
            border: none;
            cursor: pointer;
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

        .btn-pay {
            background: linear-gradient(135deg, #f7971e, #ffd200);
            color: #2c3e50;
            font-size: 16px;
            padding: 12px 20px;
            font-weight: 800;
        }

        /* INFO + SEARCH BAR */
        .info-search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 15px;
        }

        .info {
            padding: 12px 16px;
            border-radius: 12px;
            background: #f5f7fa;
            box-shadow: inset 0px 2px 6px rgba(0,0,0,0.1);
            font-weight: bold;
            color: #2c3e50;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-box input {
            width: 250px;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            transition: 0.2s;
        }

        .search-box input:focus {
            border-color: #2575fc;
            box-shadow: 0px 0px 6px rgba(37, 117, 252, 0.4);
        }

        .btn-search {
            background: linear-gradient(135deg, #36d1dc, #5b86e5);
            color: white;
            font-weight: bold;
            padding: 10px 16px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.15);
            transition: 0.25s;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            opacity: 0.95;
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

        /* MONEY */
        .money {
            font-weight: bold;
            color: #e74c3c;
        }

        /* DELETE BUTTON */
        .btn-delete {
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-delete:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }

        /* TOTAL MONEY BOX */
        .total-box {
            margin-top: 20px;
            padding: 14px 18px;
            border-radius: 14px;
            background: #fff3cd;
            border: 2px solid #ffeeba;
            font-size: 18px;
            font-weight: bold;
            color: #856404;
            text-align: center;
        }

        /* PAYMENT BAR */
        .pay-bar {
            margin-top: 18px;
            display: flex;
            justify-content: center;
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

            .info-search-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                width: 100%;
            }

            .search-box input {
                flex: 1;
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h2>📄 DANH SÁCH PHIẾU THUÊ TRUYỆN</h2>

    <div class="top-bar">
        <a class="btn btn-back" href="<%=request.getContextPath()%>/books">
            ⬅ Quay lại danh sách truyện
        </a>

        <a class="btn btn-add" href="<%=request.getContextPath()%>/addRentalReceipt">
            ➕ Tạo phiếu thuê
        </a>
    </div>

    <%
        List<RentalReceipt> list = (List<RentalReceipt>) request.getAttribute("listRentalReceipts");
    %>

    <!-- INFO + SEARCH CÙNG HÀNG -->
    <div class="info-search-bar">
        <div class="info">
            📌 Tổng số phiếu thuê: <%= (list == null ? 0 : list.size()) %>
        </div>

        <div class="search-box">
            <input type="text" id="searchCustomer" placeholder="Nhập mã khách hàng (VD: 5 hoặc MKH5)">
            <button type="button" class="btn-search" onclick="searchRental()">
                🔍 Tìm
            </button>
        </div>
    </div>

    <!-- FORM THANH TOÁN -->
    <form id="payForm" action="<%=request.getContextPath()%>/payRentalReceipts" method="post">
        <input type="hidden" name="selectedIds" id="selectedIds">

        <table>
            <tr>
                <th>Chọn</th>
                <th>Mã phiếu thuê</th>
                <th>Mã khách hàng</th>
                <th>Mã nhân viên</th>
                <th>Ngày thuê</th>
                <th>Ngày trả</th>
                <th>Mã Truyện thuê-Số Lượng</th>
                <th>Tổng tiền</th>
                <th>Xóa</th>
            </tr>

            <%
                if (list != null && !list.isEmpty()) {
                    for (RentalReceipt r : list) {
            %>
            <tr>
                <td>
                    <input type="checkbox"
                           class="chkReceipt"
                           value="<%= r.getRentalId() %>"
                           data-money="<%= r.getTotalMoney() %>">
                </td>

                <td>MPT<%= r.getRentalId() %></td>
                <td class="customerId">MKH<%= r.getCustomerId() %></td>
                <td><%= r.getStaffId() %></td>
                <td><%= r.getRentDate() %></td>
                <td><%= r.getReturnDate() %></td>

                <td style="text-align:left; font-weight:bold; color:#34495e;">
                    <%= r.getBookInfo() %>
                </td>

                <td class="money"><%= r.getTotalMoney() %> VNĐ</td>

                <td>
                    <a class="btn-delete"
                       href="<%=request.getContextPath()%>/deleteRentalReceipt?id=<%=r.getRentalId()%>"
                       onclick="return confirm('Bạn có chắc muốn xóa phiếu thuê này không?');">
                        ❌ Xóa
                    </a>
                </td>
            </tr>

            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9" style="padding:20px; font-weight:bold; color:#666;">
                    Không có phiếu thuê nào 📭
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <!-- DÒNG HIỂN THỊ TỔNG TIỀN -->
        <div class="total-box">
            💰 Tổng tiền thanh toán: <span id="totalMoney">0</span> VNĐ
        </div>

        <!-- NÚT THANH TOÁN -->
        <div class="pay-bar">
            <button type="submit" class="btn btn-pay">
                💳 Thanh toán
            </button>
        </div>

    </form>

</div>

<script>
    function formatMoney(number) {
        return number.toLocaleString("vi-VN");
    }

    function updateTotalMoney() {
        let total = 0;

        document.querySelectorAll(".chkReceipt").forEach(chk => {
            if (chk.checked) {
                total += parseFloat(chk.dataset.money);
            }
        });

        document.getElementById("totalMoney").innerText = formatMoney(total);
    }

    document.querySelectorAll(".chkReceipt").forEach(chk => {
        chk.addEventListener("change", updateTotalMoney);
    });

    document.getElementById("payForm").addEventListener("submit", function(e) {

        let selected = [];

        document.querySelectorAll(".chkReceipt").forEach(chk => {
            if (chk.checked) {
                selected.push(chk.value);
            }
        });

        if (selected.length === 0) {
            alert("Bạn chưa chọn phiếu thuê nào để thanh toán!");
            e.preventDefault();
            return;
        }

        document.getElementById("selectedIds").value = selected.join(",");
    });

    // HÀM TÌM KIẾM THEO MÃ KHÁCH HÀNG
    function searchRental() {
        let keyword = document.getElementById("searchCustomer").value.trim().toLowerCase();
        let rows = document.querySelectorAll("table tr");

        for (let i = 1; i < rows.length; i++) {
            let customerCell = rows[i].querySelector(".customerId");

            if (customerCell) {
                let customerText = customerCell.innerText.toLowerCase();

                if (customerText.includes(keyword)) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }

    // ENTER cũng tìm
    document.getElementById("searchCustomer").addEventListener("keyup", function(e) {
        if (e.key === "Enter") {
            searchRental();
        }
    });
</script>

</body>
</html>