package admin.book.DAO;

import admin.book.model.Book;
import user.model.User;
import utils.AbstractDAO;

import java.sql.SQLException;

public class CartDAOImplementation extends AbstractDAO implements CartDAO {
    @Override
    public boolean insertProduct(Book bookModel, User userModel) throws SQLException {
        final String insertSQL = "INSERT INTO public.cart (bookIdFK, userIdFk, book_name, author, price) VALUES (?, ?, ?, ?, ?)";
        return executeQueryWithParameters(statement -> statement.executeUpdate() == 1,
                insertSQL, bookModel.getBookId(), userModel.getId(), bookModel.getBookName(), bookModel.getAuthor(), bookModel.getPrice());
    }

}
