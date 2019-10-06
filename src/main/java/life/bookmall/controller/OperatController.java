package life.bookmall.controller;

import life.bookmall.bean.Comment;
import life.bookmall.bean.Product;
import life.bookmall.bean.Property;
import life.bookmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: OperatController
 * @Author: Cbuc
 * @Date: 2019/9/26
 * @Version: 1.0
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
}
