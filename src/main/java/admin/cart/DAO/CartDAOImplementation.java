package admin.cart.DAO;

import admin.book.model.Book;
import admin.cart.model.Cart;
import user.model.User;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImplementation extends AbstractDAO implements CartDAO {
    private static final String INSERT_SQL = "INSERT INTO \"ebook-app\".cart (bookIdFK, userIdFk, book_name, author, price) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_SQL = "SELECT c.cartId, c.bookIdFK, c.userIdFk, b.bookName, b.photo, b.price FROM \"ebook-app\".cart c JOIN \"ebook-app\".book_dtls b ON c.bookIdFK = b.bookID WHERE c.userIdFk = ?";
    private static final String DELETE_SQL = "DELETE FROM \"ebook-app\".cart WHERE cartId = ? AND userIdFk = ?";
    private static final String SELECT_SQL = "SELECT c.*, b.bookName, b.photo FROM \"ebook-app\".cart c JOIN \"ebook-app\".book_dtls b ON c.bookIdFK = b.bookID WHERE c.cartid = ?";

    @Override
    public boolean insertProduct(Book bookModel, User userModel) {
        try {
            return executeQueryWithParameters(statement -> statement.executeUpdate() == 1,
                    INSERT_SQL, bookModel.getBookId(), userModel.getId(), bookModel.getBookName(), bookModel.getAuthor(), bookModel.getPrice());
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Cart> getCart(User userModel) {
        try {
            return executeQuery(GET_SQL, statement -> {
                statement.setInt(1, userModel.getId());
                return getCartListFromResultSet(statement.executeQuery());
            });
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteFromCart(Cart cartModel, User userModel) {
        try {
            return executeQuery(DELETE_SQL, statement -> {
                statement.setInt(1, cartModel.getCartId());
                statement.setInt(2, userModel.getId());
                return statement.executeUpdate() == 1;
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public Cart getCartById(int cartModel) {
        try {
            return executeQuery(SELECT_SQL, statement -> {
                statement.setInt(1, cartModel);
                ResultSet resultSet = statement.executeQuery();
                return resultSet.next() ? mapToCartModel(resultSet) : null;
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    private List<Cart> getCartListFromResultSet(ResultSet resultSet) throws SQLException {
        List<Cart> cartList = new ArrayList<>();
        while (resultSet.next()) {
            cartList.add(mapToCartModel(resultSet));
        }
        return cartList;
    }

    private Cart mapToCartModel(ResultSet resultSet) throws SQLException {
        Cart cartModel = new Cart();
        Book bookModel = new Book();
        User userModel = new User();

        cartModel.setCartId(resultSet.getInt("cartId"));

        bookModel.setBookId(resultSet.getInt("bookIdFK"));
        bookModel.setBookName(resultSet.getString("bookName"));
        bookModel.setPhoto(resultSet.getString("photo"));
        bookModel.setPrice(resultSet.getBigDecimal("price"));

        userModel.setId(resultSet.getInt("userIdFk"));

        cartModel.setBookModel(bookModel);
        cartModel.setUserModel(userModel);

        return cartModel;
    }
}
