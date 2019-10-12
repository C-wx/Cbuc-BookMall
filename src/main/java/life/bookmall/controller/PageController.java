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
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: PageController
 * @Author: Cbuc
 * @Date: 2019/9/17
 * @Version: 1.0
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

    @RequestMapping("/home")
    public String toHome(Model model) {
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        List<Product> hotBooks = productService.queryHotBooks();
        List<Product> activeBooks = productService.queryActiveBooks();
        model.addAttribute("hotBooks",hotBooks);
        model.addAttribute("activeBooks",activeBooks);
        model.addAttribute("categories",categories);
        return "home";
    }

    @RequestMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

    @RequestMapping(value = "/toRegister", method = RequestMethod.GET)
    public String toRegister() {
        return "register";
    }

    @RequestMapping("/payPage")
    public String payPage(Integer order_id,float total) {
        System.out.println(order_id+total);
        return "alipay";
    }

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
}
