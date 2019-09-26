package life.bookmall.controller;

import life.bookmall.bean.User;
import life.bookmall.evt.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: OperatController
 * @Author: Cbuc
 * @Date: 2019/9/26 16:52
 * @Version: 1.0
 */
@Controller
public class OperatController {



    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(User user, String veryCode, HttpSession session) {
        String code = (String) session.getAttribute("img_session_code");
        if (!code.equals(veryCode)) {
            return Result.error("验证码错误！请重新输入...");
        }

        return Result.success();
    }
}
