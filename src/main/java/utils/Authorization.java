package utils;

import user.model.UserDetails;

import java.util.List;
import java.util.Map;

public class Authorization {
    private final Map<String, List<String>> auth = Map.of(
            "ADMIN", List.of("/auth/user", "/auth/admin"),
            "USER", List.of("/auth/user")
    );

    public boolean hasAuthorization(UserDetails user, String path) {
        return user.getRolers().stream()
                .flatMap(roler -> auth.get(roler).stream())
                .anyMatch(path::contains);
    }

    public String indexProfile(UserDetails user) {
        return switch (user.getRolers().get(0)) {
            case "ADMIN" -> "auth/admin/admHome.jsp";
            case "USER" -> "index.jsp";
            default -> "";
        };
    }
}
