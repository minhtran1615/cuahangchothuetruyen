package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CustomerDAO;
import model.Customer;

@WebServlet("/searchCustomer")
public class SearchCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String keyword =
                    request.getParameter("keyword");

            CustomerDAO dao =
                    new CustomerDAO(DBConnection.getConnection());

            List<Customer> list =
                    dao.searchByName(keyword);

            request.setAttribute("customers", list);

            
            request.getRequestDispatcher("/WEB-INF/customer-list.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}