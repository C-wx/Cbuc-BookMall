package life.bookmall.controller;

import com.github.pagehelper.PageHelper;
import com.mysql.cj.util.StringUtils;
import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.MallEnum.OrderPayStatus;
import life.bookmall.base.Result;
import life.bookmall.bean.*;
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
 * @Explain 主页操作控制器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/26
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

    @Autowired
    private ContactService contactService;

    /**
     * @Explain 跳转到商品详情页
     * @param  model,product_id
     * @Return "productDetail"
     */
    @RequestMapping("/showProduct")
    public String showProduct(Model model,Long product_id) {

        //通过ID查询到当前商品
        Product product = productService.queryDetail(product_id);
        //获取当前商品的评价数量
        productService.setCommentCount(product);
        //获取当前商品的商品属性
        List<Property> properties = propertyService.queryProperties(product_id);
        //获取当前商品的评价信息
        List<Comment> comments = commentService.queryCommnetsByProductId(product_id);
        //获取评价信息对应的评价用户
        commentService.setUser(comments);

        model.addAttribute("product",product);
        model.addAttribute("properties",properties);
        model.addAttribute("comments",comments);
        return "productDetail";
    }

    /**
     * @Explain 加入购物车操作
     * @param  product_id
     * @param  num
     * @param  session
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/addPurchase")
    public Object addCart(long product_id, int num, HttpSession session) {
        User user = (User) session.getAttribute("user");

        //更新商品库存
        productService.updateStock(product_id,num);

        //查询订单日志表(当前用户,通过加购的订单)
        List<OrderLog> orderLogs = orderLogService.getListByUserIdAndType(user.getId(), OrderLogType.BC.getType());

        /**
         * 遍历订单记录,查询是否已经加购了当前商品
         * 已加购 : 更新对应订单记录的商品数量
         * 未加购 : 生成新的订单记录
         */
        Boolean flag = false;
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

    /**
     * @Explain 立即购买操作 - 跳转到提交订单页
     * @param  product_id
     * @param  number
     * @param  session
     * @param  model
     * @Return "purchasePage"
     */
    @RequestMapping("/buyNow")
    public String buyNow(Long product_id, int number,HttpSession session,Model model) {
        // 获取到购买的商品信息
        Product product = productService.queryDetail(product_id);
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);

        // 计算商品总价
        float total = product.getPrice()*number;
        List<OrderLog> orderLogs = new ArrayList<>();

        // 生成订单日志
        OrderLog orderLog = new OrderLog();
        orderLog.setProduct_id(product_id);
        orderLog.setType(OrderLogType.BN.getType());
        orderLog.setStatus("E");
        orderLog.setUser_id(loginUser.getId());
        orderLog.setNum(number);
        orderLog.setProduct(product);
        orderLogService.doAdd(orderLog);

        // 提交订单信息到提交订单页
        orderLogs.add(orderLog);
        model.addAttribute("user",loginUser);
        model.addAttribute("orderLogs",orderLogs);
        model.addAttribute("total",total);
        return "purchasePage";
    }


    /**
     * @Explain 生成购买订单 -- 包含:已支付  未支付
     * @param  order
     * @param  idArrays
     * @param  session
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/createOrder")
    public Object createOrder(Order order, @RequestParam(value = "idArray",required = false)String[] idArrays, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        if (!ObjectUtils.isEmpty(idArrays)) {   //idArrays : 可加购多种商品, 因此存在多个订单日志ID
            StringBuilder sb = new StringBuilder();
            //遍历订单日志ID, 查询对应加购订单
            for (String orderLogId : idArrays) {
                OrderLog orderLog = orderLogService.queryDetail(Long.parseLong(orderLogId));
                Product product = productService.queryDetail(orderLog.getProduct_id());
                //生成订单
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

                //拼接订单ID,提交给支付页
                sb.append(o.getId()+"-");
                //更新订单日志表, 说明当前日志已成功生成订单
                orderLogService.updateById(Long.valueOf(orderLogId),o.getId());
                //更新购物车数量, 若已生成订单, 则从购物车中移除
                int carTotalCount = orderLogService.getCarTotalCount(loginUser.getId());
                session.setAttribute("carTotalCount",carTotalCount);
            }
            return Result.success(sb.substring(0,sb.length()-1));
        }else {
            return Result.error("结算错误！");
        }
    }

    /**
     * @Explain 支付操作
     * @param  order_id
     * @param  total
     * @param  model
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/payed")
    public Object payed(String order_id,float total,Model model) {
        String[] orderIds = order_id.split("-");
        Map<String,Object> info = new HashMap<>();
        //遍历订单ID, 操作对应订单
        for (String orderId : orderIds) {
            Order order = orderService.queryDetail(Long.valueOf(orderId));
            order.setPay_date(new Date());
            order.setStatus(OrderPayStatus.WD.getStatus());
            orderService.updateOrder(order);

            // 将支付的金额返给卖家账户
            User user = new User();
            user.setBalance(order.getPrice());
            user.setId(productService.queryDetail(order.getProduct_id()).getUser_id());
            userService.updateBalance(user);

            //订单支付信息
            info.put("addr",order.getAddr());
            info.put("receiver",order.getReceiver());
            info.put("phone",order.getPhone());
        }
        info.put("total",total);
        return Result.success(info);
    }

    /**
     * @Explain    将商品移除购物车
     * @param  deleteOrderLogid
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/deleteOrderLog")
    public Object deleteOrderLog(Long deleteOrderLogid,HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);

        //移除购物车操作
        int result = orderLogService.doDelete(deleteOrderLogid);

        //更新购物车数量
        int carTotalCount = orderLogService.getCarTotalCount(loginUser.getId());

        session.setAttribute("carTotalCount",carTotalCount);
        if (result > 0) {
            return Result.success(carTotalCount);
        }
        return Result.error();
    }

    /**
     * @Explain   购物车结算 -- 跳转到提交订单页
     * @param  params
     * @param  session
     * @param  model
     * @Return  "purchasePage"
     */
    @RequestMapping("/settlement")
    public String settlement(String params, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        // 加购的商品ID
        String[] ids = params.split(":");
        List<OrderLog> orderLogs = new ArrayList<>();
        float total = 0L;
        // 查询商品详情
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

    /**
     * @Explain 跳转到订单页
     * @param  model
     * @param session
     * @Return "orderPage"
     */
    @RequestMapping("/toOrderPage")
    public String toOrderPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        // 查询所有订单
        List<Order> orders = orderService.queryList(loginUser.getId());
        // 为相应订单填充对应商品
        orderService.fill(orders);
        model.addAttribute("orders",orders);
        return "orderPage";
    }

    /**
     * @Explain  删除订单
     * @param  order_id
     * @Return  json对象
     */
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

    /**
     * @Explain  确认收货
     * @param    orderId
     * @Return  json对象
     */
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

    /**
     * @Explain   发表评论
     * @param  order_id
     * @param  msg
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/issueRemark")
    public Object issueRemark(Long order_id, String msg, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);

        // 查询当前订单 --> 获取到对应商品ID
        Order order = orderService.queryDetail(order_id);
        Long product_id = order.getProduct_id();

        // 生成评论
        Comment comment = new Comment();
        comment.setUser(loginUser);
        comment.setCommentator(loginUser.getId());
        comment.setCreate_time(new Date());
        comment.setLike_count(0L);
        comment.setMsg(msg);
        comment.setProduct_id(product_id);
        commentService.doAdd(comment);

        // 更新订单状态
        order.setStatus("SS");
        orderService.updateOrder(order);
        return Result.success();
    }

    /**
     * @Explain   搜索商品 -- 跳转到商品结果页
     * @param  model
     * @param  keyword
     * @Return "searchResult"
     */
    @RequestMapping("/searchProduct")
    public String searchProduct(Model model, String keyword) {

        //设置分页 , 每页20条数据
        PageHelper.offsetPage(0, 20);

        //按照关键字查询
        List<Product> products = productService.search(keyword);
        for (Product product : products) {
            // 获取当前商品的评论数
            product.setCommentCount(commentService.queryCount(product.getId()));
        }
        model.addAttribute("products", products);
        return "searchResult";
    }

    /**
     * @Explain 修改个人信息
     * @param  user
     * @param  files
     * @param  session
     * @Return  json对象
     */
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

    /**
     * @Explain  修改密码
     * @param  user
     * @Return  json对象
     */
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

    /**
     * @Explain   修改加购数量
     * @param  orderLogId
     * @param  number
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/changeOrderLog")
    public Object changeOrderLog(Long orderLogId,Integer number) {
        OrderLog orderLog = new OrderLog();
        orderLog.setId(orderLogId);
        orderLog.setNum(number);
        orderLogService.updateByIdAndType(orderLog);
        return Result.success();
    }

    /**
     * @Explain  添加留言
     * @param  content
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/addContact")
    public Object addContact(String content,HttpSession session) {
        //获取留言者
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);

        Contact contact = new Contact();
        contact.setContactor(loginUser.getId());
        contact.setContent(content);
        contact.setReceiveror(1L);
        int result = contactService.doAdd(contact);

        if (result>0) {
            return Result.success();
        }else {
            return Result.error("添加留言异常，请稍后再试！");
        }
    }

    @ResponseBody
    @RequestMapping("/readReply")
    public Object readReply(Long id,HttpSession session) {
        //获取留言者
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);

        Contact contact = new Contact();
        contact.setId(id);
        contact.setStatus(EnableStatus.Disable.getStatus());
        int count = contactService.doUpdate(contact);
        //查询留言信息存入session
        int contactCount = contactService.queryCount(loginUser.getId());
        session.setAttribute("contactCount",contactCount);
        if (count>0) {
            return Result.success(contactCount);
        }else {
            return Result.error("读消息异常");
        }
    }

}
