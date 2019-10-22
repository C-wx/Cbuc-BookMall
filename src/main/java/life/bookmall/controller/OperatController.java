package life.bookmall.controller;

import com.github.pagehelper.PageHelper;
import com.mysql.cj.util.StringUtils;
import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.MallEnum.OrderPayStatus;
import life.bookmall.bean.*;
import life.bookmall.evt.Result;
import life.bookmall.service.*;
import life.bookmall.utils.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.*;

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
    public Object createOrder(Order order, @RequestParam(value = "idArray",required = false)String[] idArrays, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        if (!ObjectUtils.isEmpty(idArrays)) {
            StringBuilder sb = new StringBuilder();
            for (String orderLogId : idArrays) {
                OrderLog orderLog = orderLogService.queryDetail(Long.parseLong(orderLogId));
                Product product = productService.queryDetail(orderLog.getProduct_id());
                Order o = new Order();
                o.setUser_id(product.getUser_id());
                o.setProduct_id(product.getId());
                o.setReceiver(order.getReceiver());
                o.setAddr(order.getAddr());
                o.setComment(order.getComment());
                o.setPhone(order.getPhone());
                o.setNum(orderLog.getNum());
                o.setPost(order.getPost());
                o.setPostage(0f);
                o.setStatus(OrderPayStatus.WP.getStatus());
                o.setCreate_date(new Date());
                o.setUpdate_date(new Date());
                o.setOrder_code(UUID.randomUUID().toString().substring(0, 11));
                o.setPrice(orderLog.getNum()*product.getPrice());
                orderService.doAdd(o);
                sb.append(o.getId()+"-");
                orderLogService.updateById(Long.valueOf(orderLogId),o.getId());
                int carTotalCount = orderLogService.getCarTotalCount(loginUser.getId());
                session.setAttribute("carTotalCount",carTotalCount);
            }
            return Result.success(sb.substring(0,sb.length()-1));
        }else {
            return Result.error("结算错误！");
        }

    }

    @ResponseBody
    @RequestMapping("/payed")
    public Object payed(String order_id,float total,Model model) {
        String[] orderIds = order_id.split("-");
        Map<String,Object> info = new HashMap<>();
        for (String orderId : orderIds) {
            Order order = orderService.queryDetail(Long.valueOf(orderId));
            order.setPay_date(new Date());
            order.setStatus(OrderPayStatus.WD.getStatus());
            orderService.updateOrder(order);
            User user = new User();
            user.setBalance(order.getPrice());
            user.setId(productService.queryDetail(order.getProduct_id()).getUser_id());
            userService.updateBalance(user);
            info.put("addr",order.getAddr());
            info.put("receiver",order.getReceiver());
            info.put("phone",order.getPhone());
        }
        info.put("total",total);
        return Result.success(info);
    }

    @ResponseBody
    @RequestMapping("/deleteOrderLog")
    public Object deleteOrderLog(Long deleteOrderLogid,HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        int result = orderLogService.doDelete(deleteOrderLogid);
        int carTotalCount = orderLogService.getCarTotalCount(loginUser.getId());
        session.setAttribute("carTotalCount",carTotalCount);
        if (result > 0) {
            return Result.success(carTotalCount);
        }
        return Result.error();
    }

    @RequestMapping("/settlement")
    public String settlement(String params, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        String[] ids = params.split(":");
        List<OrderLog> orderLogs = new ArrayList<>();
        float total = 0L;
        for (String id : ids) {
            OrderLog orderLog = orderLogService.queryDetail(Long.parseLong(id));
            Product product = productService.queryDetail(orderLog.getProduct_id());
            orderLog.setProduct(product);
            orderLogs.add(orderLog);
            total += product.getPrice()*orderLog.getNum();
        }
        model.addAttribute("user",loginUser);
        model.addAttribute("orderLogs",orderLogs);
        model.addAttribute("total",total);
        model.addAttribute("ids",params);
        return "purchasePage";
    }

    @RequestMapping("/toOrderPage")
    public String toOrderPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Order> orders = orderService.queryList(loginUser.getId());
        orderService.fill(orders);
        model.addAttribute("orders",orders);
        return "orderPage";
    }

    @ResponseBody
    @RequestMapping("/deleteOrder")
    public Object deleteOrder(Long order_id) {
        Order order = new Order();
        order.setId(order_id);
        order.setStatus(OrderPayStatus.DD.getStatus());
        order.setUpdate_date(new Date());
        orderService.updateOrder(order);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/confirmedDeliver")
    public Object confirmedDeliver(Long orderId) {
        Order order = new Order();
        order.setId(orderId);
        order.setStatus(OrderPayStatus.WR.getStatus());
        order.setConfirm_date(new Date());
        orderService.updateOrder(order);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/issueRemark")
    public Object issueRemark(Long order_id, String msg, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        Order order = orderService.queryDetail(order_id);
        Long product_id = order.getProduct_id();
        Comment comment = new Comment();
        comment.setUser(loginUser);
        comment.setCommentator(loginUser.getId());
        comment.setCreate_time(new Date());
        comment.setLike_count(0L);
        comment.setMsg(msg);
        comment.setProduct_id(product_id);
        commentService.doAdd(comment);
        order.setStatus("SS");
        orderService.updateOrder(order);
        return Result.success();
    }


    @RequestMapping("/searchProduct")
    public String searchProduct(Model model, String keyword) {
        PageHelper.offsetPage(0, 20);
        List<Product> products = productService.search(keyword);
        for (Product product : products) {
            product.setCommentCount(commentService.getCount(product.getId()));
        }
        model.addAttribute("products", products);
        return "searchResult";
    }

    @ResponseBody
    @RequestMapping("/modUser")
    public Object modUser(User user, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        user.setUpdate_time(new Date());
        String imgName = files[0].getOriginalFilename();
        if (!StringUtils.isNullOrEmpty(imgName)) {
            // 上传图片
            FileUpload fileUpload = new FileUpload();
            List<String> list_image = fileUpload.upload_image(files,session);
            user.setImg("/"+list_image.get(0));
        }
        int result = userService.doUpdate(user);
        User loginUser = userService.getOne(user);
        session.setAttribute("user",loginUser);
        return Result.success("修改成功");
    }

    @ResponseBody
    @RequestMapping("/modPwd")
    public Object modPwd(User user) {
        User modUser = userService.getByName(user.getUser_name());
        if (!Objects.isNull(modUser)) {
            modUser.setPwd(user.getPwd());
            userService.doUpdate(modUser);
            return Result.success();
        }else {
            return Result.error();
        }
    }

}
