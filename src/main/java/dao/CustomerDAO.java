package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

import model.Customer;

public class CustomerDAO {

    private Connection conn;

    public CustomerDAO(Connection conn) {
        this.conn = conn;
    }

    // =========================
    // LẤY DANH SÁCH KHÁCH HÀNG
    // =========================
    public List<Customer> getAllCustomers() {

        List<Customer> list = new ArrayList<>();

        try {

            String sql = "SELECT * FROM customers";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Customer c = new Customer();

                c.setCustomerId(rs.getInt("id"));
                c.setFullname(rs.getString("fullname"));
                c.setPhone(rs.getString("phone"));
                c.setRegisterDate(
                        rs.getDate("registerDate"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // TÌM KIẾM KHÁCH HÀNG
    // =========================
    public List<Customer> searchByName(String keyword) {

        List<Customer> list = new ArrayList<>();

        try {

            String sql =
                "SELECT * FROM customers " +
                "WHERE fullname LIKE ?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Customer c = new Customer();

                c.setCustomerId(rs.getInt("id"));
                c.setFullname(rs.getString("fullname"));
                c.setPhone(rs.getString("phone"));
                c.setRegisterDate(
                        rs.getDate("registerDate"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // XÓA KHÁCH HÀNG
    // =========================
    public boolean deleteCustomer(int id) {

        try {

            String sql =
                    "DELETE FROM customers WHERE id = ?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // THÊM KHÁCH HÀNG
    // =========================
    public boolean insertCustomer(Customer c) {

        try {

            String sql =
                "INSERT INTO customers(fullname, phone, registerDate) " +
                "VALUES (?, ?, ?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, c.getFullname());
            ps.setString(2, c.getPhone());
            ps.setDate(3, c.getRegisterDate());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}