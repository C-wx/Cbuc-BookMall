package life.bookmall.service;

import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.bean.OrderLog;
import life.bookmall.bean.OrderLogExample;
import life.bookmall.mapper.OrderLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * @Explain  订单日志服务器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
@Controller
public class OrderLogService {

    @Autowired
    private OrderLogMapper orderLogMapper;

    /**
     * @Explain   获取买家有效(状态非'D')的订单日志
     * @param  id
     * @param  type
     * @Return   List
     */
    public List<OrderLog> getListByUserIdAndType(Long id, String type) {
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andTypeEqualTo(type).andUser_idEqualTo(id).andStatusEqualTo(EnableStatus.Enable.getStatus());
        return orderLogMapper.selectByExample(orderLogExample);
    }

    /**
     * @Explain   更改订单日志信息
     * @param  orderLog
     */
    public void updateByIdAndType(OrderLog orderLog) {
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andIdEqualTo(orderLog.getId());
        orderLogMapper.updateByExampleSelective(orderLog, orderLogExample);
    }

    /**
     * @Explain  获取购物车数量
     * @param  id
     * @Return  int
     */
    public int getCarTotalCount(Long id) {
        List<OrderLog> orderLogs = orderLogMapper.getCarCount(id,OrderLogType.BC.getType());
        int count = 0;
        for (OrderLog orderLog : orderLogs) {
            count += orderLog.getNum();
        }
        return count;
    }

    /**
     * @Explain   增加订单日志记录
     * @param  orderLog
     */
    public void doAdd(OrderLog orderLog) {
        orderLogMapper.insert(orderLog);
    }

    /**
     * @Explain   生成订单后给订单日志记录设上对应订单ID
     * @param  orderLogId
     * @param  orderId
     * @Return   int
     */
    public int updateById(Long orderLogId,Long orderId) {
        OrderLog orderLog = new OrderLog();
        orderLog.setOrder_id(orderId);
        orderLog.setStatus(EnableStatus.Yi.getStatus());
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andIdEqualTo(orderLogId);
        return orderLogMapper.updateByExampleSelective(orderLog, orderLogExample);
    }

    /**
     * @Explain   删除当订单日志记录
     * @param  deleteOrderLogid
     * @Return  int
     */
    public int doDelete(Long deleteOrderLogid) {
        OrderLog orderLog = new OrderLog();
        orderLog.setStatus(EnableStatus.Disable.getStatus());
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andIdEqualTo(deleteOrderLogid);
        return orderLogMapper.updateByExampleSelective(orderLog, orderLogExample);
    }

    /**
     * @Explain   查询订单日志记录详情
     * @param  id
     * @Return  OrderLog
     */
    public OrderLog queryDetail(long id) {
        return orderLogMapper.selectByPrimaryKey(id);
    }

}
