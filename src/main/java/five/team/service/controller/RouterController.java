package five.team.service.controller;

import five.team.service.entity.AclUser;
import five.team.service.service.AclUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RouterController {
    @RequestMapping({"/", "toLogin"})
    public String index() {
        return "login";
    }

    @RequestMapping("main")
    public String main() {
        System.out.println("RouterController.main");
        return "index";
    }

    @RequestMapping("goVip1")
    public String goVip1() {

        return "pages/1/1";
    }

    @RequestMapping("goVip2")
    public String goVip2() {
        return "pages/2/2";
    }

    @GetMapping("toRegister")
    public String toRegister() {
        return "pages/user/register";
    }

    @Autowired
    private AclUserService aclUserService;

    @PostMapping("register")
    public String register( AclUser user) {
        aclUserService.save(user);
        return "index";
    }
}
