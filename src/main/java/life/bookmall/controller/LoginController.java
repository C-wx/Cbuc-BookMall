package life.bookmall.controller;

import life.bookmall.base.Result;
import life.bookmall.bean.User;
import life.bookmall.service.ContactService;
import life.bookmall.service.OrderLogService;
import life.bookmall.service.UserService;
import life.bookmall.utils.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * @Explain 登录控制器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderLogService orderLogService;

    @Autowired
    private ContactService contactService;

    /**
     * @Explain 登录操作,查询数据库做校验
     * @param  user,veryCode,session
     * @Return json对象(登录状态信息)
     */
    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(User user, String veryCode, HttpSession session) {
        //从sessin中获取存入的验证码进行校验
        String code = (String) session.getAttribute("img_session_code");
        if (!code.equalsIgnoreCase(veryCode)) {
            return Result.error("验证码错误！请重新输入...");
        }
        // 验证是否存在用户
        User activeUser = userService.getOne(user);
        if (!ObjectUtils.isEmpty(activeUser)) {
            // 用户存在->查询购物车信息存入session
            int carTotalCount = orderLogService.getCarTotalCount(activeUser.getId());
            // 用户存在->查询留言信息存入session
            int contactCount = contactService.queryCount(activeUser.getId());
            session.setAttribute("carTotalCount",carTotalCount);
            session.setAttribute("contactCount",contactCount);
            session.setAttribute("user",activeUser);
            return Result.success(activeUser);
        }
        return Result.error("用户不存在，请检查用户名密码");
    }

    /**
     * @Explain   检查登录状态,判断当前进行的操作的用户是否已登录
     * @param  session
     * @Return json对象
     */
    @RequestMapping("/checkLogin")
    @ResponseBody
    public Object checkLogin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (!Objects.isNull(user))
            return Result.success();
        return Result.error();
    }

    /**
     * @Explain 异步请求登录
     * @param  user,session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/loginByAjax")
    public Object loginByAjax(User user, HttpSession session) {
        User userLogin = userService.getOne(user);
        if (userLogin!=null) {
            int carTotalCount = orderLogService.getCarTotalCount(userLogin.getId());
            session.setAttribute("carTotalCount",carTotalCount);
            session.setAttribute("user",userLogin);
            return Result.success();
        } else {
            return Result.error();
        }
    }

    /**
     * @Explain    注销
     * @param  session
     * @Return "redirect:/home"
     */
    @RequestMapping("/logout")
    public String loginOut(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/home";
    }

    /**
     * @Explain 注册用户
     * @param  user,files,session
     * @Return  json对象
     */
    @ResponseBody
    @RequestMapping("/register")
    public Object register(User user, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        // 上传图片
        FileUpload fileUpload = new FileUpload();
        List<String> list_image = fileUpload.upload_image(files,session);

        user.setImg("/"+list_image.get(0));
        user.setBalance(0f);
        user.setCreate_time(new Date());
        user.setUpdate_time(new Date());

        int result = userService.addOne(user);
        if (result > 0) {
            return Result.success("注册成功");
        }
        return Result.error("服务器异常,请稍后重试");
    }
}
