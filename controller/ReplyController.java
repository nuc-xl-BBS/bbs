package com.withstars.controller;

import com.withstars.domain.Mail;
import com.withstars.domain.Reply;
import com.withstars.service.impl.ReplyServiceImpl;
import com.withstars.service.impl.TopicServiceImpl;
import com.withstars.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import util.MailUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * 回复相关控制类
 */
@Controller
public class ReplyController {

    @Autowired
    public ReplyServiceImpl replyService;
    @Autowired
    public UserServiceImpl userService;
    @Autowired
    public TopicServiceImpl topicService;

    /**
     * 添加评论 topicid replyuserid content
     */
    @RequestMapping(value = "/reply/add",method = RequestMethod.POST)
    public ModelAndView addReply(HttpServletRequest request, HttpSession session){
        //处理参数
        Integer topicId=Integer.parseInt(request.getParameter("topicId"));
        String email=userService.selectByPrimaryKey(topicService.selectById(topicId).getUserId()).getEmail();
        Integer replyUserId=Integer.parseInt(request.getParameter("replyUserId"));
        String content=request.getParameter("content");
        //创建reply
        Reply reply=new Reply();
        reply.setTopicId(topicId);
        reply.setReplyUserId(replyUserId);
        reply.setContent(content);
        reply.setCreateTime(new Date());
        reply.setUpdateTime(new Date());
        //执行添加
        boolean ifSucc=replyService.addReply(reply);
        //添加积分
        boolean ifSuccAddCredit=userService.addCredit(1,replyUserId);
        //新建视图
        ModelAndView view=new ModelAndView("redirect:/t/"+topicId);

        Mail mail = new Mail();

        mail.setHost("smtp.qq.com"); // 设置邮件服务器,如果不用163的,自己找找看相关的
        mail.setSender("269536245@qq.com");
        mail.setReceiver(email); // 接收人
        mail.setUsername("269536245@qq.com"); // 登录账号,一般都是和邮箱名一样吧
        mail.setPassword("luahenvlcwbwbggh"); // 发件人邮箱的登录密码
        mail.setSubject("Mybbs的通知");
        mail.setMessage("亲爱的MYBBS用户您好，您收到一条新回复，请登录http://localhost:8080/MyBBS/查看");
        new MailUtil().send(mail);
        return view;
    }


}
