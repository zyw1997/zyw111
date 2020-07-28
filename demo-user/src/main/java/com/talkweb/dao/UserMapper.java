package com.talkweb.dao;

import com.talkweb.pojo.UserBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


/**
 * @author zhengyiwen
 * @create 2020/7/23 17:14
 */
@Component
public interface UserMapper {
    //用户登录
    public UserBean login(UserBean bean);
    public UserBean findUserByTel(String tel);
    public int addUser(UserBean bean);
    public List<UserBean> findUsers(@Param("page") Map map);
    public int pageCount ();
    public int delUsers(@Param("tels")List list);
    public int updateUser(@Param("info") Map map);
}
