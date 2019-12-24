package com.withstars.service.impl;

import com.withstars.dao.TopicMapper;
import com.withstars.domain.Topic;
import com.withstars.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    public TopicMapper topicDao;

    //获取全部主题
    public List<Topic> getAllTopics() {
        return topicDao.getAllTopics();
    }

    //获取指定id主题
    public Topic selectById(Integer id) {
        return topicDao.selectById(id);
    }

    public List<Topic> listMostCommentsTopics() {
        return topicDao.listMostCommentsTopics();
    }

    public boolean addTopic(Topic topic) {
        return topicDao.insert(topic)>0;
    }

    public boolean clickAddOne(Integer id) {
        return topicDao.clickAddOne(id)>0;
    }

    public int getTopicsNum() {
        return topicDao.getTopicsNum();
    }

    public int updateByPrimaryKeySelective(Topic topic) {
       return topicDao.updateByPrimaryKeySelective(topic);
    }

    public int zhidingByPrimaryKey(Topic topic) {
        return topicDao.zhidingByPrimaryKey(topic);
    }

    public int jiajingByPrimaryKey(Topic topic) {
        return topicDao.jiajingByPrimaryKey(topic);
    }

    public int deleteByPrimaryKey(Integer integer) {
        return topicDao.deleteByPrimaryKey(integer);
    }

    public List<Topic> listTopicsAndUsers() {
        return topicDao.listTopicsAndUsers();
    }

    public List<Topic> listTopicsAndUsersOfTab(Integer tabId) {
        return topicDao.listTopicsAndUsersOfTab(tabId);
    }

    public List<Topic> listTopicsAndUsersOfUser(Integer userid) {
       return topicDao.listTopicsAndUsersOfUser(userid);
    }

    public List<Topic> listTopicsAndUsersOfJing(String jinghua) {
        return topicDao.listTopicsAndUsersOfJing(jinghua);
    }
}
