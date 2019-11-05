package life.bookmall.service;

import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.MallEnum.UserType;
import life.bookmall.bean.User;
import life.bookmall.bean.UserExample;
import life.bookmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.List;

/**
 * @Explain  用户处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/26
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * @Explain  根据用户名/电话号码&密码获取对应用户(状态非'D')
     * @param  user
     * @Return  User
     */
    public User getOne(User user) {
        UserExample userExample = new UserExample();
        UserExample secondExample = new UserExample();
        userExample.createCriteria()
                .andUser_nameEqualTo(user.getUser_name())
                .andPwdEqualTo(user.getPwd()).andStatusNotEqualTo(EnableStatus.Disable.getStatus());
        UserExample.Criteria criteria = secondExample.createCriteria();
        criteria.andPhoneEqualTo(user.getUser_name())
                .andPwdEqualTo(user.getPwd()).andStatusNotEqualTo(EnableStatus.Disable.getStatus());
        userExample.or(criteria);
        List<User> users = userMapper.selectByExample(userExample);
        if (!ObjectUtils.isEmpty(users)) {
            return users.get(0);
        }
        return null;
    }

    /**
     * @Explain   注册用户
     * @param  user
     * @Return int
     */
    public int addOne(User user) {
        return userMapper.insertSelective(user);
    }

    /**
     * @Explain  查询评论人信息
     * @param  commentator
     * @Return  User
     */
    public User queryDetail(Long commentator) {
        return userMapper.selectByPrimaryKey(commentator);
    }

    /**
     * @Explain  查询商城用户列表
     * @Return  List
     */
    public List<User> queryList() {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andTypeEqualTo(UserType.Buyer.getType());
        UserExample secondExample = new UserExample();
        UserExample.Criteria criteria = secondExample.createCriteria();
        criteria.andTypeEqualTo(UserType.Seller.getType());
        userExample.or(criteria);
        return userMapper.selectByExample(userExample);
    }

    /**
     * @Explain  查询卖家(买家)数量
     * @param  type
     * @Return  int
     */
    public Integer queryCount(String type) {
        if (UserType.Buyer.getType().equals(type)) {
            UserExample userExample = new UserExample();
            userExample.createCriteria().andTypeEqualTo(UserType.Buyer.getType());
            return userMapper.selectByExample(userExample).size();
        }else{
            UserExample userExample = new UserExample();
            userExample.createCriteria().andTypeEqualTo(UserType.Seller.getType());
            return userMapper.selectByExample(userExample).size();
        }
    }

    /**
     * @Explain  更新个人信息
     * @param  user
     * @Return  int
     */
    public int doUpdate(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * @Explain  更新账户余额(针对卖家)
     * @param  user
     * @Return
     */
    public int updateBalance(User user) {
        return userMapper.updateBalance(user);
    }

    /**
     * @Explain  修改密码
     * @param  user_name
     * @Return  User
     */
    public User getByName(String user_name) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUser_nameEqualTo(user_name);
        List<User> users = userMapper.selectByExample(userExample);
        if (!users.isEmpty()) {
            return users.get(0);
        }else {
            return null;
        }
    }
}
