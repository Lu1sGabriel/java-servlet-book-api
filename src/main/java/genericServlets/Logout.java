package genericServlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/logout")
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        doLogout(request, response);
    }

    public void doLogout(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // Cria uma nova sessão e define a mensagem de logout
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("logoutMessage", "Logout successful!");

            // Redireciona para a página de login
            response.sendRedirect("login.jsp");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}