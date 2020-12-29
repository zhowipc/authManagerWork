package five.team.service.controller;


import com.alibaba.fastjson.JSONObject;
import five.team.service.entity.AclRole;
import five.team.service.entity.R;
import five.team.service.service.AclRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Controller
@RequestMapping("/acl-role")
public class AclRoleController {

    @Autowired
    private AclRoleService roleService;

    @GetMapping("/goPermission/{roleId}")
    public String goPermission(@PathVariable String roleId) {
        System.out.println("=====================");
        System.out.println(roleId);
        return "pages/acl/role/update";
    }

    @ResponseBody
    @GetMapping("getHasRolesByUserId/{userId}")
    public R getHasRolesByUserId(@PathVariable String userId) {

        List<AclRole> roles = roleService.getHasRolesByUserId(userId);
        return R.ok().data("roles", roles);
    }

    @ResponseBody
    @GetMapping("getAllRoles")
    public R getAllRoles() {
        List<AclRole> list = roleService.list(null);
        return R.ok().data("roles", list);
    }

    @ResponseBody
    @PostMapping("getRolesInfo")
    public String getRolesInfo() {
        List<AclRole> list = roleService.list(null);
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
        System.out.println(list);
        System.out.println(result.toJSONString());
        return result.toJSONString();
    }

    //根据用户id添加角色
    @ResponseBody
    @PostMapping("connUserRoles")
    public R chainUserRoles(String userId, List<String> rIds) {

        roleService.chainUserRoles(userId, rIds);
        return R.ok();
    }

    @ResponseBody
    @PostMapping("addRoles")
    public R addRoles(AclRole role) {
        System.out.println(role);
        roleService.save(role);
        return R.ok();
    }

    @ResponseBody
    @GetMapping("deleteRole/{id}")
    public R deleteRole(@PathVariable String id) {
        roleService.deleteRoleById(id);
        return R.ok();
    }

    @ResponseBody
    @PostMapping("deleteBatchIds")
    public R deleteBatchIds(HttpServletRequest request) {
        String[] list = request.getParameterValues("ids");
        List<String> stringList = Arrays.asList(list);
        stringList.forEach(i -> roleService.deleteRoleById(i));
        return R.ok();
    }

    @RequestMapping("/role/list")
    public String toList() {

        return "pages/acl/role/list";
    }
}

