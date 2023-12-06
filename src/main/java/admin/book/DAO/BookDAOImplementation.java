package admin.book.DAO;

import admin.book.model.Book;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAOImplementation extends AbstractDAO implements BookDAO {
    private static final String INSERT_SQL = "INSERT INTO \"ebook-app\".book_dtls (bookName, author, price, bookCategory, status, photo, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_BOOKS_SQL = "SELECT bookID, bookName, author, price, bookCategory, status, photo, email FROM \"ebook-app\".book_dtls ORDER BY bookID";
    private static final String SELECT_BOOK_BY_ID_SQL = "SELECT bookID, bookName, author, price, bookCategory, status, photo, email FROM \"ebook-app\".book_dtls WHERE bookID = ?";
    private static final String SELECT_NEW_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE bookCategory = ? and status = ? ORDER BY bookID DESC";
    private static final String SELECT_RECENT_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE status = ? ORDER BY bookID DESC";
    private static final String SELECT_OLD_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE bookCategory = ? and status=? ORDER BY bookID DESC";
    private static final String SELECT_ALL_NEW_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE bookCategory=? ORDER BY bookID DESC";
    private static final String SELECT_ALL_OLD_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE bookCategory=? ORDER BY bookID DESC";
    private static final String SELECT_ALL_RECENT_BOOKS_SQL = "SELECT * FROM \"ebook-app\".book_dtls WHERE status = ? ORDER BY bookID DESC";
    private static final String UPDATE_SQL = "UPDATE \"ebook-app\".book_dtls SET bookName = ?, author = ?, price = ?, status = ? WHERE bookID = ?";
    private static final String DELETE_SQL = "DELETE FROM \"ebook-app\".book_dtls WHERE bookID = ?";

    @Override
    public boolean addBook(Book bookModel) throws SQLException {
        return executeQueryWithParameters(preparedStatement -> preparedStatement.executeUpdate() == 1,
                INSERT_SQL, bookModel.getBookName(), bookModel.getAuthor(), bookModel.getPrice(), bookModel.getBookCategory(),
                bookModel.getStatus(), bookModel.getPhoto(), bookModel.getEmail());
    }

    @Override
    public List<Book> getAllBooks() throws SQLException {
        return executeQuery(SELECT_ALL_BOOKS_SQL, preparedStatement -> {
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                List<Book> bookList = new ArrayList<>();
                while (resultSet.next()) {
                    bookList.add(mapToBookModel(resultSet));
                }
                return bookList;
            }
        });
    }

    @Override
    public Book getBookById(int id) throws SQLException {
        return executeQuery(SELECT_BOOK_BY_ID_SQL, preparedStatement -> {
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapToBookModel(resultSet);
                }
                return null;
            }
        });
    }

    @Override
    public List<Book> getNewBooks() {
        try {
            return executeQuery(SELECT_NEW_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "New Book");
                preparedStatement.setString(2, "Active");
                long count = 1;
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next() && count < 4) {
                        bookList.add(mapToBookModel(resultSet));
                        count++;
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Book> getRecentBooks() {
        try {
            return executeQuery(SELECT_RECENT_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "Active");
                long count = 1;
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next() && count < 4) {
                        bookList.add(mapToBookModel(resultSet));
                        count++;
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Book> getOldBook() {
        try {
            return executeQuery(SELECT_OLD_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "Old Book");
                preparedStatement.setString(2, "Active");
                long count = 1;
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next() & count < 4) {
                        bookList.add(mapToBookModel(resultSet));
                        count++;
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Book> getAllNewBooks() {
        try {
            return executeQuery(SELECT_ALL_NEW_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "New Book");
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next()) {
                        bookList.add(mapToBookModel(resultSet));
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Book> getAllRecentBooks() {
        try {
            return executeQuery(SELECT_ALL_RECENT_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "Active");
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next()) {
                        bookList.add(mapToBookModel(resultSet));
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public List<Book> getAllOldBooks() {
        try {
            return executeQuery(SELECT_ALL_OLD_BOOKS_SQL, preparedStatement -> {
                preparedStatement.setString(1, "Old Book");
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    List<Book> bookList = new ArrayList<>();
                    while (resultSet.next()) {
                        bookList.add(mapToBookModel(resultSet));
                    }
                    return bookList;
                }
            });
        } catch (SQLException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

    @Override
    public boolean editBook(Book bookModel) throws SQLException {
        return executeQuery(UPDATE_SQL, preparedStatement -> {
            preparedStatement.setString(1, bookModel.getBookName());
            preparedStatement.setString(2, bookModel.getAuthor());
            preparedStatement.setBigDecimal(3, bookModel.getPrice());
            preparedStatement.setString(4, bookModel.getStatus());
            preparedStatement.setInt(5, bookModel.getBookId());
            return preparedStatement.executeUpdate() == 1;
        });
    }

    @Override
    public boolean deleteBook(int id) throws SQLException {
        return executeQuery(DELETE_SQL, preparedStatement -> {
            preparedStatement.setInt(1, id);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        });
    }

    private Book mapToBookModel(ResultSet resultSet) throws SQLException {
        Book book = new Book();
        book.setBookId(resultSet.getInt("bookID"));
        book.setBookName(resultSet.getString("bookName"));
        book.setAuthor(resultSet.getString("author"));
        book.setPrice(resultSet.getBigDecimal("price"));
        book.setBookCategory(resultSet.getString("bookCategory"));
        book.setStatus(resultSet.getString("status"));
        book.setPhoto(resultSet.getString("photo"));
        book.setEmail(resultSet.getString("email"));
        return book;
    }
}