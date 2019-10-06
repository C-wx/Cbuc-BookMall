package life.bookmall.service;

import life.bookmall.bean.User;
import life.bookmall.bean.UserExample;
import life.bookmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: UserService
 * @Author: Cbuc
 * @Date: 2019/9/26
 * @Version: 1.0
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public User getOne(User user) {
        UserExample userExample = new UserExample();
        UserExample secondExample = new UserExample();
        userExample.createCriteria()
                .andUser_nameEqualTo(user.getUser_name())
                .andPwdEqualTo(user.getPwd());
        UserExample.Criteria criteria = secondExample.createCriteria();
        criteria.andPhoneEqualTo(user.getUser_name())
                .andPwdEqualTo(user.getPwd());
        userExample.or(criteria);
        List<User> users = userMapper.selectByExample(userExample);
        if (!ObjectUtils.isEmpty(users)) {
            return users.get(0);
        }
        return null;
    }

    public int addOne(User user) {
        return userMapper.insertSelective(user);
    }

    public static void main(String[] args) {
        //当前项目下路径
        File file = new File("");
        String filePath = null;
        try {
            filePath = file.getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(filePath);
    }

    public User queryDetail(Long commentator) {
        return userMapper.selectByPrimaryKey(commentator);
    }
}
