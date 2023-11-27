package admin.book.servlet;

import admin.book.DAO.BookDAOImplementation;
import admin.book.DAO.BookDAO;
import admin.book.model.Book;
import org.json.JSONObject;
import utils.ServletActions;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(value = "/books")
@MultipartConfig
public class BookServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    private final Map<String, ServletActions> actions = Map.of(
            "REGISTER", this::registerBook,
            "EDIT", this::editBook,
            "DELETED", this::deleteBook
    );

    @Override
    public void init() {
        bookDAO = new BookDAOImplementation();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String actionParam = request.getParameter("action");
        ServletActions action = actions.get(actionParam.toUpperCase());
        if (action != null) {
            action.execute(request, response);
        } else {
            throw new IllegalArgumentException("Action not supported: " + actionParam);
        }
    }

    private void registerBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession httpSession = request.getSession();
            String adminEmail = (String) httpSession.getAttribute("adminEmail"); // Recupera o email do admin da sessão
            Part part = request.getPart("bimg");
            String fileName = part.getSubmittedFileName();
            Book book = new Book(request.getParameter("bname"), request.getParameter("author"), request.getParameter("price"),
                    request.getParameter("categories"), request.getParameter("status"), fileName, adminEmail); // Use o email do admin aqui
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
            Book book = new Book();
            book.setBookId(Integer.parseInt(request.getParameter("id")));
            book.setBookName(request.getParameter("bname"));
            book.setAuthor(request.getParameter("author"));
            book.setPrice(request.getParameter("price"));
            book.setStatus(request.getParameter("status"));

            boolean itsUpToDate = bookDAO.editBook(book);

            HttpSession httpSession = request.getSession();
            httpSession.setAttribute(itsUpToDate ? "successMessage" : "failMessage", itsUpToDate ? "Book updated successfully!"
                    : "The book has not been updated.");
            response.sendRedirect("./auth/admin/books/allBooks.jsp");
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("bookId"));
            boolean bookDeleted = bookDAO.deleteBook(id);

            // Construa um objeto JSON com a mensagem de sucesso ou falha
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", bookDeleted);
            jsonResponse.put("message", bookDeleted ? "Book deleted successfully!" : "The book has not been deleted.");

            // Configura a resposta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());
        } catch (SQLException | IOException sqlex) {
            throw new RuntimeException(sqlex);
        }
    }

}
