package life.bookmall.service;

import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.bean.OrderLog;
import life.bookmall.bean.OrderLogExample;
import life.bookmall.mapper.OrderLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;

import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: OrderLogService
 * @Author: Cbuc
 * @Date: 2019/10/5
 */
@Controller
public class OrderLogService {

    @Autowired
    private OrderLogMapper orderLogMapper;

    public List<OrderLog> getListByUserIdAndType(Long id, String type) {
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andTypeEqualTo(type).andUser_idEqualTo(id);
        return orderLogMapper.selectByExample(orderLogExample);
    }


    public int getCarCountByUserIdAndType(Long id) {
//        List<OrderLog> orderLogs = orderLogMapper.getCarCount(id, OrderLogType.BC.getType());
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andUser_idEqualTo(id).andTypeEqualTo(OrderLogType.BC.getType());
        List<OrderLog> orderLogs = orderLogMapper.selectByExample(orderLogExample);
        int total = 0;
        if (!ObjectUtils.isEmpty(orderLogs)) {
            for (OrderLog orderLog : orderLogs) {
                total += orderLog.getNum();
            }
        }
        return total;
    }

    public void updateByIdAndType(OrderLog orderLog) {
        OrderLogExample orderLogExample = new OrderLogExample();
        orderLogExample.createCriteria().andIdEqualTo(orderLog.getId());
        orderLogMapper.updateByExampleSelective(orderLog, orderLogExample);
    }

    public int getCarTotalCount(Long id) {
        List<OrderLog> orderLogs = orderLogMapper.getCarCount(id,OrderLogType.BC.getType());
        int count = 0;
        for (OrderLog orderLog : orderLogs) {
            count += orderLog.getNum();
        }
        return count;
    }

    public void doAdd(OrderLog orderLog) {
        orderLogMapper.insert(orderLog);
    }
}
