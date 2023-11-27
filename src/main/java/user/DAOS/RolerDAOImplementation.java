package user.DAOS;

import user.model.Roler;
import user.model.User;
import utils.AbstractDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolerDAOImplementation extends AbstractDAO implements RolerDAO {
    @Override
    public void assignRole(User user, Roler roler) throws SQLException {
        final String insertSQL = "INSERT INTO public.user_roler (userIdFk, rolerIdFk) VALUES (?, ?)";
        executeQuery(insertSQL, statement -> {
            statement.setInt(1, user.getId());
            statement.setInt(2, roler.getId());
            return statement.executeUpdate() == 1;
        });
    }

    @Override
    public void deleteRole(User user) throws SQLException {
        final String deleteSQL = "DELETE FROM public.user_roler WHERE userIdFk=?";
        executeUpdate(deleteSQL, statement -> {
            statement.setInt(1, user.getId());
            statement.executeUpdate();
        });
    }

    @Override
    public Roler searchRolerByType(String type) throws SQLException {
        final String searchSQL = "SELECT rolerId, roleType FROM public.roler WHERE roleType=?";
        return executeQuery(searchSQL, statement -> {
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
        final String searchSQL = "SELECT roler.rolerId, roler.roleType " +
                "FROM roler " +
                "JOIN user_roler " +
                "ON user_roler.rolerIdFk = roler.rolerId " +
                "JOIN \"user\" " +
                "ON \"user\".userId = user_roler.userIdFk " +
                "WHERE \"user\".userId = ?";
        return executeQuery(searchSQL, statement -> {
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
        final String searchSQL = "SELECT rolerId, roleType FROM roler";
        return executeQuery(searchSQL, statement -> {
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