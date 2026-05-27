package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.BookDAO;

@WebServlet("/statistics")
public class StatisticsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        BookDAO dao = new BookDAO();

        req.setAttribute(
            "statistics",
            dao.revenueStatistics()
        );

        req.getRequestDispatcher("/WEB-INF/statistics.jsp")
           .forward(req, resp);
    }
}