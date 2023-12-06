package user.DAOS;

import admin.roler.DAO.RolerDAOImplementation;
import admin.roler.model.Roler;
import user.model.User;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImplementation extends AbstractDAO implements UserDAO {
    private static final String INSERT_SQL = "INSERT INTO \"ebook-app\".user (name, email, phno, password) VALUES (?, ?, ?, ?) RETURNING userId";
    private static final String UPDATE_SQL = "UPDATE \"ebook-app\".user SET name = ?, email = ?, phno = ? WHERE userId = ?";
    private static final String SELECT_SQL = "SELECT userId, name, email, phno, password, adress, landmark, city, state, pincode FROM \"ebook-app\".user WHERE email=?";
    private static final String SEARCH_SQL = "SELECT * FROM \"ebook-app\".user WHERE email=?";
    private static final String SEARCH_ALL_USERS_SQL = "SELECT userId, name, email, phno FROM \"ebook-app\".user ORDER BY userId";
    private static final String SEARCH_EMAIL_SQL = "SELECT * FROM \"ebook-app\".user WHERE email=?";
    private static final String SEARCH_PHNO_SQL = "SELECT * FROM \"ebook-app\".user WHERE phno=?";
    private static final String CHECK_EMAIL_SQL = "SELECT * FROM \"ebook-app\".user WHERE userId = ? AND email = ?";
    private static final String CHECK_PHNO_SQL = "SELECT * FROM \"ebook-app\".user WHERE userId = ? AND phno = ?";


    @Override
    public User register(User userModel) throws SQLException {
        return executeQueryWithParameters(statement -> {
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    userModel.setId(resultSet.getInt(1));
                }
                return userModel;
            }
        }, INSERT_SQL, userModel.getName(), userModel.getEmail(), userModel.getPhno(), userModel.getPassword());
    }

    @Override
    public User login(String email) throws SQLException {
        return executeQuery(SELECT_SQL, statement -> {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapToUserModel(resultSet);
                }
                return null;
            }
        });
    }

    @Override
    public boolean edition(User user) throws SQLException {
        return executeQuery(UPDATE_SQL, preparedStatement -> {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhno());
            preparedStatement.setInt(4, user.getId());
            return preparedStatement.executeUpdate() == 1;
        });
    }

    @Override
    public User findByLogin(String email) throws SQLException {
        RolerDAOImplementation dao = new RolerDAOImplementation();
        return executeQuery(SEARCH_SQL, statement -> {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    User user = createUser(resultSet);
                    List<Roler> userRoler = dao.searchUserRoler(user);
                    user.setRolerList(userRoler);
                    return user;
                }
                return null;
            }
        });
    }

    @Override
    public List<User> getAllUsers() throws SQLException {
        return executeQuery(SEARCH_ALL_USERS_SQL, preparedStatement -> {
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                List<User> userList = new ArrayList<>();
                while ((resultSet.next())) {
                    userList.add(mapToUserModelWithouPassword(resultSet));
                }
                return userList;
            }
        });
    }

    @Override
    public boolean isEmailRegistered(String email) throws SQLException {
        return executeQuery(SEARCH_EMAIL_SQL, preparedStatement -> {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        });
    }

    @Override
    public boolean isPhoneNumberRegistered(String phno) throws SQLException {
        return executeQuery(SEARCH_PHNO_SQL, preparedStatement -> {
            preparedStatement.setString(1, phno);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        });
    }

    @Override
    public boolean doesEmailBelongToUser(int id, String email) throws SQLException {
        return executeQuery(CHECK_EMAIL_SQL, preparedStatement -> {
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        });
    }

    @Override
    public boolean doesPhoneNumberBelongToUser(int id, String phno) throws SQLException {
        return executeQuery(CHECK_PHNO_SQL, preparedStatement -> {
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, phno);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        });
    }


    private User mapToUserModel(ResultSet resultSet) throws SQLException {
        User userModel = new User();
        userModel.setId(resultSet.getInt("userId"));
        userModel.setName(resultSet.getString("name"));
        userModel.setEmail(resultSet.getString("email"));
        userModel.setPhno(resultSet.getString("phno"));
        userModel.setPassword(resultSet.getString("password"));
        return userModel;
    }

    private User mapToUserModelWithouPassword(ResultSet resultSet) throws SQLException {
        User userModel = new User();
        userModel.setId(resultSet.getInt("userId"));
        userModel.setName(resultSet.getString("name"));
        userModel.setEmail(resultSet.getString("email"));
        userModel.setPhno(resultSet.getString("phno"));
        return userModel;
    }

    private User createUser(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("userId");
        String name = resultSet.getString("name");
        String email = resultSet.getString("email");
        String phno = resultSet.getString("phno");
        String password = resultSet.getString("password");
        User user = new User(name, email, phno, password);
        user.setId(id);
        return user;
    }
}
