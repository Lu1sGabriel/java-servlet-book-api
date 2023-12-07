package user.DAOS;

import user.model.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    User insert(User userModel) throws SQLException;

    User login(String email) throws SQLException;

    boolean edit(User user) throws SQLException;

    boolean delete(User user) throws SQLException;

    User findByLogin(String email) throws SQLException;

    List<User> getAll() throws SQLException;

    boolean isEmailRegistered(String email) throws SQLException;

    boolean isPhoneNumberRegistered(String phoneNumber) throws SQLException;

    boolean doesEmailBelongToUser(int id, String email) throws SQLException;

    boolean doesPhoneNumberBelongToUser(int id, String phoneNumber) throws SQLException;

}