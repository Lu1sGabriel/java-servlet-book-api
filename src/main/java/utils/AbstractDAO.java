package utils;

import connection.DataBaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AbstractDAO {
    private Connection connection;

    public void connect() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DataBaseConnection.getConnection();
        }
    }

    public void disconnect() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }

    protected <T> T executeQuery(String sql, SqlFunction<PreparedStatement, T> function) throws SQLException {
        connect();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            return function.apply(statement);
        } finally {
            disconnect();
        }
    }

    protected <T> T executeQueryWithParameters(SqlFunction<PreparedStatement, T> function, String sql, Object... parameters) throws SQLException {
        connect();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            for (int i = 0; i < parameters.length; i++) {
                statement.setObject(i + 1, parameters[i]);
            }
            return function.apply(statement);
        } finally {
            disconnect();
        }
    }

    protected void executeUpdate(String sql, SqlConsumer<PreparedStatement> consumer) throws SQLException {
        connect();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            consumer.accept(statement);
        } finally {
            disconnect();
        }
    }

    @FunctionalInterface
    public interface SqlFunction<T, R> {
        R apply(T t) throws SQLException;
    }

    @FunctionalInterface
    public interface SqlConsumer<T> {
        void accept(T t) throws SQLException;
    }


}