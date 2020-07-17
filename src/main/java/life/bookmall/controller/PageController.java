package life.bookmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.bean.*;
import life.bookmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Explain 页面跳转控制器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/17
 */
@Controller
public class PageController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderLogService orderLogService;

    @Autowired
    private ContactService contactService;

    /**
     * @Explain    跳转首页
     * @param   model
     * @Return  "home"
     */
    @RequestMapping("/home")
    public String toHome(Model model,HttpSession session) {

        //查询所有目录名称
        List<Category> categories = categoryService.list();
        //填充当前目录下的所有书籍
        productService.fill(categories);
        //查询热卖书籍
        List<Product> hotBooks = productService.queryHotBooks();
        //查询活动书籍
        List<Product> activeBooks = productService.queryActiveBooks();

        // 验证是否存在用户
        User user = (User) session.getAttribute("user");
        if (!ObjectUtils.isEmpty(user)){
            User activeUser = userService.getOne(user);
            if (!ObjectUtils.isEmpty(activeUser)) {
                // 用户存在->查询购物车信息存入session
                int carTotalCount = orderLogService.getCarTotalCount(activeUser.getId());
                // 用户存在->查询留言信息存入session
                int contactCount = contactService.queryCount(activeUser.getId());
                session.setAttribute("carTotalCount",carTotalCount);
                session.setAttribute("contactCount",contactCount);
                session.setAttribute("user",activeUser);
            }
        }

        model.addAttribute("hotBooks",hotBooks);
        model.addAttribute("activeBooks",activeBooks);
        model.addAttribute("categories",categories);
        return "home";
    }

    /**
     * @Explain 跳转到登录页
     * @Return "login"
     */
    @RequestMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

    @RequestMapping("/toError")
    public String toError() {
        return "404";
    }

    /**
     * @Explain   跳转到注册页
     * @Return "register"
     */
    @RequestMapping(value = "/toRegister", method = RequestMethod.GET)
    public String toRegister() {
        return "register";
    }

    /**
     * @Explain   跳转到支付页
     * @param  order_id
     * @param  total
     * @Return "alipay"
     */
    @RequestMapping("/payPage")
    public String payPage(String order_id,float total) {
        return "alipay";
    }

    /**
     * @Explain   跳转到客服页面
     * @Return "includ/kefu"
     */
    @RequestMapping("/kefu")
    public String kefu() {
        return "include/kefu";
    }

    /**
     * @Explain   跳转到购物车页面
     * @param  model
     * @param  session
     * @Return "toCarPage"
     */
    @RequestMapping("/toCarPage")
    public String toCarPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<OrderLog> orderLogs = orderLogService.getListByUserIdAndType(loginUser.getId(), OrderLogType.BC.getType());
        for (OrderLog orderLog : orderLogs) {
            Product product = productService.queryDetail(orderLog.getProduct_id());
            orderLog.setProduct(product);
        }
        model.addAttribute("orderLogs",orderLogs);
        return "carPage";
    }

    /**
     * @Explain  跳转到个人中心
     * @param  session
     * @param  model
     * @Return
     */
    @RequestMapping("/selfPage")
    public String selfPage(HttpSession session,Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        model.addAttribute("user",loginUser);
        return "self";
    }

    /**
     * @Explain   跳转到消息管理页
     * @param   session
     * @param   model
     */
    @RequestMapping("/messagePage")
    public String messagePage(HttpSession session, Model model,
                              @RequestParam(value = "pn", defaultValue = "1") Integer pn,
                              @RequestParam(value = "size", defaultValue = "6") Integer size,
                              @RequestParam(value = "sort", defaultValue = "id") String sort,
                              @RequestParam(value = "order", defaultValue = "desc") String order) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //查询留言列表
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Contact> contacts = contactService.getListByUserId(loginUser.getId());
        contactService.fill(contacts);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(contacts, 5);
        //查询留言总数
        int contactCount = contactService.queryCount(loginUser.getId());
        session.setAttribute("contactCount",contactCount);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("user",loginUser);
        return "messagePage";
    }
}
