package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.BookDAO;
import model.Book;

@WebServlet("/filterCategory")
public class FilterCategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String category = req.getParameter("category");

        BookDAO dao = new BookDAO();

        List<Book> list;

        // xử lý lọc thể loại
        if(category == null || category.equals("all")) {

            list = dao.getAllBooks();

        } else {

            list = dao.getBooksByCategory(category);
        }

        req.setAttribute("books", list);

        req.getRequestDispatcher("/WEB-INF/book-list.jsp")
           .forward(req, resp);
    }
}