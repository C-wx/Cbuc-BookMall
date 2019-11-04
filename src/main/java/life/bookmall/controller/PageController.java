package life.bookmall.controller;

import life.bookmall.MallEnum.OrderLogType;
import life.bookmall.bean.Category;
import life.bookmall.bean.OrderLog;
import life.bookmall.bean.Product;
import life.bookmall.bean.User;
import life.bookmall.service.CategoryService;
import life.bookmall.service.OrderLogService;
import life.bookmall.service.ProductService;
import life.bookmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    /**
     * @Explain    跳转首页
     * @param   model
     * @Return  "home"
     */
    @RequestMapping("/home")
    public String toHome(Model model) {

        //查询所有目录名称
        List<Category> categories = categoryService.list();
        //填充当前目录下的所有书籍
        productService.fill(categories);
        //查询热卖书籍
        List<Product> hotBooks = productService.queryHotBooks();
        //查询活动书籍
        List<Product> activeBooks = productService.queryActiveBooks();

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
}
