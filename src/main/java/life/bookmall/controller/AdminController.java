package life.bookmall.controller;

import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.MallEnum.UserType;
import life.bookmall.base.Result;
import life.bookmall.bean.Category;
import life.bookmall.bean.Contact;
import life.bookmall.bean.User;
import life.bookmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Explain 管理员界面控制器
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

    @Autowired
    private ContactService contactService;

    /**
     * @Explain 跳转到管理员(卖家)后台主界面
     * @param model,session
     * @Return  "admin/main"
     */
    @RequestMapping("/main")
    public String main(Model model, HttpSession session) {
        Map<String,Object> maps = new HashMap<>();
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        /** 管理员登录带入到页面的信息*/
        Integer buyerCount = userService.queryCount(UserType.Buyer.getType());       //买家数量
        Integer sellerCount = userService.queryCount(UserType.Seller.getType());      //卖家数量
        Integer productTotalCount = productService.queryList(null).size();      //商城总商品数
        Integer orderTotalCount = orderService.queryCount(null);         //商城订单总数
        maps.put("buyerCount",buyerCount);
        maps.put("sellerCount",sellerCount);
        maps.put("productCount",productTotalCount);
        maps.put("orderCount",orderTotalCount);
        /** 卖家登录带入到页面的信息*/
        Integer sptc = productService.queryList(loginUser.getId()).size();      //对应卖家发布商品
        Integer sotc = orderService.queryCount(loginUser.getId());              //对应卖家的订单数
        Float money = loginUser.getBalance();                                   //对应卖家账户信息
        maps.put("sptc",sptc);
        maps.put("sotc",sotc);
        maps.put("money",money);

        model.addAttribute("maps",maps);
        maps.put("loginUser",loginUser);
        return "admin/main";
    }


    /**
     * @Explain 跳转到分类管理类
     * @param  model,session
     * @Return "admin/categoryMana"
     */
    @RequestMapping("/categoryMana")
    public String categoryMana(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        // 分类信息
        List<Category> categories = categoryService.list();
        model.addAttribute("categories",categories);
        model.addAttribute("loginUser",loginUser);
        return "admin/categoryMana";
    }

    /**
     * @Explain 跳转到用户管理界面
     * @param  model,session
     * @Return "admin/userMana"
     */
    @RequestMapping("/userMana")
    public String userMana(Model model,HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        // 用户信息
        List<User> users = userService.queryList();
        model.addAttribute("users",users);
        model.addAttribute("loginUser",loginUser);
        return "admin/userMana";
    }

    /**
     * @Explain 添加分类信息操作
     * @param  name
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/addCategory")
    public Object addCategory(String name) {
        Category category = new Category();
        category.setName(name);
        category.setStatus(EnableStatus.Enable.getStatus());
        categoryService.doAdd(category);
        return Result.success();
    }

    /**
     * @Explain 删除分类信息操作
     * @param  id
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/delCg")
    public Object delCg(Integer id) {
        Category category = new Category();
        category.setStatus(EnableStatus.Disable.getStatus());
        category.setId(id);
        categoryService.doDel(category);
        return Result.success();
    }

    /**
     * @Explain 修改分类信息操作
     * @param  id,name
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/modifyCategory")
    public Object modifyCategory(Integer id, String name) {
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        categoryService.doMod(category);
        return Result.success(category);
    }

    /**
     * @Explain 查询活动商品销售情况
     * @param
     * @Return  json对象(List集合)
     */
    @RequestMapping("/queryActiveSaled")
    @ResponseBody
    public Object queryActiveSaled() {
        List<Map<String,Object>> infos = productService.queryActive();
        return Result.success(infos);
    }

    /**
     * @Explain 查询销售TOP5的商品销售情况
     * @param
     * @Return  json对象(List集合)
     */
    @RequestMapping("/queryTopBooks")
    @ResponseBody
    public Object queryTopBooks() {
        List<Map<String,Object>> infos = productService.queryTop();
        return Result.success(infos);
    }

    /**
     * @Explain 查询对应的用户信息(用户修改回显)
     * @param  id
     * @Return json对象(用户对象)
     */
    @ResponseBody
    @RequestMapping("/getUserInfo")
    public Object getUserInfo(Long id) {
        User user = userService.queryDetail(id);
        return Result.success(user);
    }

    /**
     * @Explain 修改用户信息
     * @param  user
     * @Return json对象(成功码:100 失败码-100)
     */
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

    /**
     * @Explain 禁用/启用用户(通过状态来判断当前用户是否启用状态,E:启动 D:禁用)
     * @param  id,status
     * @Return json对象
     */
    @ResponseBody
    @RequestMapping("/modUserStatus")
    public Object modUserStatus(Long id, String status) {
        User user = new User();
        user.setId(id);
        user.setStatus(status);
        userService.doUpdate(user);
        return Result.success();
    }

    /**
     * @Explain 添加用户
     * @param  user
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/addUser")
    public Object addUser(User user) {
        user.setImg("/default-avatar.png");
        user.setCreate_time(new Date());
        user.setUpdate_time(new Date());
        user.setBalance(0f);
        userService.addOne(user);
        return Result.success();
    }

    /**
     * @Explain  回复操作
     * @param  content
     * @param  receivor
     * @param  session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/reply")
    public Object reply(String content, Long receivor, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        Contact contact = new Contact();
        contact.setReceiveror(receivor);
        contact.setContactor(loginUser.getId());
        contact.setContent(content);
        int count = contactService.doAdd(contact);
        if (count>0) {
            return Result.success();
        }else {
            return Result.error("回复操作异常!");
        }
    }

    /**
     * @Explain   跳转到消息管理页
     * @param   session
     * @param   model
     * @Return
     */
    @RequestMapping("/contactMana")
    public String concactPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        User loginUser = userService.getOne(user);
        //获取给管理的留言
        List<Contact> contacts = contactService.getListByUserId(loginUser.getId());
        //填充留言者信息
        contactService.fill(contacts);
        model.addAttribute("loginUser",loginUser);
        model.addAttribute("contacts",contacts);
        return "admin/contactMana";
    }
}
