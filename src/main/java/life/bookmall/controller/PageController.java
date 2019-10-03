package life.bookmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
}
