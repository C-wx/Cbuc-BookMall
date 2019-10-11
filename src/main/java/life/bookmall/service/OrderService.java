package life.bookmall.service;

import life.bookmall.bean.Order;
import life.bookmall.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: OrderService
 * @Author: Cbuc
 */
@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;


    public int doAdd(Order order) {
        return orderMapper.insertSelective(order);
    }
}
