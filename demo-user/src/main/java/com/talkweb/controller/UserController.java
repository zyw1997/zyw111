package com.talkweb.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.talkweb.pojo.UserBean;
import com.talkweb.service.UserService;
import net.sf.json.JSON;
import net.sf.json.JSONSerializer;
import org.apache.ibatis.annotations.ResultType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhengyiwen
 * @create 2020/7/23 17:40
 */
@Controller
@RequestMapping("/user/")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("login")
    public ModelAndView login(@RequestParam("account") String account, @RequestParam("password") String password) {
        ModelAndView mav = new ModelAndView();
        Map map  = userService.login(account, password);
        if (map.get("userBean") == null) {
            mav.setViewName("login");
        } else {
            mav.setViewName("user");
            mav.addObject("map",map);
           // mav.addObject(map);
        }
        //System.out.println(loginJson);
        return mav;
    }

    @RequestMapping("findUserByTel")
    public @ResponseBody
    UserBean findUserByTel(@RequestBody String user_tel) {
        String ut = user_tel;
        UserBean ub = userService.findUserByTel(ut);
        return ub;
    }

    @RequestMapping("addUser")
    public ModelAndView addUser(String tel, String account, String nickname, String password) {
        ModelAndView mav = new ModelAndView();
        UserBean bean = new UserBean();
        bean.setUser_tel(tel);
        bean.setUser_account(account);
        bean.setUser_nickname(nickname);
        bean.setPassword(password);
        int flag = userService.addUser(bean);
        if (flag == -1) {
            System.out.println("新增失败");
        } else {
            System.out.println("新增成功");
        }
        Map map  = userService.login(account, password);
        mav.addObject("map",map);
        mav.setViewName("user");


        return mav;
    }

    @RequestMapping("findUsers")
    public  @ResponseBody   List<UserBean> findUsers(int page) {
        ModelAndView mav = new ModelAndView();
        int start = (page - 1) * 4 ;
        int pageSize = 4;
        List<UserBean> userList = userService.findUsers(start,pageSize);
        System.out.println(userList);
        return userList ;
    }

    @RequestMapping("delUsers")
    public ModelAndView delUsers(@RequestParam("tels") List<String> tels){
        userService.delUsers(tels);
        ModelAndView mav = new ModelAndView();
        Map map  = userService.login("123", "123");
        mav.addObject("map",map);
        mav.setViewName("user");
        return mav;
    }
    @RequestMapping("updateUser")
    public ModelAndView update(String tel ,String new_nickname){
        Map map = new HashMap();
        map.put("tel",tel);
        map.put("new_nickname",new_nickname);
        ModelAndView mav = new ModelAndView();
        userService.updateUser(map);
        Map map1  = userService.login("123", "123");
        mav.addObject("map",map1);
        mav.setViewName("user");

        return mav;
    }
}
