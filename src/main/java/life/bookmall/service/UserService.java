package life.bookmall.service;

import life.bookmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: UserService
 * @Author: Cbuc
 * @Date: 2019/9/26 17:00
 * @Version: 1.0
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

}
