package admin.cart.servlet;

import admin.book.DAO.BookDAO;
import admin.book.DAO.BookDAOImplementation;
import admin.cart.DAO.CartDAO;
import admin.cart.DAO.CartDAOImplementation;
import admin.book.model.Book;
import admin.cart.model.Cart;
import user.DAOS.UserDAO;
import user.DAOS.UserDAOImplementation;
import user.model.User;
import utils.ServletActions;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Serial;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(value = "/cart")
public class CartServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private BookDAO bookDAO;
    private UserDAO userDAO;

    private enum Actions {
        ADD_CART,
        DELETE_FROM_CART
    }

    private final Map<Actions, ServletActions> actions = Map.of(
            Actions.ADD_CART, this::addCart,
            Actions.DELETE_FROM_CART, this::deleteFromCart
    );

    @Override
    public void init() {
        cartDAO = new CartDAOImplementation();
        bookDAO = new BookDAOImplementation();
        userDAO = new UserDAOImplementation();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String actionParam = request.getParameter("action");
            Actions action = Actions.valueOf(actionParam.toUpperCase());
            actions.get(action).execute(request, response);
        } catch (IllegalArgumentException illegalArgumentException) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action not supported.");
        }
    }

    private void addCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            Book bookModel = bookDAO.getBookById(Integer.parseInt(request.getParameter("book")));
            User userModel = userDAO.findUserByLogin(request.getParameter("user"));
            boolean hasBeenInserted = cartDAO.insertProduct(bookModel, userModel);
            setSessionAttributeAndRedirect(request, response, hasBeenInserted, "The book has been successfully added to the cart!",
                    "The book was not added to the cart.", "index.jsp");
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }

    }

    private void deleteFromCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            Cart cartModel = cartDAO.getCartById(Integer.parseInt(request.getParameter("cartId")));
            User userModel = userDAO.findUserByLogin(request.getParameter("userObj"));
            boolean hasBeenDeleted = cartDAO.deleteFromCart(cartModel, userModel);
            setSessionAttributeAndRedirect(request, response, hasBeenDeleted, "The book has been successfully deleted from the cart!",
                    "The book was not deleted from the cart.", "cart.jsp");
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void setSessionAttributeAndRedirect(HttpServletRequest request, HttpServletResponse response, boolean condition,
                                                String successMessage, String failMessage, String redirectPage) throws IOException {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute(condition ? "successMessage" : "failMessage", condition ? successMessage : failMessage);
        response.sendRedirect(redirectPage);
    }
}
