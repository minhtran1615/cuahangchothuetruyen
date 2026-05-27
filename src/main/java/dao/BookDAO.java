package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import main.DBConnection;
import model.Book;

public class BookDAO {

    // Lấy tất cả truyện
	public List<Book> getAllBooks() {
	    List<Book> list = new ArrayList<>();

	    try {
	        Connection conn = DBConnection.getConnection();

	        System.out.println("Database đang dùng: " + conn.getCatalog());

	        String sql = "SELECT * FROM books";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Book b = new Book();
	            b.setId(rs.getInt("id"));
	            b.setTitle(rs.getString("title"));
	            b.setAuthor(rs.getString("author"));
	            b.setCategory(rs.getString("category"));
	            b.setQuantity(rs.getInt("quantity"));
	            b.setRentPricePerDay(rs.getInt("rent_price_per_day"));
	            b.setStatus(rs.getString("status"));
	            list.add(b);
	        }

	        System.out.println("Số truyện lấy được: " + list.size());

	        rs.close();
	        ps.close();
	        conn.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

    // Thêm truyện
    public void addBook(Book b) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO books(title, author, category, quantity) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, b.getTitle());
            ps.setString(2, b.getAuthor());
            ps.setString(3, b.getCategory());
            ps.setInt(4, b.getQuantity());

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa truyện
    public void deleteBook(int id) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM books WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy truyện theo ID
    public Book getBookById(int id) {
        Book b = null;

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM books WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                b = new Book();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setCategory(rs.getString("category"));
                b.setQuantity(rs.getInt("quantity"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }

    // Cập nhật truyện
    public void updateBook(Book b) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE books SET title=?, author=?, category=?, quantity=?, rent_price_per_day=?, status=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, b.getTitle());
            ps.setString(2, b.getAuthor());
            ps.setString(3, b.getCategory());
            ps.setInt(4, b.getQuantity());
            ps.setInt(5, b.getRentPricePerDay());
            ps.setString(6, b.getStatus());
            ps.setInt(7, b.getId());

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Tìm kiếm truyện theo tên
    public List<Book> searchBooks(String keyword) {
        List<Book> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM books WHERE title LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book b = new Book();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setCategory(rs.getString("category"));
                b.setQuantity(rs.getInt("quantity"));
                list.add(b);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    //loc theo the loai truyen
    public List<Book> getBooksByCategory(String category) {

        List<Book> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM books WHERE category = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Book b = new Book();

                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setCategory(rs.getString("category"));
                b.setQuantity(rs.getInt("quantity"));
                b.setRentPricePerDay(rs.getInt("rent_price_per_day"));
                b.setStatus(rs.getString("status"));

                list.add(b);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    //thong ke
    public List<String[]> revenueStatistics() {

        List<String[]> list = new ArrayList<>();

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
            	    "SELECT b.category, " +
            	    "SUM(rd.quantity) AS total_rented, " +
            	    "SUM(rd.quantity * b.rent_price_per_day) AS revenue " +
            	    "FROM rental_details rd " +
            	    "JOIN books b ON rd.book_id = b.id " +
            	    "JOIN rentals r ON rd.rental_id = r.id " +
            	    "WHERE r.status = N'đã trả' " +
            	    "GROUP BY b.category " +
            	    "ORDER BY revenue DESC";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                String[] row = new String[3];

                row[0] = rs.getString("category");
                row[1] = rs.getString("total_rented");
                row[2] = rs.getString("revenue");

                list.add(row);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
}