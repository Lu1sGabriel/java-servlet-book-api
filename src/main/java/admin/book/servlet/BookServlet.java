package admin.book.servlet;

import admin.book.DAO.BookDAO;
import admin.book.DAO.BookDAOImplementation;
import admin.book.model.Book;
import utils.ServletActions;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(value = "/books")
@MultipartConfig
public class BookServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    private enum Actions {
        REGISTER,
        EDIT,
        DELETED
    }

    private final Map<Actions, ServletActions> actions = Map.of(
            Actions.REGISTER, this::registerBook,
            Actions.EDIT, this::editBook,
            Actions.DELETED, this::deleteBook
    );

    @Override
    public void init() {
        bookDAO = new BookDAOImplementation();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String actionParam = request.getParameter("action");
            Actions action = Actions.valueOf(actionParam.toUpperCase());
            actions.get(action).execute(request, response);
        } catch (IllegalArgumentException illegalArgumentException) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action not supported");
        }
    }

    private void registerBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession httpSession = request.getSession();
            String adminEmail = (String) httpSession.getAttribute("adminEmail"); // Recupera o email do admin da sessão
            Part part = request.getPart("bimg");
            String fileName = part.getSubmittedFileName();
            String bookName = request.getParameter("bname");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String bookCategory = request.getParameter("categories");
            String bookStatus = request.getParameter("status");

            // Verifica se os campos estão vazios
            if (areFieldsEmpty(bookName, author, price, bookCategory, bookStatus)) {
                setSessionAttributeAndRedirect(request, response, false, "All fields must be filled.", "./auth/admin/books/addBook.jsp");
                return;
            }

            Book book = new Book(bookName, author, new BigDecimal(price), bookCategory, bookStatus, fileName, adminEmail); // Use o email do admin aqui
            boolean isRegistered = bookDAO.insert(book);
            String path = getServletContext().getRealPath("") + "resources" + "\\book";
            File file = new File(path);
            if (isRegistered) {
                if (!file.exists() && !file.mkdirs()) {
                    throw new IOException("Falha na criação de um diretório. \n" + file.getAbsolutePath());
                }
                part.write(path + File.separator + fileName);
                setSessionAttributeAndRedirect(request, response, true, "Book added successfully!", "./auth/admin/books/addBook.jsp");
            } else {
                setSessionAttributeAndRedirect(request, response, false, "Unable to register the book.", "./auth/admin/books/addBook.jsp");
            }
        } catch (SQLException | IOException | ServletException exception) {
            throw new RuntimeException(exception);
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            String bookName = request.getParameter("bname");
            String author = request.getParameter("author");
            String bookPrice = request.getParameter("price");
            String bookStatus = request.getParameter("status");

            // Verifica se os campos estão vazios
            if (areFieldsEmpty(id, bookName, author, bookPrice, bookStatus)) {
                setSessionAttributeAndRedirect(request, response, false, "All fields must be filled.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            BigDecimal price = new BigDecimal(bookPrice);
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                setSessionAttributeAndRedirect(request, response, false, "The price must be greater than zero.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            // Verifica se o preço tem no máximo três dígitos antes da vírgula e duas casas decimais
            String[] parts = bookPrice.split("\\.");
            if (parts[0].length() > 3 || (parts.length > 1 && parts[1].length() > 2)) {
                setSessionAttributeAndRedirect(request, response, false, "The price must have a maximum of three digits before the comma and two decimal places.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            Book book = new Book();
            book.setBookId(Integer.parseInt(id));
            book.setBookName(bookName);
            book.setAuthor(author);
            book.setPrice(price);
            book.setStatus(bookStatus);
            boolean itsUpToDate = bookDAO.edit(book);
            setSessionAttributeAndRedirect(request, response, itsUpToDate, "Book updated successfully!", "The book has not been updated.",
                    "./auth/admin/books/allBooks.jsp");
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            boolean hasBeenDeleted = bookDAO.delete(id);
            setSessionAttributeAndRedirect(request, response, hasBeenDeleted, "The book has been successfully deleted!", "The book has not been deleted.",
                    "./auth/admin/books/allBooks.jsp");
        } catch (SQLException | IOException exception) {
            throw new RuntimeException(exception);
        }
    }

    private boolean areFieldsEmpty(String... fields) {
        for (String field : fields) {
            if (field == null || field.isEmpty()) {
                return true;
            }
        }
        return false;
    }

    private void setSessionAttributeAndRedirect(HttpServletRequest request, HttpServletResponse response, boolean isSuccess,
                                                String message, String redirectPage) throws IOException {
        HttpSession httpSession = request.getSession();
        String attribute = isSuccess ? "successMessage" : "failMessage";
        httpSession.setAttribute(attribute, message);
        response.sendRedirect(redirectPage);
    }

    private void setSessionAttributeAndRedirect(HttpServletRequest request, HttpServletResponse response, boolean condition,
                                                String successMessage, String failMessage, String redirectPage) throws IOException {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute(condition ? "successMessage" : "failMessage", condition ? successMessage : failMessage);
        response.sendRedirect(redirectPage);
    }

}