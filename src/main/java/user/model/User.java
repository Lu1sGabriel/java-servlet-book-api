package user.model;

import admin.roler.model.Roler;

import java.util.List;

public class User {
    private int id;
    private String name;
    private String email;
    private String phno;
    private String password;
    private List<Roler> rolerList;

    public User() {
        super();
    }

    public User(String name, String email, String phno, String password) {
        this.name = name;
        this.email = email;
        this.phno = phno;
        this.password = password;
    }


    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhno() {
        return phno;
    }

    public void setPhno(String phno) {
        this.phno = phno;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Roler> getRolerList() {
        return rolerList;
    }

    public void setRolerList(List<Roler> rolerList) {
        this.rolerList = rolerList;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phno='" + phno + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
