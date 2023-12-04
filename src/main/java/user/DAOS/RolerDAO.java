package user.DAOS;

import user.model.Roler;
import user.model.User;

import java.sql.SQLException;
import java.util.List;

public interface RolerDAO {
    void assignRole(User user, Roler roler) throws SQLException;

    Roler searchRolerByType(String type) throws SQLException;

    List<Roler> searchUserRoler(User user) throws SQLException;

    List<Roler> searchAllRolers() throws SQLException;
}
