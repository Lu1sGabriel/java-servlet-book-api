package admin.roler.DAO;

import admin.roler.model.Roler;
import user.model.User;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolerDAOImplementation extends AbstractDAO implements RolerDAO {
    private static final String INSERT_SQL = "INSERT INTO \"ebook-app\".user_roler (userIdFk, rolerIdFk) VALUES (?, ?)";
    private static final String SEARCH_ROLER_TYPE_SQL = "SELECT rolerId, roleType FROM \"ebook-app\".roler WHERE roleType=?";
    private static final String SEARCH_USER_ROLER_SQL = "SELECT roler.rolerId, roler.roleType FROM \"ebook-app\".roler JOIN \"ebook-app\".user_roler ON \"ebook-app\".user_roler.rolerIdFk = roler.rolerId  JOIN \"ebook-app\".user ON \"ebook-app\".user.userId = user_roler.userIdFk WHERE \"ebook-app\".user.userId = ?";
    private static final String SEARCH_ALL_ROLERS_SQL = "SELECT rolerId, roleType FROM roler";

    @Override
    public void assignRole(User user, Roler roler) throws SQLException {
        executeQuery(INSERT_SQL, statement -> {
            statement.setInt(1, user.getId());
            statement.setInt(2, roler.getId());
            return statement.executeUpdate() == 1;
        });
    }

    @Override
    public Roler searchRolerByType(String type) throws SQLException {
        return executeQuery(SEARCH_ROLER_TYPE_SQL, statement -> {
            statement.setString(1, type);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return createRoler(resultSet);
                }
                return null;
            }
        });
    }

    @Override
    public List<Roler> searchUserRoler(User user) throws SQLException {
        List<Roler> rolerList = new ArrayList<>();
        return executeQuery(SEARCH_USER_ROLER_SQL, statement -> {
            statement.setInt(1, user.getId());
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Roler roler = createRoler(resultSet);
                    rolerList.add(roler);
                }
                return rolerList;
            }
        });
    }

    @Override
    public List<Roler> searchAllRolers() throws SQLException {
        List<Roler> rolerList = new ArrayList<>();
        return executeQuery(SEARCH_ALL_ROLERS_SQL, statement -> {
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Roler roler = createRoler(resultSet);
                    rolerList.add(roler);
                }
                return rolerList;
            }
        });
    }

    private Roler createRoler(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("rolerId");
        String rolerType = resultSet.getString("roleType");
        return new Roler(id, rolerType);
    }
}