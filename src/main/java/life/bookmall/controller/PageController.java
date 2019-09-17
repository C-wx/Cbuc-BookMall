package life.bookmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.controller
 * @ClassName: PageController
 * @Author: Cbuc
 * @Date: 2019/9/17 16:23
 * @Version: 1.0
 */
@Controller
public class PageController {

    @RequestMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

}
