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
            String bname = request.getParameter("bname");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String categories = request.getParameter("categories");
            String status = request.getParameter("status");

            // Verifica se os campos estão vazios
            if (bname == null || bname.isEmpty() || author == null || author.isEmpty() || price == null || price.isEmpty() ||
                    categories == null || categories.isEmpty() || status == null || status.isEmpty()) {
                httpSession.setAttribute("failMessage", "All fields must be filled.");
                response.sendRedirect("./auth/admin/books/addBook.jsp");
                return;
            }

            Book book = new Book(bname, author, new BigDecimal(price), categories, status, fileName, adminEmail); // Use o email do admin aqui
            boolean isRegistered = bookDAO.addBook(book);
            String path = getServletContext().getRealPath("") + "resources" + "\\book";
            File file = new File(path);
            if (isRegistered) {
                if (!file.exists() && !file.mkdirs()) {
                    throw new IOException("Falha na criação de um diretório. \n" + file.getAbsolutePath());
                }
                part.write(path + File.separator + fileName);
                httpSession.setAttribute("successMessage", "Book added successfully!");
            } else {
                httpSession.setAttribute("failMessage", "Unable to register the book.");
            }
            response.sendRedirect("./auth/admin/books/addBook.jsp");
        } catch (SQLException | IOException | ServletException e) {
            throw new RuntimeException(e);
        }
    }


    private void editBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            String bname = request.getParameter("bname");
            String author = request.getParameter("author");
            String priceParam = request.getParameter("price");
            String status = request.getParameter("status");

            // Verifica se os campos estão vazios
            if (id == null || id.isEmpty() || bname == null || bname.isEmpty() || author == null || author.isEmpty() ||
                    priceParam == null || priceParam.isEmpty() || status == null || status.isEmpty()) {
                setSessionAttributeAndRedirect(request, response, false,
                        null, "All fields must be filled.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            BigDecimal price = new BigDecimal(priceParam);
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                setSessionAttributeAndRedirect(request, response, false,
                        null, "The price must be greater than zero.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            // Verifica se o preço tem no máximo três dígitos antes da vírgula e duas casas decimais
            String[] parts = priceParam.split("\\.");
            if (parts[0].length() > 3 || (parts.length > 1 && parts[1].length() > 2)) {
                setSessionAttributeAndRedirect(request, response, false,
                        null, "The price must have a maximum of three digits before the comma and two decimal places.",
                        "./auth/admin/books/editBook.jsp?id=" + id);
                return;
            }

            Book book = new Book();
            book.setBookId(Integer.parseInt(id));
            book.setBookName(bname);
            book.setAuthor(author);
            book.setPrice(price);
            book.setStatus(status);
            boolean itsUpToDate = bookDAO.editBook(book);
            setSessionAttributeAndRedirect(request, response, itsUpToDate,
                    "Book updated successfully!", "The book has not been updated.",
                    "./auth/admin/books/allBooks.jsp");
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            boolean hasBeenDeleted = bookDAO.deleteBook(id);
            setSessionAttributeAndRedirect(request, response, hasBeenDeleted,
                    "The book has been successfully deleted!", "The book has not been deleted.",
                    "./auth/admin/books/allBooks.jsp");
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