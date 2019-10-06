package life.bookmall.controller;

import life.bookmall.bean.Category;
import life.bookmall.bean.Product;
import life.bookmall.service.CategoryService;
import life.bookmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "/top", method = RequestMethod.GET)
    public String top() {
        return "include/top";
    }

    @RequestMapping("/kefu")
    public String kefu() {
        return "include/kefu";
    }
}
