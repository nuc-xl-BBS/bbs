package com.withstars.controller;

import com.withstars.domain.LoginLog;
import com.withstars.domain.Tab;
import com.withstars.domain.Topic;
import com.withstars.domain.User;
import com.withstars.service.TabService;
import com.withstars.service.impl.LoginLogServiceImpl;
import com.withstars.service.impl.TabServiceImpl;
import com.withstars.service.impl.TopicServiceImpl;
import com.withstars.service.impl.UserServiceImpl;
import eu.bitwalker.useragentutils.UserAgent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

/**
 * 用户相关控制类
 */
@Controller
public class UserController {

    @Autowired
    public UserServiceImpl userService;

    @Autowired
    public LoginLogServiceImpl loginLogService;

    @Autowired
    public TopicServiceImpl topicService;

    @Autowired
    public TabServiceImpl tabService;


    /**
     * 用户注册
     */
    @RequestMapping("/user/add/do")
    public String addUser(HttpServletRequest request){
        //新建User对象
        User user=new User();
        //处理手机号
        String phoneNum=request.getParameter("tel");
        String areaCode=request.getParameter("areaCode");
        String phone=areaCode+phoneNum;
        //用户类型
        Byte type=new Byte("0");
        String password=request.getParameter("password");

        user.setUsername(request.getParameter("username"));
        user.setPassword(password);
        user.setEmail(request.getParameter("email"));
        user.setPhoneNum(phone);
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());
        user.setCredit(0);
        user.setType(type);
        user.setWorkdw(request.getParameter("workdw"));
        user.setWorkxz(request.getParameter("workxz"));



        boolean ifSucc=userService.addUser(user);
        System.out.print(ifSucc);
        return "redirect:/";
    }

    /**
     * 用户登陆，写入登录日志
     * @param request
     * @param session
     * @return 0:用户名不存在 1:密码错误 2:登录成功
     */

    @RequestMapping("/api/loginCheck")
    @ResponseBody
    public Object signin(HttpServletRequest request,HttpSession session){
        //处理参数
        String password=request.getParameter("password");
        String username=request.getParameter("username");
        //验证用户名密码
        int loginVerify=userService.login(username,password);

        HashMap<String, String> res = new HashMap<String, String>();

        //登录成功
        if(loginVerify == 2){
            User user =userService.getUserByUsername(username);
            Integer userId=user.getId();
            //添加积分
            boolean ifSuccAddCredit=userService.addCredit(1,userId);
            //用户信息写入session
            session.setAttribute("userId",userId);
            session.setAttribute("username",username);
            //获取登录信息
            String ip=getRemortIP(request);
            UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
            //获取用户的浏览器名
            String userbrowser = userAgent.getBrowser().toString();
            //写入登录日志
            LoginLog log=new LoginLog();
            log.setDevice(userbrowser);
            log.setIp(ip);
            log.setUserId(userId);
            log.setLoginTime(new Date());
            boolean ifSuccAddLog=loginLogService.addLog(log);

            res.put("stateCode", "2");
        }
        //密码错误
        else if (loginVerify == 1){
            res.put("stateCode", "1");
        }
        //用户名不存在
        else {
            res.put("stateCode", "0");
        }
        return res;
    }

    /**
     * 用户登出
     */
    @RequestMapping("/signout")
    public String signout(HttpSession session){
        session.removeAttribute("userId");
        session.removeAttribute("username");
        return "redirect:/";
    }

    /**
     * 获取客户端IP
     */
    public String getRemortIP(HttpServletRequest request) {
        if (request.getHeader("x-forwarded-for") == null) {
            return request.getRemoteAddr();
        }
        return request.getHeader("x-forwarded-for");
    }

    /**
     * 用户个人主页
     */
    @RequestMapping("/member/{username}")
    public ModelAndView personalCenter(@PathVariable("username")String username, HttpSession session){
        boolean ifExistUser=userService.existUsername(username);
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        //获取用户信息
        Integer uid=(Integer) session.getAttribute("userId");

        User user=userService.getUserById(uid);
        //最热主题
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();

        ModelAndView mv=new ModelAndView("user_info");
        mv.addObject("hotestTopics",hotestTopics);
        List<Tab> tabs=tabService.getAllTabs();
        if (ifExistUser){
            User resultUser=userService.getUserByUsername(username);
            mv.addObject("userInfo",resultUser);
            mv.addObject("topicsNum",topicsNum);
            mv.addObject("usersNum",usersNum);
            mv.addObject("user",user);
            mv.addObject("tabs",tabs);
            return mv;
        }else {
            String errorInfo=new String("会员未找到");
            mv.addObject("errorInfo",errorInfo);
            mv.addObject("tabs",tabs);
            return mv;
        }
    }

    /**
    修改用户信息
     */
    @RequestMapping("user/update/{username}")
    public ModelAndView getuserinfo(@PathVariable("username")String username, HttpSession session){
        boolean ifExistUser=userService.existUsername(username);
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        List<Tab> tabs=tabService.getAllTabs();

        //获取用户信息
        Integer uid=(Integer) session.getAttribute("userId");

        User user=userService.getUserById(uid);
        //最热主题
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();

        ModelAndView mv=new ModelAndView("update_user_info");
        mv.addObject("hotestTopics",hotestTopics);
        if (ifExistUser){
            User resultUser=userService.getUserByUsername(username);
            System.out.println(user.getWorkxz());
            mv.addObject("userInfo",resultUser);
            mv.addObject("topicsNum",topicsNum);
            mv.addObject("usersNum",usersNum);
            mv.addObject("user",user);
            mv.addObject("tabs",tabs);
            return mv;
        }else {
            String errorInfo=new String("会员未找到");
            mv.addObject("errorInfo",errorInfo);
            mv.addObject("tabs",tabs);
            return mv;
        }
    }

    /**
     * 更新用户信息
     * @param request
     * @return
     */
    @RequestMapping("/user/updateinfo")
    public String updateuser(HttpServletRequest request){
        //新建User对象
        User user=new User();
        //处理手机号
        String phoneNum=request.getParameter("tel");
        String areaCode=request.getParameter("areaCode");
        String phone=areaCode+phoneNum;
        //用户类型
        Byte type=new Byte("0");
        String password=request.getParameter("password");
        user.setId(Integer.parseInt(request.getParameter("id")));
        user.setUsername(request.getParameter("name"));
        user.setPassword(password);
        user.setEmail(request.getParameter("email"));
        user.setPhoneNum(phone);
        user.setWorkdw(request.getParameter("workdw"));
        user.setWorkxz(request.getParameter("workxz"));
        userService.updateUser(user);

        return "redirect:/member/"+user.getUsername();
    }

    /**
     * 置顶操作，取消置顶操作
     * @param id
     * @return
     */
    @RequestMapping("/zhiding/{id}")
    public String zhiding(@PathVariable("id") String id){
        Topic topic=new Topic();
        topic.setId(Integer.parseInt(id));
        topic.setZhiding("1");
        Topic topic1=topicService.selectById(Integer.parseInt(id));
        int userid=topic1.getUserId();
        topicService.zhidingByPrimaryKey(topic);
        return "redirect:/look/"+userid;

    }

    @RequestMapping("/quxiaozhiding/{id}")
    public String quxiaozhiding(@PathVariable("id") String id){
        Topic topic=new Topic();
        topic.setId(Integer.parseInt(id));
        topic.setZhiding("0");
        Topic topic1=topicService.selectById(Integer.parseInt(id));
        int userid=topic1.getUserId();
        topicService.zhidingByPrimaryKey(topic);
        return "redirect:/look/"+userid;

    }


    @RequestMapping("/userall")
    public ModelAndView taball(HttpSession session){
        List<User> users=userService.getAllUsers();
        ModelAndView modelAndView=new ModelAndView("user");
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        modelAndView.addObject("topicsNum",topicsNum);
        modelAndView.addObject("usersNum",usersNum);
        modelAndView.addObject("user",userService.getUserById((Integer) session.getAttribute("userId")));
        modelAndView.addObject("users",users);
        return modelAndView;
    }

    /**
     * 删除板块
     */
    @RequestMapping("/userdelete/{id}")
    public String deletepage(@PathVariable("id")String id,HttpSession session){
        userService.deleteByPrimaryKey((Integer.parseInt(id)));
        return "redirect:/userall";
    }

    /**
     获得帖子信息，用户数据回显
     **/
    @RequestMapping("/userhuixian/{id}")
    public ModelAndView getTopicInfo(@PathVariable("id")String id,HttpSession session){
        User u=userService.getUserById(Integer.parseInt(id));
        ModelAndView mv=new ModelAndView("updateuser");
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        mv.addObject("topicsNum",topicsNum);
        mv.addObject("usersNum",usersNum);
        mv.addObject("user",userService.getUserById((Integer)session.getAttribute("userId")));
        mv.addObject("u",u);
        return mv;
    }

    /**
     * 修改帖子内容
     * @param id
     * @param request
     * @return
     */

    @RequestMapping(value = "/userupdate/{id}", method = RequestMethod.POST)
    public String updateTopic(@PathVariable("id")String id,HttpServletRequest request){
        User u=new User();
        u.setId(Integer.parseInt(id));
        u.setUsername(request.getParameter("username"));
        u.setPassword(request.getParameter("password"));
        u.setEmail(request.getParameter("email"));
        u.setPhoneNum(request.getParameter("phonenum"));
        u.setCredit(Integer.parseInt(request.getParameter("credit")));
        u.setWorkxz(request.getParameter("workxz"));
        u.setWorkdw(request.getParameter("workdw"));
        userService.updateUser(u);
        return "redirect:/userall";
    }



}
