package admin.book.DAO;

import admin.book.model.Book;

import java.sql.SQLException;
import java.util.List;

public interface BookDAO {
    boolean addBook(Book bookModel) throws SQLException;

    List<Book> getAllBooks() throws SQLException;

    Book getBookById(int id) throws SQLException;

    boolean editBook(Book bookModel) throws SQLException;

    boolean deleteBook(int id) throws SQLException;

    List<Book> getAllNewBooks();
    List<Book> getAllRecentBooks();
    List<Book> getAllOldBooks();
}
