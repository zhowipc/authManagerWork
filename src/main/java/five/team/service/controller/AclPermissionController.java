package five.team.service.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.dtree.DTree;
import five.team.service.dtree.DTreeResponse;
import five.team.service.dtree.Node;
import five.team.service.entity.AclPermission;
import five.team.service.entity.R;
import five.team.service.service.AclPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 权限 前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Controller
@RequestMapping("/acl-permission")
public class AclPermissionController {
    @GetMapping("/menu/list")
    public String list() {
        return "pages/acl/menu/list";
    }

    @Autowired
    private AclPermissionService permissionService;

    @PostMapping("getMenu")
    public @ResponseBody
    DTreeResponse getMenu() {
        System.out.println("AclPermissionController.getMenu======================");
        DTreeResponse dTreeResponse = new DTreeResponse();
        List<DTree> dTrees = permissionService.getMenu();
        System.out.println(dTrees);
        dTreeResponse.setData(dTrees);
        return dTreeResponse;
    }
    @PostMapping("getMenuCont")
    public @ResponseBody
    DTreeResponse getMenuCont() {
        System.out.println("AclPermissionController.getMenuCont==================");
        DTreeResponse dTreeResponse = new DTreeResponse();
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("=============================" + name);
        List<DTree> dTrees = permissionService.getMenuCont(name);
        System.out.println(dTrees);
        dTreeResponse.setData(dTrees);
        return dTreeResponse;
    }

    @PostMapping("addPermission")
    public @ResponseBody
    R addPermission(Node node) {
        System.out.println("===========================AclPermissionController.addPermission");
        System.out.println(node);
        permissionService.addPermission(node);
        return R.ok();
    }

    @PostMapping("editPermission")
    public @ResponseBody
    R editPermission(Node node) {
        System.out.println("===================AclPermissionController.editPermission");
        System.out.println(node);
        permissionService.editPermission(node);
        return R.ok();
    }

    @PostMapping("deletePermission")
    public @ResponseBody
    R deletePermission(Node node) {
        System.out.println("AclPermissionController.deletePermission===================");
        System.out.println(node);
        permissionService.deletePermission(node);
        return R.ok();
    }

    @GetMapping("getOnePermissionById/{permissionId}")
    public @ResponseBody
    R getOnePermissionById(@PathVariable String permissionId) {
        QueryWrapper<AclPermission> aclPermissionQueryWrapper = new QueryWrapper<>();
        aclPermissionQueryWrapper.eq("id", permissionId);
        AclPermission one = permissionService.getOne(aclPermissionQueryWrapper);
        System.out.println("========================AclPermissionController.getOnePermissionById");
        System.out.println(one);
        return R.ok()
                .data("path", one.getPath())
                .data("permissionValue", one.getPermissionValue())
                .data("editNodeName", one.getTitle())
                .data("type", one.getType() + "");
    }

    @PostMapping("getCheckedIds/{roleId}")
    public @ResponseBody
    List<String> getCheckedIds(@PathVariable String roleId) {

        System.out.println("=============AclPermissionController.getCheckedIds");
        System.out.println(roleId);
        List<String> stringList = permissionService.getCheckedIds(roleId);
        System.out.println(stringList);
        return stringList;
    }

    //获取权限菜单
    @PostMapping("getPermissionMenu/{roleId}")
    @ResponseBody
    public DTreeResponse getPermissionMenu(@PathVariable String roleId) {
        System.out.println("===============AclPermissionController.getPermissionMenu");
        System.out.println(roleId);
        List<DTree> aclPermissions = permissionService.getPermissionMenuByRoleId(roleId);
        System.out.println(aclPermissions);
        DTreeResponse dTreeResponse = new DTreeResponse();
        dTreeResponse.setData(aclPermissions);

        return dTreeResponse;
    }

    @PostMapping("setAuthForRole/{id}")
    public @ResponseBody
    String setAuthForRole(@PathVariable String id,
                          @RequestParam(value = "permissionIds", required = false) String[] permissionIds) {
        System.out.println("====================AclPermissionController.setAuthForRole");
        System.out.println(id);
        List<String> stringList = new ArrayList<>();

        if (permissionIds != null && permissionIds.length != 0)
            stringList = Arrays.asList(permissionIds);
        System.out.println(stringList);


        permissionService.setAuthForRole(id, stringList);
        return "";
    }
}

