package life.bookmall.controller;

import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.MallEnum.OrderPayStatus;
import life.bookmall.bean.*;
import life.bookmall.evt.Result;
import life.bookmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: OperatController
 * @Author: Cbuc
 * @Date: 2019/9/26
 */
@Controller
public class OperatController {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private OrderLogService orderLogService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/showProduct")
    public String showProduct(Model model,Long product_id) {
        Product product = productService.queryDetail(product_id);
        productService.setCommentCount(product);
        List<Property> properties = propertyService.queryProperties(product_id);
        List<Comment> comments = commentService.queryCommnetsByProductId(product_id);
        commentService.setUser(comments);
        model.addAttribute("product",product);
        model.addAttribute("properties",properties);
        model.addAttribute("comments",comments);
        return "productDetail";
    }

    @ResponseBody
    @RequestMapping("/addPurchase")
    public Object addCart(long product_id, int num, HttpSession session) {
        User user = (User) session.getAttribute("user");
        productService.updateStock(product_id,num);
        Boolean flag = false;
        List<OrderLog> orderLogs = orderLogService.getListByUserIdAndType(user.getId(), OrderLogType.BC.getType());
        for (OrderLog orderLog : orderLogs) {
            if (orderLog.getProduct_id() == product_id) {
                orderLog.setNum(orderLog.getNum() + num);
                orderLog.setType(OrderLogType.BC.getType());
                orderLogService.updateByIdAndType(orderLog);
                flag = true;
                int carTotalCount = orderLogService.getCarTotalCount(user.getId());
                session.setAttribute("carTotalCount",carTotalCount);
                return Result.success(carTotalCount);
            }
        }
        if (!flag) {
            OrderLog orderLog = new OrderLog();
            orderLog.setUser_id(user.getId());
            orderLog.setNum(num);
            orderLog.setProduct_id(product_id);
            orderLog.setType(OrderLogType.BC.getType());
            orderLog.setStatus("E");
            orderLogService.doAdd(orderLog);
            int carTotalCount = orderLogService.getCarTotalCount(user.getId());
            session.setAttribute("carTotalCount",carTotalCount);
            return Result.success(carTotalCount);
        }
        return Result.error();
    }

    @RequestMapping("/buyNow")
    public String buyNow(Long product_id, int number,HttpSession session,Model model) {
        Product product = productService.queryDetail(product_id);
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        float total = product.getPrice()*number;
        List<OrderLog> orderLogs = new ArrayList<>();
        OrderLog orderLog = new OrderLog();
        orderLog.setProduct_id(product_id);
        orderLog.setType(OrderLogType.BN.getType());
        orderLog.setStatus("E");
        orderLog.setUser_id(loginUser.getId());
        orderLog.setNum(number);
        orderLog.setProduct(product);
        orderLogService.doAdd(orderLog);
        orderLogs.add(orderLog);
        model.addAttribute("user",loginUser);
        model.addAttribute("orderLogs",orderLogs);
        model.addAttribute("total",total);
        return "purchasePage";
    }

    @ResponseBody
    @RequestMapping("/createOrder")
    public Object createOrder(Order order, HttpSession session, Long orderLogId) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        order.setUser_id(loginUser.getId());
        String orderCode = UUID.randomUUID().toString().substring(0, 5);
        order.setOrder_code(orderCode);
        order.setCreate_date(new Date());
        order.setUpdate_date(new Date());
        order.setStatus(OrderPayStatus.WP.getStatus());
        orderService.doAdd(order);
        orderLogService.updateById(orderLogId,order.getId());
        return Result.success(order);
    }

    @ResponseBody
    @RequestMapping("/payed")
    public Object payed(Long order_id,float total,Model model) {
        Order order = orderService.queryDetail(order_id);
        order.setPay_date(new Date());
        order.setStatus(OrderPayStatus.WD.getStatus());
        orderService.updateOrder(order);
        return Result.success(order);
    }
}
