<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thống kê doanh thu</title>

<style>

    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family:"Segoe UI",Tahoma,sans-serif;
    }

    body{
        background:linear-gradient(135deg,#e3f2fd,#fce4ec);
        padding:40px 0;
        min-height:100vh;
    }

    .container{
        width:92%;
        max-width:1100px;
        margin:auto;
        background:rgba(255,255,255,0.95);
        padding:30px;
        border-radius:18px;
        box-shadow:0px 10px 30px rgba(0,0,0,0.15);
    }

    h2{
        text-align:center;
        font-size:30px;
        font-weight:800;
        color:#2c3e50;
        margin-bottom:30px;
        letter-spacing:1px;
    }

    /* TOP CARDS */

    .cards{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
        gap:20px;
        margin-bottom:30px;
    }

    .card{
        padding:25px;
        border-radius:18px;
        color:white;
        box-shadow:0px 6px 20px rgba(0,0,0,0.15);
        transition:0.25s;
    }

    .card:hover{
        transform:translateY(-4px);
    }

    .card h3{
        font-size:18px;
        margin-bottom:10px;
    }

    .card p{
        font-size:28px;
        font-weight:bold;
    }

    .blue{
        background:linear-gradient(135deg,#36d1dc,#5b86e5);
    }

    .green{
        background:linear-gradient(135deg,#11998e,#38ef7d);
    }

    .orange{
        background:linear-gradient(135deg,#ff9966,#ff5e62);
    }

    /* TABLE */

    table{
        width:100%;
        border-collapse:collapse;
        overflow:hidden;
        border-radius:14px;
        box-shadow:0px 6px 20px rgba(0,0,0,0.12);
    }

    th{
        background:linear-gradient(135deg,#1e3c72,#2a5298);
        color:white;
        padding:14px;
        font-size:14px;
        text-transform:uppercase;
        letter-spacing:0.5px;
    }

    td{
        padding:14px;
        font-size:14px;
        text-align:center;
        color:#2c3e50;
        border-bottom:1px solid #eee;
    }

    tr:nth-child(even){
        background:#f8f9fc;
    }

    tr:hover{
        background:#e3f2fd;
        transition:0.2s;
    }

    .money{
        font-weight:bold;
        color:#e53935;
    }

    /* BUTTON */

    .btn-back{
        display:inline-block;
        margin-top:25px;
        text-decoration:none;
        padding:12px 18px;
        border-radius:12px;
        background:linear-gradient(135deg,#6a11cb,#2575fc);
        color:white;
        font-weight:bold;
        transition:0.25s;
        box-shadow:0px 4px 12px rgba(0,0,0,0.15);
    }

    .btn-back:hover{
        transform:translateY(-2px);
    }

    /* RESPONSIVE */

    @media(max-width:768px){

        h2{
            font-size:24px;
        }

        th,td{
            font-size:12px;
            padding:10px;
        }

        .card p{
            font-size:22px;
        }
    }

</style>

</head>

<body>

<div class="container">

    <h2>📊 THỐNG KÊ DOANH THU CỬA HÀNG</h2>

    <!-- CARDS -->

    <div class="cards">

        <div class="card blue">

            <h3>📚 Tổng thể loại</h3>

            <p>
                <%= ((List<String[]>)request.getAttribute("statistics")).size() %>
            </p>

        </div>

        <div class="card green">

            <h3>💰 Tổng doanh thu</h3>

            <p>

                <%
                    List<String[]> totalList =
                        (List<String[]>)request.getAttribute("statistics");

                    int totalRevenue = 0;

                    for(String[] row : totalList){

                        totalRevenue += Integer.parseInt(row[2]);
                    }
                %>

                <%= totalRevenue %> VNĐ

            </p>

        </div>

        <div class="card orange">

            <h3>🔥 Thể loại nổi bật</h3>

            <p>

                <%
                    String topCategory = "";

                    if(totalList.size() > 0){
                        topCategory = totalList.get(0)[0];
                    }
                %>

                <%= topCategory %>

            </p>

        </div>

    </div>

    <!-- TABLE -->

    <table>

        <tr>
            <th>Thể loại</th>
            <th>Số lượt thuê</th>
            <th>Doanh thu</th>
        </tr>

        <%
            List<String[]> list =
                (List<String[]>)request.getAttribute("statistics");

            for(String[] row : list){
        %>

        <tr>

            <td><%=row[0]%></td>

            <td><%=row[1]%></td>

            <td class="money">

                <%=row[2]%> VNĐ

            </td>

        </tr>

        <%
            }
        %>

    </table>

    <!-- BACK BUTTON -->

    <a class="btn-back"
       href="<%=request.getContextPath()%>/books">

       ← Quay lại trang chủ

    </a>

</div>

</body>
</html>