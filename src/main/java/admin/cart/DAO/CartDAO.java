package admin.cart.DAO;

import admin.book.model.Book;
import admin.cart.model.Cart;
import user.model.User;

import java.sql.SQLException;
import java.util.List;

public interface CartDAO {
    boolean insertProduct(Book bookModel, User userModel) throws SQLException;

    List<Cart> getCart(User userModel) throws SQLException;

    boolean deleteFromCart(Cart cartModel, User userModel) throws SQLException;

    Cart getCartById(int cartId) throws SQLException;
}
