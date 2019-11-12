package life.bookmall.service;

import life.bookmall.MallEnum.OrderPayStatus;
import life.bookmall.bean.Order;
import life.bookmall.bean.OrderEvt;
import life.bookmall.bean.OrderExample;
import life.bookmall.bean.Product;
import life.bookmall.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
 * @Explain  订单处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private ProductService productService;

    /**
     * @Explain  插入订单记录
     * @param  order
     * @Return  int
     */
    public int doAdd(Order order) {
        return orderMapper.insertSelective(order);
    }

    /**
     * @Explain  查询订单记录详情
     * @param  order_id
     * @Return  Order
     */
    public Order queryDetail(Long order_id) {
        return orderMapper.selectByPrimaryKey(order_id);
    }

    /**
     * @Explain  更新订单记录
     * @param  order
     * @Return  int
     */
    public int updateOrder(Order order) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andIdEqualTo(order.getId());
        return orderMapper.updateByExampleSelective(order, orderExample);
    }

    /**
     * @Explain  查询属于对应商户的订单
     * @param  id
     * @Return  List
     */
    public List<Order> queryList(Long id) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andUser_idEqualTo(id).andStatusNotEqualTo(OrderPayStatus.DD.getStatus());
        orderExample.setOrderByClause("id desc");
        return orderMapper.selectByExample(orderExample);
    }

    /**
     * @Explain  为订单填充对应商品详情
     * @param  orders
     * @Return
     */
    public void fill(List<Order> orders) {
        for (Order order : orders) {
            Product product = productService.queryDetail(order.getProduct_id());
            order.setProduct(product);
        }
    }

    /**
     * @Explain  查询属于对应商户订单的数量
     * @param  id
     * @Return  int
     */
    public Integer queryCount(Long id) {
        if (Objects.nonNull(id)) {
            OrderExample example = new OrderExample();
            example.createCriteria().andUser_idEqualTo(id).andStatusNotEqualTo(OrderPayStatus.DD.getStatus());
            return orderMapper.selectByExample(example).size();
        }else {
            OrderExample orderExample = new OrderExample();
            orderExample.createCriteria().andStatusNotEqualTo(OrderPayStatus.DD.getStatus());
            return orderMapper.selectByExample(orderExample).size();
        }
    }

    public List<OrderEvt> querySellList(Long id) {
        return orderMapper.querySellList(id);
    }
}
