package life.bookmall.service;

import life.bookmall.bean.Order;
import life.bookmall.bean.OrderExample;
import life.bookmall.bean.Product;
import life.bookmall.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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

    @Autowired
    private ProductService productService;


    public int doAdd(Order order) {
        return orderMapper.insertSelective(order);
    }

    public Order queryDetail(Long order_id) {
        return orderMapper.selectByPrimaryKey(order_id);
    }

    public int updateOrder(Order order) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andIdEqualTo(order.getId());
        return orderMapper.updateByExampleSelective(order, orderExample);
    }

    public List<Order> queryList(Long id) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andUser_idEqualTo(id).andStatusNotEqualTo("DD");
        orderExample.setOrderByClause("id desc");
        return orderMapper.selectByExample(orderExample);
    }

    public void fill(List<Order> orders) {
        for (Order order : orders) {
            Product product = productService.queryDetail(order.getProduct_id());
            order.setProduct(product);
        }
    }

    public Integer queryCount(Long id) {
        if (Objects.nonNull(id)) {
            OrderExample example = new OrderExample();
            example.createCriteria().andUser_idEqualTo(id).andStatusNotEqualTo("DD");
            return orderMapper.selectByExample(example).size();
        }else {
            OrderExample orderExample = new OrderExample();
            orderExample.createCriteria().andStatusNotEqualTo("DD");
            return orderMapper.selectByExample(orderExample).size();
        }
    }

    public List<Order> queryListMana(Long id) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andStatusNotEqualTo("DD").andUser_idEqualTo(id);
        return orderMapper.selectByExample(orderExample);
    }
}
