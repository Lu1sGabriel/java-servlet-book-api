package admin.book.DAO;

import admin.book.model.Book;

import java.sql.SQLException;
import java.util.List;

public interface BookDAO {
    boolean insert(Book bookModel) throws SQLException;

    List<Book> getAll() throws SQLException;

    Book getById(int id) throws SQLException;

    boolean edit(Book bookModel) throws SQLException;

    boolean delete(int id) throws SQLException;

    List<Book> getNewBooks();

    List<Book> getRecentBooks();

    List<Book> getOldBook();

    List<Book> getAllNewBooks();

    List<Book> getAllRecentBooks();

    List<Book> getAllOldBooks();

}