package user.model;

import java.util.List;

public class Roler {
    private int id;
    private String rolerType;
    private List<User> userList;

    public Roler() {
    }

    public Roler(int id, String rolerType) {
        this.id = id;
        this.rolerType = rolerType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRolerType() {
        return rolerType;
    }

    public void setRolerType(String rolerType) {
        this.rolerType = rolerType;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}
