package admin.book.DAO;

import admin.book.model.Book;
import user.model.User;

import java.sql.SQLException;

public interface CartDAO {
    boolean insertProduct(Book bookModel, User userModel) throws SQLException;
}
