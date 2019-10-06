package life.bookmall.controller;

import life.bookmall.bean.User;
import life.bookmall.evt.Result;
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
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: LoginController
 * @Author: Cbuc
 * @Date: 2019/10/5
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    private OrderLogService orderLogService;

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(User user, String veryCode, HttpSession session) {
        String code = (String) session.getAttribute("img_session_code");
        if (!code.equals(veryCode)) {
            return Result.error("验证码错误！请重新输入...");
        }
        User activeUser = userService.getOne(user);
        if (!ObjectUtils.isEmpty(activeUser)) {
            session.setAttribute("user",activeUser);
            return Result.success("登录成功");
        }
        return Result.error("用户不存在，请检查用户名密码");
    }

    @RequestMapping("/checkLogin")
    @ResponseBody
    public String checkLogin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (!Objects.isNull(user))
            return "success";
        return "fail";
    }

    @ResponseBody
    @RequestMapping("/loginByAjax")
    public Object loginByAjax(User user, HttpSession session) {
        User userLogin = userService.getOne(user);
        if (userLogin!=null) {
            /*int cartTotalItemNumber = orderLogService.getCarCountByUserIdAndType(userLogin.getId());
            session.setAttribute("cartTotalItemNumber",cartTotalItemNumber);*/
            session.setAttribute("user",userLogin);
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @RequestMapping("/logout")
    public String loginOut(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/home";
    }

    @ResponseBody
    @RequestMapping("/register")
    public Object register(User user, @RequestParam("files") MultipartFile[] files, HttpSession session) {
        user.setCreate_time(new Date());
        user.setUpdate_time(new Date());
        // 上传图片
        FileUpload fileUpload = new FileUpload();
        List<String> list_image = fileUpload.upload_image(files,session);
        user.setImg("/"+list_image.get(0));
        int result = userService.addOne(user);
        if (result > 0) {
            return Result.success("注册成功");
        }
        return Result.error("服务器异常,请稍后重试");
    }
}
