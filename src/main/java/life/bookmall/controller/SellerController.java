package life.bookmall.controller;

import com.mysql.cj.util.StringUtils;
import life.bookmall.bean.Category;
import life.bookmall.bean.Order;
import life.bookmall.bean.Product;
import life.bookmall.bean.User;
import life.bookmall.evt.Result;
import life.bookmall.service.CategoryService;
import life.bookmall.service.OrderService;
import life.bookmall.service.ProductService;
import life.bookmall.service.UserService;
import life.bookmall.utils.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: SellerController
 * @Author: Cbuc
 * @Date: 2019/10/19
 */
@Controller
public class SellerController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/querySaledStatistic")
    @ResponseBody
    public Object querySaledStatistic(HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Map<String,Object>> infos = productService.querySaled(loginUser.getId());
        return Result.success(infos);
    }

    @ResponseBody
    @RequestMapping("/queryStocks")
    public Object queryStocks(HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Map<String,Object>> infos = productService.queryStocks(loginUser.getId());
        return Result.success(infos);
    }

    @RequestMapping("/offerMana")
    public String toOfferMana(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Product> products = productService.queryList(loginUser.getId());
        productService.fillCategory(products);
        model.addAttribute("products",products);
        model.addAttribute("loginUser",loginUser);
        return "admin/offerMana";
    }

    @RequestMapping("/orderMana")
    public String toOrderMana(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Order> orders = orderService.queryListMana(loginUser.getId());
        for (Order order : orders) {
            Product product = productService.queryDetail(order.getProduct_id());
            order.setProduct(product);
        }
        model.addAttribute("orders",orders);
        model.addAttribute("loginUser",loginUser);
        return "admin/orderMana";
    }

    @RequestMapping("/operaOffer")
    public String toOperaOffer(@RequestParam(value = "id",required = false) Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        Product product = productService.queryDetail(id);
        model.addAttribute("product",product);
        model.addAttribute("loginUser",loginUser);
        return "admin/operaOffer";
    }

    @ResponseBody
    @RequestMapping("/getProductInfo")
    public Object getProductInfo(Long id) {
        Product product = productService.queryDetail(id);
        Category category = categoryService.queryDetail(product.getCategory_id());
        List<Category> categories = categoryService.list();
        product.setCategory(category);
        product.setCategories(categories);
        return Result.success(product);
    }
    @ResponseBody
    @RequestMapping("/getCategoryInfo")
    public Object getCategoryInfo() {
        List<Category> categories = categoryService.list();
        return Result.success(categories);
    }

    @ResponseBody
    @RequestMapping("/modOffer")
    public Object modOffer(Product product, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        if (!StringUtils.isNullOrEmpty(files[0].getOriginalFilename())) {
            FileUpload fileUpload = new FileUpload();
            List<String> list_image = fileUpload.upload_image(files,session);
            product.setImg("/"+list_image.get(0));
        }
        productService.doUpdate(product);
        return Result.success();
    }
    @ResponseBody
    @RequestMapping("/addOffer")
    public Object addOffer(Product product, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        if (!StringUtils.isNullOrEmpty(files[0].getOriginalFilename())) {
            FileUpload fileUpload = new FileUpload();
            List<String> list_image = fileUpload.upload_image(files,session);
            product.setImg("/"+list_image.get(0));
        }
        product.setUser_id(loginUser.getId());
        product.setSaled(0);
        product.setStatus("E");
        product.setCommentCount(0);
        productService.doAdd(product);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/changeStatus")
    public Object changeStatus(Long id, String status) {
        Product product = new Product();
        product.setId(id);
        product.setStatus(status);
        productService.doUpdate(product);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/delivery")
    public Object delivery(Long id, String status) {
        Order order = new Order();
        order.setId(id);
        order.setStatus(status);
        order.setDelivery_date(new Date());
        orderService.updateOrder(order);
        return Result.success();
    }

}
