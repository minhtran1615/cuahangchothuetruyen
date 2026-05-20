package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.RentalReceipt;

public class RentalReceiptDAO {

    private Connection conn;

    public RentalReceiptDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy danh sách phiếu thuê (CHỈ LẤY PHIẾU ĐANG THUÊ)
    public List<RentalReceipt> getAllRentalReceipts() {
        List<RentalReceipt> list = new ArrayList<>();

        try {
            String sql =
                    "SELECT r.id, r.customer_id, r.staff_id, r.rent_date, r.return_date, r.total_money, " +
                    "STRING_AGG(CONCAT('MT', rd.book_id, '(SL:', rd.quantity, ')'), ', ') AS bookInfo " +
                    "FROM rentals r " +
                    "LEFT JOIN rental_details rd ON r.id = rd.rental_id " +
                    "WHERE r.status = N'đang thuê' " +
                    "GROUP BY r.id, r.customer_id, r.staff_id, r.rent_date, r.return_date, r.total_money " +
                    "ORDER BY r.id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RentalReceipt r = new RentalReceipt();
                r.setRentalId(rs.getInt("id"));
                r.setCustomerId(rs.getInt("customer_id"));
                r.setStaffId(rs.getInt("staff_id"));
                r.setRentDate(rs.getDate("rent_date"));
                r.setReturnDate(rs.getDate("return_date"));
                r.setTotalMoney(rs.getDouble("total_money"));

                r.setBookInfo(rs.getString("bookInfo"));

                list.add(r);
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm phiếu thuê vào bảng rentals và trả về rentalId mới tạo
    public int insertRentalReceiptReturnId(RentalReceipt r) {
        int rentalId = 0;

        try {
            String sql =
                    "INSERT INTO rentals (customer_id, staff_id, rent_date, return_date, status, total_money) " +
                    "VALUES (?, ?, ?, ?, N'đang thuê', ?)";

            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, r.getCustomerId());
            ps.setInt(2, r.getStaffId());
            ps.setDate(3, r.getRentDate());
            ps.setDate(4, r.getReturnDate());
            ps.setDouble(5, r.getTotalMoney());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                rentalId = rs.getInt(1);
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rentalId;
    }

    // Thêm chi tiết phiếu thuê vào bảng rental_details
    public void insertRentalDetail(int rentalId, int bookId, int quantity) {

        try {
            String sql = "INSERT INTO rental_details (rental_id, book_id, quantity) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rentalId);
            ps.setInt(2, bookId);
            ps.setInt(3, quantity);

            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa phiếu thuê theo id (phải xóa chi tiết trước)
    public void deleteRentalReceipt(int id) {

        try {
            // Xóa chi tiết phiếu thuê trước
            String sqlDetail = "DELETE FROM rental_details WHERE rental_id = ?";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            psDetail.setInt(1, id);
            psDetail.executeUpdate();
            psDetail.close();

            // Xóa phiếu thuê
            String sqlRental = "DELETE FROM rentals WHERE id = ?";
            PreparedStatement psRental = conn.prepareStatement(sqlRental);
            psRental.setInt(1, id);
            psRental.executeUpdate();
            psRental.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update trạng thái đã trả (khi thanh toán)
    public void updateStatusPaid(String selectedIds) {

        try {
            String sql = "UPDATE rentals SET status = N'đã trả' WHERE id IN (" + selectedIds + ")";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}