package user.DAOS;

import user.model.User;

import java.sql.SQLException;

public interface UserDAO {
//    boolean userRegister(User userModel) throws SQLException;

    User userRegister(User userModel) throws SQLException;

    User login(String email) throws SQLException;

    User findUserByLogin(String email) throws SQLException;
}