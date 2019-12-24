package com.withstars.controller;

import com.withstars.domain.Reply;
import com.withstars.domain.Tab;
import com.withstars.domain.Topic;
import com.withstars.domain.User;
import com.withstars.service.impl.ReplyServiceImpl;
import com.withstars.service.impl.TabServiceImpl;
import com.withstars.service.impl.TopicServiceImpl;
import com.withstars.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.prefs.BackingStoreException;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 主题相关控制类
 */
@Controller
public class TopicController {

    @Autowired
    public TopicServiceImpl topicService;
    @Autowired
    public ReplyServiceImpl replyService;
    @Autowired
    public UserServiceImpl userService;
    @Autowired
    public TabServiceImpl tabService;

    //log4j对象
    private final Log log = LogFactory.getLog(getClass());

    /**
     * 首页
     * @param session
     * @return
     */
    @RequestMapping("/")
    public ModelAndView toMain(HttpSession session){
        ModelAndView indexPage=new ModelAndView("cate");
        //全部主题
        List<Topic> topics=topicService.listTopicsAndUsers();
        List<Tab> tabs=tabService.getAllTabs();

        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        //获取用户信息
        Integer uid=(Integer) session.getAttribute("userId");
        User user=userService.getUserById(uid);
        //最热主题
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();

        indexPage.addObject("topics",topics);
        indexPage.addObject("hotestTopics",hotestTopics);
        indexPage.addObject("topicsNum",topicsNum);
        indexPage.addObject("usersNum",usersNum);
        indexPage.addObject("user",user);
        indexPage.addObject("tabs",tabs);
        return  indexPage;
    }

    /**
     * 帖子详情
     * @param id
     * @param session
     * @return
     */
    @RequestMapping("/t/{id}")
    public ModelAndView toTopic(@PathVariable("id")Integer id,HttpSession session){
        //点击量加一
        boolean ifSucc=topicService.clickAddOne(id);
        //获取主题信息
        Topic topic=topicService.selectById(id);
        //获取主题全部评论
        List<Reply> replies=replyService.getRepliesOfTopic(id);
        //获取评论数
        int repliesNum=replyService.repliesNum(id);
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        //获取用户信息
        Integer uid=(Integer) session.getAttribute("userId");
        User user=userService.getUserById(uid);
        //最热主题
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();
        List<Tab> tabs=tabService.getAllTabs();
        //渲染视图
        ModelAndView topicPage=new ModelAndView("detail");
        topicPage.addObject("topic",topic);
        topicPage.addObject("replies",replies);
        topicPage.addObject("repliesNum",repliesNum);
        topicPage.addObject("topicsNum",topicsNum);
        topicPage.addObject("usersNum",usersNum);
        topicPage.addObject("user",user);
        topicPage.addObject("hotestTopics",hotestTopics);
        topicPage.addObject("tabs",tabs);
        return topicPage;
    }

    /**
     * 板块分类帖子
     */
    @RequestMapping("/tab/{tabNameEn}")
    public ModelAndView toTabPage(@PathVariable("tabNameEn")String tabNameEn,HttpSession session){
        Tab tab=tabService.getByTabNameEn(tabNameEn);
        Integer tabId=tab.getId();

        ModelAndView indexPage=new ModelAndView("cate");
        //全部主题
        List<Topic> topics=topicService.listTopicsAndUsersOfTab(tabId);
        List<Tab> tabs=tabService.getAllTabs();
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        //获取用户信息
        Integer uid=(Integer) session.getAttribute("userId");
        User user=userService.getUserById(uid);
        //最热主题
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();
        indexPage.addObject("tabs",tabs);
        indexPage.addObject("topics",topics);
        indexPage.addObject("topicsNum",topicsNum);
        indexPage.addObject("usersNum",usersNum);
        indexPage.addObject("tab",tab);
        indexPage.addObject("user",user);
        indexPage.addObject("hotestTopics",hotestTopics);
        return  indexPage;
    }

    /**
     * 用户自己发帖的所有帖子
     */
    @RequestMapping("/look/{userid}")
    public ModelAndView touserPage(@PathVariable("userid")String userid,HttpSession session){

        ModelAndView indexPage=new ModelAndView("usertopic");
        //全部主题
        List<Topic> topics=topicService.listTopicsAndUsersOfUser(Integer.parseInt(userid));
        List<Tab> tabs=tabService.getAllTabs();
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        Integer currentID=(Integer)session.getAttribute("userId");
        //获取用户信息
        User user=userService.getUserById(currentID);
        //最热主题
        String username=userService.selectByPrimaryKey(Integer.parseInt(userid)).getUsername();
        List<Topic> hotestTopics=topicService.listMostCommentsTopics();
        indexPage.addObject("username",username);
        indexPage.addObject("currentID",currentID);
        indexPage.addObject("topics",topics);
        indexPage.addObject("topicsNum",topicsNum);
        indexPage.addObject("usersNum",usersNum);
        indexPage.addObject("user",user);
        indexPage.addObject("hotestTopics",hotestTopics);
        indexPage.addObject("tabs",tabs);
        return  indexPage;
    }

    /**
     * 删除帖子
     */
    @RequestMapping("/delete/{id}")
    public String deletepage(@PathVariable("id")String id,HttpSession session){
        topicService.deleteByPrimaryKey(Integer.parseInt(id));
        return "redirect:/look/"+session.getAttribute("userId");
    }

    /**
     * 精华帖页面
     */
    @RequestMapping("/look/jinghua")
    public ModelAndView jinghuaPage(HttpSession session){

        ModelAndView indexPage=new ModelAndView("cate");
        //全部主题
        List<Topic> topics=topicService.listTopicsAndUsersOfJing("1");
        List<Tab> tabs=tabService.getAllTabs();
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();
        if((Integer)session.getAttribute("userId")==null){
            List<Topic> hotestTopics=topicService.listMostCommentsTopics();
            indexPage.addObject("topics",topics);
            indexPage.addObject("topicsNum",topicsNum);
            indexPage.addObject("usersNum",usersNum);
            indexPage.addObject("hotestTopics",hotestTopics);
            indexPage.addObject("tabs",tabs);
        }else {
            Integer currentID=(Integer)session.getAttribute("userId");
            int userid=(Integer)session.getAttribute("userId");
            //获取用户信息
            User user=userService.getUserById(userid);
            //最热主题
            List<Topic> hotestTopics=topicService.listMostCommentsTopics();
            indexPage.addObject("currentID",currentID);
            indexPage.addObject("topics",topics);
            indexPage.addObject("topicsNum",topicsNum);
            indexPage.addObject("usersNum",usersNum);
            indexPage.addObject("user",user);
            indexPage.addObject("hotestTopics",hotestTopics);
            indexPage.addObject("tabs",tabs);
        }

        return  indexPage;
    }

    /**
     * 发表帖子
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/topic/add", method = RequestMethod.POST)
    public ModelAndView addTopic(HttpServletRequest request,HttpSession session){
        ModelAndView indexPage=new ModelAndView("redirect:/");
        //未登陆
        if(session.getAttribute("userId")==null){
            indexPage=new ModelAndView("redirect:/signin");
            return  indexPage;
        }
        //处理参数
        Integer userId=(Integer) session.getAttribute("userId");
        String title=request.getParameter("title");
        String content=request.getParameter("content");
        Byte tabId=Byte.parseByte(request.getParameter("tab"));
        //新建Topic
        Topic topic=new Topic();
        topic.setUserId(userId);
        topic.setTitle(title);
        topic.setContent(content);
        topic.setTabId(tabId);
        topic.setCreateTime(new Date());
        topic.setUpdateTime(new Date());
        topic.setJinghua("0");
        topic.setZhiding("0");
        //添加topic
        boolean ifSucc=topicService.addTopic(topic);
        boolean ifSuccAddCredit=userService.addCredit(1,userId);
        if (ifSucc){
            if (log.isInfoEnabled()){
                log.info("添加主题成功!");
            }
        }
        List<Tab> tabs=tabService.getAllTabs();
        indexPage.addObject("tabs",tabs);

        return  indexPage;
    }


    /**
    获得帖子信息，用户数据回显
     **/
    @RequestMapping("/get/{id}")
    public ModelAndView getTopicInfo(@PathVariable("id")String id,HttpSession session){
        Topic topic=topicService.selectById(Integer.parseInt(id));
        List<Tab> tabs=tabService.getAllTabs();

        ModelAndView mv=new ModelAndView("userupdatetopic");
        mv.addObject("user",userService.getUserById((Integer)session.getAttribute("userId")));
        mv.addObject("tabs",tabs);
        mv.addObject("topic",topic);
        return mv;
    }

    /**
     * 修改帖子内容
     * @param id
     * @param request
     * @return
     */

    @RequestMapping(value = "/topic/update/{id}", method = RequestMethod.POST)
    public String updateTopic(@PathVariable("id")String id,HttpServletRequest request){
        Topic topic=new Topic();
        topic.setId(Integer.parseInt(id));
        topic.setContent(request.getParameter("content"));
        topic.setTitle(request.getParameter("title"));
        Byte tabId=Byte.parseByte(request.getParameter("tab"));
        topic.setTabId(tabId);
        topic.setUpdateTime(new Date());
        topicService.updateByPrimaryKeySelective(topic);
        return "redirect:/t/"+topic.getId();

    }

    /**
     * 帖子加精和取消加精
     * @param id
     * @return
     */

    @RequestMapping("/topic/jing/{id}")
    public String jiajing(@PathVariable("id") String id){
        Topic topic=new Topic();
        topic.setId(Integer.parseInt(id));
        topic.setJinghua("1");
        Topic topic1=topicService.selectById(Integer.parseInt(id));
        int userid=topic1.getUserId();
        topicService.jiajingByPrimaryKey(topic);
        return "redirect:/";
    }

    @RequestMapping("/topic/quxiaojing/{id}")
    public String quxiaojiajing(@PathVariable("id") String id){
        Topic topic=new Topic();
        topic.setId(Integer.parseInt(id));
        topic.setJinghua("0");
        Topic topic1=topicService.selectById(Integer.parseInt(id));
        int userid=topic1.getUserId();
        topicService.jiajingByPrimaryKey(topic);
        return "redirect:/";
    }

    /**
     * 积分悬赏
     * @param replyid
     * @param id
     * @param topicid
     * @return
     */
    @RequestMapping("/topic/dashang/{replyid}&{id}&{topicid}")
    public String dashang(@PathVariable("replyid") String replyid,@PathVariable("id") String id,@PathVariable("topicid")String topicid){
        Byte replytype=userService.selectByPrimaryKey(Integer.parseInt(replyid)).getType();
        Byte idtype=userService.selectByPrimaryKey(Integer.parseInt(id)).getType();

        int replycredit=userService.selectByPrimaryKey(Integer.parseInt(replyid)).getCredit();
        int idcredit=userService.selectByPrimaryKey(Integer.parseInt(id)).getCredit();
        if(idtype==1){
            replycredit+=2;
            User user=new User();
            user.setId(Integer.parseInt(replyid));
            user.setCredit(replycredit);
            userService.updateUser(user);
        }else {
            if(idcredit>0){

                idcredit=idcredit-1;
                replycredit=replycredit+1;
                User user=new User();
                user.setId(Integer.parseInt(replyid));
                user.setCredit(replycredit);
                userService.updateUser(user);

                User user1=new User();
                user1.setId(Integer.parseInt(id));
                user1.setCredit(idcredit);
                userService.updateUser(user1);
            }else {
                return "404";
            }
        }
        return "redirect:/t/"+topicid;
    }
}

