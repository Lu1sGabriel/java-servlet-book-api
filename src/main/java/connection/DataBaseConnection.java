package connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataBaseConnection {
    private static final String RESOURCE = "java:/comp/env/jdbc/postgresql";

    public static Connection getConnection() {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup(RESOURCE);
            return dataSource.getConnection();
        } catch (SQLException sqlex) {
            throw new RuntimeException("Não foi possível estabelecer a conexão com o banco. \n" + sqlex.getCause());
        } catch (NamingException nex) {
            throw new RuntimeException("Não foi possível localizar o recurso no contexto JNDI. \n" + nex.getCause());
        }
    }
}