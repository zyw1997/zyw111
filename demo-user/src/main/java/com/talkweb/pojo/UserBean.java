package com.talkweb.pojo;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @author zhengyiwen
 * @create 2020/7/23 9:11
 */
@Component
public class UserBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private String user_tel;
    private String user_account;
    private String user_nickname;
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "UserBean{" +
                "user_tel='" + user_tel + '\'' +
                ", user_account='" + user_account + '\'' +
                ", user_nickname='" + user_nickname + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public String getUser_tel() {
        return user_tel;
    }

    public void setUser_tel(String user_tel) {
        this.user_tel = user_tel;
    }

    public String getUser_account() {
        return user_account;
    }

    public void setUser_account(String user_account) {
        this.user_account = user_account;
    }

    public String getUser_nickname() {
        return user_nickname;
    }

    public void setUser_nickname(String user_nickname) {
        this.user_nickname = user_nickname;
    }
}
