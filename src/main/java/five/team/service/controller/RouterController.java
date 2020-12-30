package five.team.service.controller;

import five.team.service.entity.AclPermission;
import five.team.service.entity.AclRolePermission;
import five.team.service.entity.AclUser;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class RouterController {
    @RequestMapping({"/", "toLogin"})
    public String index() {
        return "login";
    }

    @RequestMapping("toMain")
    public String toMain() {
        return "pages/main";
    }

    @RequestMapping("main")
    public String main() {
        System.out.println("RouterController.main");
        return "redirect:toMain";
    }

    @RequestMapping("goVip1")
    public String goVip1() {

        return "pages/1/1";
    }

    @Autowired
    private AclRoleService roleService;

    @RequestMapping("hasPermission/{value}")
    public @ResponseBody
    String hasPermission(@PathVariable String value) {
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("=============================" + name);
        List<String> roleIds = roleService.findRoleIdByUserName(name);
        for (String roleId : roleIds) {
            List<AclRolePermission> permissionsIdByRoleId = roleService.findPermissionsIdByRoleId(roleId);
            for (AclRolePermission aclRolePermission : permissionsIdByRoleId) {
                AclPermission permissionByPermissionId = roleService.findPermissionByPermissionId(aclRolePermission.getPermissionId());
                if (permissionByPermissionId != null &&
                        permissionByPermissionId.getPermissionValue().equals(value)) {
                    return "success";

                }
            }
        }
        return "error";
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
    public String register(AclUser user) {
        System.out.println(user);
        aclUserService.save(user);
        return "redirect:toLogin";
    }
}
