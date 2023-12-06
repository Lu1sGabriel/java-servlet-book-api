package user.DAOS;

import user.model.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
//    boolean userRegister(User userModel) throws SQLException;

    User register(User userModel) throws SQLException;

    User login(String email) throws SQLException;

    User findByLogin(String email) throws SQLException;

    boolean edition(User user) throws SQLException;

    List<User> getAllUsers() throws SQLException;

    boolean isEmailRegistered(String email) throws SQLException;

    boolean isPhoneNumberRegistered(String phoneNumber) throws SQLException;

    boolean doesEmailBelongToUser(int id, String email) throws SQLException;

    boolean doesPhoneNumberBelongToUser(int id, String phoneNumber) throws SQLException;
}