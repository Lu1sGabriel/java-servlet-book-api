package user.servlet;

import user.DAOS.RolerDAO;
import user.DAOS.RolerDAOImplementation;
import user.DAOS.UserDAO;
import user.DAOS.UserDAOImplementation;
import user.model.Roler;
import user.model.User;
import user.model.UserDetails;
import utils.Authorization;
import utils.Cryptography;
import utils.ServletActions;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Serial;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(value = "/register")
public class UserServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private RolerDAO rolerDAO;

    private enum Actions {
        REGISTER,
        LOGIN
    }

    private final Map<Actions, ServletActions> actions = Map.of(
            Actions.REGISTER, this::register,
            Actions.LOGIN, this::login
    );

    @Override
    public void init() {
        userDAO = new UserDAOImplementation();
        rolerDAO = new RolerDAOImplementation();
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


    private void register(HttpServletRequest request, HttpServletResponse response) {
        HttpSession httpSession = request.getSession();
        if (request.getParameter("check") != null) {
            try {
                String fname = request.getParameter("fname");
                String email = request.getParameter("email");
                String phno = request.getParameter("phno");
                String password = request.getParameter("password");

                // Verifica se os campos estão vazios
                if (fname == null || fname.isEmpty() || email == null || email.isEmpty() || phno == null || phno.isEmpty() || password == null || password.isEmpty()) {
                    httpSession.setAttribute("failMessage", "All fields must be filled");
                    response.sendRedirect("register.jsp");
                    return;
                }

                String encryptedPassword = Cryptography.convertToMD5(password);
                User userModel = new User(fname, email, phno, encryptedPassword);
                User isRegistered = userDAO.userRegister(userModel);
                if (isRegistered != null) {
                    Roler roler;
                    roler = rolerDAO.searchRolerByType("USER");
                    rolerDAO.assignRole(isRegistered, roler);
                    httpSession.setAttribute("successMessage", "Registration created successfully!");
                    response.sendRedirect("login.jsp");
                } else {
                    httpSession.setAttribute("failMessage", "An error occurred when trying to register");
                    response.sendRedirect("register.jsp");
                }
            } catch (NoSuchAlgorithmException | IOException | SQLException exception) {
                throw new RuntimeException(exception.getMessage() + "\n" + exception.getCause());
            }
        } else {
            httpSession.setAttribute("failMessage", "Please accept the terms and conditions.");
            redirectToRegisterPage(response);
        }
    }


    private void login(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Verifica se os campos estão vazios
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("failedMsg", "Todos os campos devem ser preenchidos.");
            try {
                response.sendRedirect("login.jsp");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        User user;
        String path = "login.jsp"; // Define o caminho padrão para a página de login

        try {
            user = userDAO.findUserByLogin(email);
            if (user != null) {
                if (Cryptography.compararSenha(password, user.getPassword())) {
                    UserDetails userDetails = new UserDetails(user);
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("usuarioLogado", userDetails);
                    httpSession.setAttribute("userModelObj", userDetails); // Adiciona o objeto UserDetails à sessão
                    Authorization authorization = new Authorization();
                    path = authorization.indexProfile(userDetails); // Altera o caminho se o login for bem-sucedido
                    if (userDetails.getRolers().contains("ADMIN")) {
                        httpSession.setAttribute("adminEmail", email); // Armazena o email do admin na sessão
                    }
                } else {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("failedMsg", "Email and/or password invalid.");
                }
            } else {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("failedMsg", "We did not find any users with this registered email address.");
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        try {
            response.sendRedirect(path); // Redireciona para a página especificada
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    private void redirectToRegisterPage(HttpServletResponse response) {
        try {
            response.sendRedirect("register.jsp");
        } catch (IOException ioException) {
            throw new RuntimeException(ioException);
        }
    }

}