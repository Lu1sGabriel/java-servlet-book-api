package user.DAOS;

import user.model.Roler;
import user.model.User;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDAOImplementation extends AbstractDAO implements UserDAO {

    @Override
    public User userRegister(User userModel) throws SQLException {
        final String insertSQL = "INSERT INTO public.user (name, email, phno, password) VALUES (?, ?, ?, ?) RETURNING userId";
        return executeQuery(insertSQL, statement -> {
            statement.setString(1, userModel.getName());
            statement.setString(2, userModel.getEmail());
            statement.setString(3, userModel.getPhno());
            statement.setString(4, userModel.getPassword());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    userModel.setId(resultSet.getInt(1));
                }
                return userModel;
            }
        });
    }


    @Override
    public User login(String email) throws SQLException {
        final String selectSQL = "SELECT userId, name, email, phno, password, adress, landmark, city, state, pincode FROM public.user WHERE email=?";
        return executeQuery(selectSQL, statement -> {
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
    public User findUserByLogin(String email) throws SQLException {
        RolerDAOImplementation dao = new RolerDAOImplementation();
        final String searchSQL = "SELECT * FROM public.user WHERE email=?";
        return executeQuery(searchSQL, statement -> {
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

    private User mapToUserModel(ResultSet resultSet) throws SQLException {
        User userModel = new User();
        userModel.setId(resultSet.getInt("userId"));
        userModel.setName(resultSet.getString("name"));
        userModel.setEmail(resultSet.getString("email"));
        userModel.setPhno(resultSet.getString("phno"));
        userModel.setPassword(resultSet.getString("password"));
        userModel.setAdress(resultSet.getString("adress"));
        userModel.setLandmark(resultSet.getString("landmark"));
        userModel.setCity(resultSet.getString("city"));
        userModel.setState(resultSet.getString("state"));
        userModel.setPincode(resultSet.getString("pincode"));
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
