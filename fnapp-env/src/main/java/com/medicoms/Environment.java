package com.medicoms;

public class Environment {
    private String userName;
    private String url;
    private String password;
    public Environment() {
        this.userName = System.getenv("USER_NAME");
        this.url = System.getenv("URL");
        this.password = System.getenv("PASSWORD");
    }
    public String getUserName() {
        return userName;
    }
    public String getURL() {
        return url;
    }
    public String getPassword() {
        return password;
    }
}
