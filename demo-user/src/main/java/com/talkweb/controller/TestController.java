package com.talkweb.controller;

import com.talkweb.pojo.UserBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author zhengyiwen
 * @create 2020/7/23 11:11
 */
@Controller
@RequestMapping(value = "/test/")
public class TestController {

    @RequestMapping("pao")
    public ModelAndView test(){
        ModelAndView mav = new ModelAndView();


        String uri = "login";
        mav.setViewName(uri);

        return mav;
    }

}
