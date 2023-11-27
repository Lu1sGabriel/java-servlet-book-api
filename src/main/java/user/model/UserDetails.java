package user.model;

import java.util.ArrayList;
import java.util.List;

public class UserDetails {
    private User user;
    private List<String> rolers;

    public UserDetails(User user) {
        this.user = user;
        this.rolers = new ArrayList<>();
        for (Roler roler : user.getRolerList()) {
            this.rolers.add(roler.getRolerType());
        }
    }

    public String getName() {
        return user.getName();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<String> getRolers() {
        return rolers;
    }

    public void setRolers(List<String> rolers) {
        this.rolers = rolers;
    }
}
