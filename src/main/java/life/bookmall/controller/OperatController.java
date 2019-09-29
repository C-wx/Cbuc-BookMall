package life.bookmall.controller;

import life.bookmall.bean.User;
import life.bookmall.evt.Result;
import life.bookmall.service.UserService;
import life.bookmall.utils.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Date;
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

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(User user, String veryCode, HttpSession session) {
        String code = (String) session.getAttribute("img_session_code");
        if (!code.equals(veryCode)) {
            return Result.error("验证码错误！请重新输入...");
        }
        if (!ObjectUtils.isEmpty(userService.getOne(user))) {
            session.setAttribute("user",user);
            return Result.success("登录成功");
        }
        return Result.error("用户不存在，请检查用户名密码");
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
