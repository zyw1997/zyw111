package com.talkweb.service.impl;

import com.talkweb.dao.UserMapper;
import com.talkweb.pojo.UserBean;
import com.talkweb.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhengyiwen
 * @create 2020/7/23 17:35
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userDao;

    //需要账号密码进行登录
    public Map login(String account, String password) {
        UserBean bean = new UserBean();
        bean.setUser_account(account);
        bean.setPassword(password);
        UserBean bean1 = userDao.login(bean);
        int pageCount;
        if (userDao.pageCount() % 4 == 0) {
            pageCount = userDao.pageCount() / 4;
        } else {
            pageCount = (userDao.pageCount() / 4) + 1;
        }
        Map map = new HashMap();
        map.put("pageCount", pageCount);
        map.put("userBean", bean1);
        return map;
    }

    //通过用户手机号码查找用户信息
    public UserBean findUserByTel(String tel) {
        UserBean bean = userDao.findUserByTel(tel);
        return bean;
    }

    public int addUser(UserBean bean) {
        return userDao.addUser(bean);
    }

    public List<UserBean> findUsers(int start, int pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", start);
        map.put("pageSize", pageSize);
        List<UserBean> userList = userDao.findUsers(map);
        return userList;
    }

    public int delUsers(List tels) {
        return userDao.delUsers(tels);
    }
    public  int updateUser(Map map){
        return userDao.updateUser(map);
    }
}
