package user.servlet;

import admin.roler.DAO.RolerDAO;
import admin.roler.DAO.RolerDAOImplementation;
import admin.roler.model.Roler;
import user.DAOS.UserDAO;
import user.DAOS.UserDAOImplementation;
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

@WebServlet(value = "/user")
public class UserServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private RolerDAO rolerDAO;

    private enum Actions {
        REGISTER,
        LOGIN,
        EDIT,
        DELETE
    }

    private final Map<Actions, ServletActions> actions = Map.of(
            Actions.REGISTER, this::register,
            Actions.LOGIN, this::login,
            Actions.EDIT, this::edit,
            Actions.DELETE, this::delete
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
        try {
            if (request.getParameter("check") != null) {
                String fullName = request.getParameter("fname");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phno");
                String password = request.getParameter("password");

                // Verifica se os campos estão vazios
                if (areFieldsEmpty(fullName, email, phoneNumber, password)) {
                    setSessionAttributeAndRedirect(request, response, false, "All fields must be filled.",
                            "register.jsp");
                    return;
                }

                if (isPasswordInvalid(password)) {
                    setSessionAttributeAndRedirect(request, response, false, "The password must be at least 6 characters long.",
                            "register.jsp");
                    return;
                }

                if (isPhoneNumberInvalid(phoneNumber)) {
                    setSessionAttributeAndRedirect(request, response, false, "The phone number must be exactly 11 digits long and contain only numbers.",
                            "register.jsp");
                    return;
                }

                // Verifica se o email e/ou número de celular já está registrado
                if (isEmailOrPhoneNumberRegistered(email, phoneNumber)) {
                    setSessionAttributeAndRedirect(request, response, false, "The email or phone number is already registered. Please try again with another ones.",
                            "register.jsp");
                    return;
                }

                String encryptedPassword = Cryptography.convertToMD5(password);
                User userModel = new User(fullName, email, phoneNumber, encryptedPassword);
                User isRegistered = userDAO.insert(userModel);
                if (isRegistered != null) {
                    assignRoleToUser(isRegistered);
                    setSessionAttributeAndRedirect(request, response, true, "Record created successfully!", "login.jsp");
                } else {
                    setSessionAttributeAndRedirect(request, response, false, "An error occurred while trying to register.", "register.jsp");
                }
            } else {
                setSessionAttributeAndRedirect(request, response, false, "Please accept the terms and conditions.", "register.jsp");
            }
        } catch (NoSuchAlgorithmException | IOException | SQLException exception) {
            throw new RuntimeException(exception.getMessage() + "\n" + exception.getCause());
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Verifica se os campos estão vazios
            if (areFieldsEmpty(email, password)) {
                setSessionAttributeAndRedirect(request, response, false, "All fields must be filled.", "login.jsp");
                return;
            }

            User user = userDAO.findByLogin(email);
            if (user != null) {
                if (Cryptography.compararSenha(password, user.getPassword())) {
                    UserDetails userDetails = new UserDetails(user);
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("usuarioLogado", userDetails);
                    httpSession.setAttribute("userModelObj", userDetails); // Adiciona o objeto UserDetails à sessão
                    Authorization authorization = new Authorization();
                    String path = authorization.indexProfile(userDetails); // Altera o caminho se o login for bem-sucedido
                    if (userDetails.getRolers().contains("ADMIN")) {
                        httpSession.setAttribute("adminEmail", email); // Armazena o email do admin na sessão
                    }
                    response.sendRedirect(path); // Redireciona para a página especificada
                } else {
                    setSessionAttributeAndRedirect(request, response, false, "Email and/or password invalid.", "login.jsp");
                }
            } else {
                setSessionAttributeAndRedirect(request, response, false, "We did not find any users with this registered email address.", "login.jsp");
            }
        } catch (SQLException | NoSuchAlgorithmException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("userId"));
            String name = request.getParameter("userName");
            String email = request.getParameter("userMail");
            String phoneNumber = request.getParameter("userPhoneNumber");

            // Verifica se os campos estão vazios
            if (areFieldsEmpty(name, email, phoneNumber)) {
                setSessionAttributeAndRedirect(request, response, false, "All fields must be filled.",
                        "./auth/admin/users/allUsers.jsp");
                return;
            }

            //  Verifica se o número de celular tem exatemente 11 números e/ou contém letras.
            if (isPhoneNumberInvalid(phoneNumber)) {
                setSessionAttributeAndRedirect(request, response, false, "The phone number must be exactly 11 digits long and contain only numbers.",
                        "./auth/admin/users/allUsers.jsp");
                return;
            }

            // Verifica se o email já está registrado e não pertence ao usuário atual
            if (isEmailRegisteredAndNotBelongToUser(id, email)) {
                setSessionAttributeAndRedirect(request, response, false, "The email is already registered. Please try again with another one.",
                        "./auth/admin/users/allUsers.jsp");
                return;
            }

            // Verifica se o número de celular já está registrado e não pertence ao usuário atual
            if (isPhoneNumberRegisteredAndNotBelongToUser(id, phoneNumber)) {
                setSessionAttributeAndRedirect(request, response, false, "The phone number is already registered. Please try again with another one.",
                        "./auth/admin/users/allUsers.jsp");
                return;
            }

            User userModel = new User();
            userModel.setId(id);
            userModel.setName(name);
            userModel.setEmail(email);
            userModel.setPhno(phoneNumber);

            boolean wasEdited = userDAO.edit(userModel);
            setSessionAttributeAndRedirect(request, response, wasEdited, "User edited successfully!", "There was a problem editing the user.",
                    "./auth/admin/users/allUsers.jsp");

        } catch (SQLException | IOException exception) {
            throw new RuntimeException(exception);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        try {
            User userModel = new User();
            userModel.setId(Integer.parseInt(request.getParameter("userId")));
            boolean hasBeenDeleted = userDAO.delete(userModel);
            setSessionAttributeAndRedirect(request, response, hasBeenDeleted, "The user has been successfully deleted!", "The user has not been deleted.",
                    "./auth/admin/users/allUsers.jsp");
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

    private boolean isPasswordInvalid(String password) {
        return password.length() <= 5;
    }

    private boolean isPhoneNumberInvalid(String phno) {
        return phno.length() != 11 || !phno.matches("\\d+");
    }

    private boolean isEmailOrPhoneNumberRegistered(String email, String phno) throws SQLException {
        return userDAO.isEmailRegistered(email) || userDAO.isPhoneNumberRegistered(phno);
    }

    private boolean isEmailRegisteredAndNotBelongToUser(int id, String email) throws SQLException {
        return userDAO.isEmailRegistered(email) && !userDAO.doesEmailBelongToUser(id, email);
    }

    private boolean isPhoneNumberRegisteredAndNotBelongToUser(int id, String phoneNumber) throws SQLException {
        return userDAO.isPhoneNumberRegistered(phoneNumber) && !userDAO.doesPhoneNumberBelongToUser(id, phoneNumber);
    }

    private void assignRoleToUser(User user) throws SQLException {
        Roler roler = rolerDAO.searchRolerByType("USER");
        rolerDAO.assignRole(user, roler);
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