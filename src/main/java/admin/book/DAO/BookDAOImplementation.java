package admin.book.DAO;

import admin.book.model.Book;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAOImplementation extends AbstractDAO implements BookDAO {
    @Override
    public boolean addBook(Book bookModel) throws SQLException {
        final String insertSQL = "INSERT INTO public.book_dtls (bookName, author, price, bookCategory, status, photo, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return executeQueryWithParameters(statement -> statement.executeUpdate() == 1,
                insertSQL, bookModel.getBookName(), bookModel.getAuthor(), bookModel.getPrice(), bookModel.getBookCategory(),
                bookModel.getStatus(), bookModel.getPhoto(), bookModel.getEmail());
    }


    @Override
    public List<Book> getAllBooks() throws SQLException {
        final String selectSQL = "SELECT bookID, bookName, author, price, bookCategory, status, photo, email FROM public.book_dtls ORDER BY bookID";
        return executeQuery(selectSQL, statement -> {
            try (ResultSet resultSet = statement.executeQuery()) {
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
        final String selectSQL = "SELECT bookID, bookName, author, price, bookCategory, status, photo, email FROM public.book_dtls WHERE bookID=?";
        return executeQuery(selectSQL, statement -> {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapToBookModel(resultSet);
                }
                return null;
            }
        });
    }

    @Override
    public List<Book> getNewBooks() {
        final String getAllSQL = "SELECT * FROM public.book_dtls WHERE bookCategory=? and status=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllSQL, statement -> {
                statement.setString(1, "New Book");
                statement.setString(2, "Active");
                long count = 1;
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String getAllRecentBooksSQL = "SELECT * FROM public.book_dtls WHERE status=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllRecentBooksSQL, statement -> {
                statement.setString(1, "Active");
                long count = 1;
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String getAllOldBooksSQL = "SELECT * FROM public.book_dtls WHERE bookCategory=? and status=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllOldBooksSQL, statement -> {
                statement.setString(1, "Old Book");
                statement.setString(2, "Active");
                long count = 1;
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String getAllSQL = "SELECT * FROM public.book_dtls WHERE bookCategory=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllSQL, statement -> {
                statement.setString(1, "New Book");
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String getAllRecentBooksSQL = "SELECT * FROM public.book_dtls WHERE status=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllRecentBooksSQL, statement -> {
                statement.setString(1, "Active");
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String getAllOldBooksSQL = "SELECT * FROM public.book_dtls WHERE bookCategory=? ORDER BY bookID DESC";
        try {
            return executeQuery(getAllOldBooksSQL, statement -> {
                statement.setString(1, "Old Book");
                try (ResultSet resultSet = statement.executeQuery()) {
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
        final String updateSQL = "UPDATE public.book_dtls SET bookName=?, author=?, price=?, status=? WHERE bookID=?";
        return executeQuery(updateSQL, statement -> {
            statement.setString(1, bookModel.getBookName());
            statement.setString(2, bookModel.getAuthor());
            statement.setString(3, bookModel.getPrice());
            statement.setString(4, bookModel.getStatus());
            statement.setInt(5, bookModel.getBookId());
            return statement.executeUpdate() == 1;
        });
    }

    @Override
    public boolean deleteBook(int id) throws SQLException {
        final String deleteSQL = "DELETE FROM public.book_dtls WHERE bookID=?";
        return executeQuery(deleteSQL, statement -> {
            statement.setInt(1, id);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected == 1;
        });
    }

    private Book mapToBookModel(ResultSet resultSet) throws SQLException {
        Book book = new Book();
        book.setBookId(resultSet.getInt("bookID"));
        book.setBookName(resultSet.getString("bookName"));
        book.setAuthor(resultSet.getString("author"));
        book.setPrice(resultSet.getString("price"));
        book.setBookCategory(resultSet.getString("bookCategory"));
        book.setStatus(resultSet.getString("status"));
        book.setPhoto(resultSet.getString("photo"));
        book.setEmail(resultSet.getString("email"));
        return book;
    }
}