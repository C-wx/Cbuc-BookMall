package life.bookmall.controller;

import life.bookmall.bean.Category;
import life.bookmall.bean.User;
import life.bookmall.evt.Result;
import life.bookmall.service.CategoryService;
import life.bookmall.service.OrderService;
import life.bookmall.service.ProductService;
import life.bookmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: adminController
 * @Author: Cbuc
 */
@Controller
public class AdminController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/main")
    public String main(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        Integer buyerCount = userService.queryCount("B");
        Integer sellerCount = userService.queryCount("C");
        Integer productCount = productService.queryList().size();
        Integer orderCount = orderService.queryCount();
        model.addAttribute("buyerCount",buyerCount);
        model.addAttribute("sellerCount",sellerCount);
        model.addAttribute("productCount",productCount);
        model.addAttribute("orderCount",orderCount);
        model.addAttribute("loginUser",loginUser);
        return "admin/main";
    }

    @RequestMapping("/categoryMana")
    public String categoryMana(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<Category> categories = categoryService.list();
        model.addAttribute("categories",categories);
        model.addAttribute("loginUser",loginUser);
        return "admin/categoryMana";
    }

    @RequestMapping("/userMana")
    public String userMana(Model model,HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        List<User> users = userService.queryList();
        model.addAttribute("users",users);
        model.addAttribute("loginUser",loginUser);
        return "admin/userMana";
    }

    @ResponseBody
    @RequestMapping("/addCategory")
    public Object addCategory(String name) {
        Category category = new Category();
        category.setName(name);
        category.setStatus("E");
        categoryService.doAdd(category);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/delCg")
    public Object delCg(Integer id) {
        Category category = new Category();
        category.setStatus("D");
        category.setId(id);
        categoryService.doDel(category);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/modifyCategory")
    public Object modifyCategory(Integer id, String name) {
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        categoryService.doMod(category);
        return Result.success(category);
    }

    @RequestMapping("/queryActiveSaled")
    @ResponseBody
    public Object queryActiveSaled() {
        List<Map<String,Object>> infos = productService.queryActive();
        return Result.success(infos);
    }

    @RequestMapping("/queryTopBooks")
    @ResponseBody
    public Object queryTopBooks() {
        List<Map<String,Object>> infos = productService.queryTop();
        return Result.success(infos);
    }

    @ResponseBody
    @RequestMapping("/getUserInfo")
    public Object getUserInfo(Long id) {
        User user = userService.queryDetail(id);
        return Result.success(user);
    }

    @ResponseBody
    @RequestMapping("/modifyUser")
    public Object modifyUser(User user) {
        int count = userService.doUpdate(user);
        if (count > 0) {
            return Result.success();
        }else {
            return Result.error();
        }
    }

    @ResponseBody
    @RequestMapping("/modUserStatus")
    public Object modUserStatus(Long id, String status) {
        User user = new User();
        user.setId(id);
        user.setStatus(status);
        userService.doUpdate(user);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/addUser")
    public Object addUser(User user) {
        user.setImg("/default-avatar.png");
        user.setCreate_time(new Date());
        user.setUpdate_time(new Date());
        userService.addOne(user);
        return Result.success();
    }
}