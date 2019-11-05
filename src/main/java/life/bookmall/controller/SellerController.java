package life.bookmall.controller;

import com.mysql.cj.util.StringUtils;
import life.bookmall.base.Result;
import life.bookmall.bean.Category;
import life.bookmall.bean.Order;
import life.bookmall.bean.Product;
import life.bookmall.bean.User;
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
 * @Explain 卖家管理后台
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/19
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

    /**
     * @Explain    查询销售统计
     * @param  session
     * @Return  json对象
     */
    @RequestMapping("/querySaledStatistic")
    @ResponseBody
    public Object querySaledStatistic(HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //根据当前卖家ID,查询卖家发布商品的销售情况
        List<Map<String,Object>> infos = productService.querySaled(loginUser.getId());
        return Result.success(infos);
    }

    /**
     * @Explain  查询商品库存数
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/queryStocks")
    public Object queryStocks(HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //根据当前卖家ID,查询卖家发布商品的库存情况
        List<Map<String,Object>> infos = productService.queryStocks(loginUser.getId());
        return Result.success(infos);
    }

    /**
     * @Explain  跳转到商品管理页面
     * @param  session
     * @param  model
     * @Return  "admin/offerMana"
     */
    @RequestMapping("/offerMana")
    public String toOfferMana(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //根据商户ID查询发布的商品信息
        List<Product> products = productService.queryList(loginUser.getId());
        //填充商品的分类信息
        productService.fillCategory(products);
        model.addAttribute("products",products);
        model.addAttribute("loginUser",loginUser);
        return "admin/offerMana";
    }

    /**
     * @Explain   跳转到订单管理页面
     * @param  session
     * @param  model
     * @Return "admin/orderMana"
     */
    @RequestMapping("/orderMana")
    public String toOrderMana(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //查询属于当前商户的订单
        List<Order> orders = orderService.queryList(loginUser.getId());
        for (Order order : orders) {
            //为订单填充商品信息
            Product product = productService.queryDetail(order.getProduct_id());
            order.setProduct(product);
        }
        model.addAttribute("orders",orders);
        model.addAttribute("loginUser",loginUser);
        return "admin/orderMana";
    }

    /**
     * @Explain   跳转到发布(修改)商品页面
     * @param  id
     * @param  session
     * @param  model
     * @Return  "admin/operaOffer"
     */
    @RequestMapping("/operaOffer")
    public String toOperaOffer(@RequestParam(value = "id",required = false) Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //若是修改商品,则查询当前商品ID对应的详细商品信息
        Product product = productService.queryDetail(id);
        model.addAttribute("product",product);
        model.addAttribute("loginUser",loginUser);
        return "admin/operaOffer";
    }

    /**
     * @Explain   获取商品的具体信息
     * @param  id
     * @Return   json对象
     */
    @ResponseBody
    @RequestMapping("/getProductInfo")
    public Object getProductInfo(Long id) {
        //获取商品详情
        Product product = productService.queryDetail(id);
        //获取当前商品对应的分类
        Category category = categoryService.queryDetail(product.getCategory_id());
        //获取分类列表
        List<Category> categories = categoryService.list();
        product.setCategory(category);
        product.setCategories(categories);
        return Result.success(product);
    }
    
    /**
     * @Explain  获取分类列表信息
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/getCategoryInfo")
    public Object getCategoryInfo() {
        List<Category> categories = categoryService.list();
        return Result.success(categories);
    }

    /**
     * @Explain   修改商品信息
     * @param  product
     * @param  files
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/modOffer")
    public Object modOffer(Product product, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        //当主图发生变化时,上传图片
        if (!StringUtils.isNullOrEmpty(files[0].getOriginalFilename())) {
            FileUpload fileUpload = new FileUpload();
            List<String> list_image = fileUpload.upload_image(files,session);
            product.setImg("/"+list_image.get(0));
        }
        //更新操作
        productService.doUpdate(product);
        return Result.success();
    }

    /**
     * @Explain    添加商品
     * @param  product
     * @param  files
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/addOffer")
    public Object addOffer(Product product, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //上传图片
        if (!StringUtils.isNullOrEmpty(files[0].getOriginalFilename())) {
            FileUpload fileUpload = new FileUpload();
            List<String> list_image = fileUpload.upload_image(files,session);
            product.setImg("/"+list_image.get(0));
        }
        //生成商品
        product.setUser_id(loginUser.getId());
        product.setSaled(0);
        product.setStatus("E");
        product.setCommentCount(0);
        //添加操作
        productService.doAdd(product);
        return Result.success();
    }

    /**
     * @Explain   上下架操作
     * @param  id
     * @param  status
     * @Return    json对象
     */
    @ResponseBody
    @RequestMapping("/changeStatus")
    public Object changeStatus(Long id, String status) {
        Product product = new Product();
        product.setId(id);
        product.setStatus(status);
        productService.doUpdate(product);
        return Result.success();
    }

    /**
     * @Explain   商品发货
     * @param  id
     * @param  status
     * @Return   json对象
     */
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
