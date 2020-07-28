package com.talkweb.service;

import com.talkweb.pojo.UserBean;

import java.util.List;
import java.util.Map;

/**
 * @author zhengyiwen
 * @create 2020/7/23 17:34
 */
public interface UserService {
    public Map login(String account, String password);
    public UserBean findUserByTel(String tel);
    public int addUser(UserBean bean);
    public List<UserBean> findUsers(int start ,int pagesize);
    public int delUsers(List tels);
    public int updateUser(Map map);
}
