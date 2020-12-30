package five.team.service.controller;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.AclRole;
import five.team.service.entity.AclUser;
import five.team.service.entity.R;
import five.team.service.entity.vo.searchVo;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import five.team.service.utils.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-12-24
 */
@Controller
@RequestMapping("/acl-user")
public class AclUserController {
    @Autowired
    private AclUserService userService;

    @Autowired
    private AclRoleService roleService;

    @ResponseBody
    @PostMapping("/addUser")
    public String addUser(AclUser user) {
        System.out.println("==================================\n" + user);
        user.setPassword(MD5.encrypt(user.getPassword()));
        userService.save(user);
        JSONObject r = new JSONObject();
        r.put("code", "20000");
        return r.toJSONString();
    }

    @ResponseBody
    @PostMapping("/deleteBatchIds")
    public String deleteBatchIds(HttpServletRequest request) {
        String[] list = request.getParameterValues("ids");

        List<String> asList = Arrays.asList(list);
        System.out.println(asList);
        boolean b = userService.removeByIds(asList);
        System.out.println("++++++++++++++++" + b);
        if (b) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "20000");
            return jsonObject.toJSONString();
        }
        return "null";
    }

    @ResponseBody
    @PostMapping("/deleteUserInfo")
    public R deleteUserById(HttpServletRequest request) {
        String id = request.getParameter("id");
        List<String> list = Arrays.asList(id);
//        userService.removeById(id);
        userService.removeByIds(list);
        return R.ok();
    }

    /*
    DELETE FROM acl_user WHERE id IN ( ? )
==> Parameters: 1342308458313027586(String)
            <==    Updates: 1

    DELETE FROM acl_user WHERE id IN ( ? )
==> Parameters: 1342023823964364800(String)
            <==    Updates: 0
    */
    @ResponseBody
    @PostMapping("/updateUser")
    public R updateUserById(HttpServletRequest request) {
        String[] roleIdsArr = request.getParameterValues("roleIds");

        String userId = request.getParameter("userId");
        String isDeleted = request.getParameter("isDeleted");
        List<String> roleIds = new ArrayList<>();
        if (roleIdsArr != null && roleIdsArr.length != 0) {
            roleIds = Arrays.asList(roleIdsArr);
        }

        System.out.println(roleIds);

        System.out.println(userId);
        userService.updateUserById(roleIds, userId, isDeleted);
        return R.ok();
    }

    @ResponseBody
    @PostMapping("/searchUser")
    public String searchUser(searchVo userSearch) {
        System.out.println("=============================\n" + userSearch);
//        String username = request.getParameter("username");
//        String nickname = request.getParameter("nickName");
//        String startTime = request.getParameter("startTime");
//        String endTime = request.getParameter("endTime");
        QueryWrapper<AclUser> wrapper = new QueryWrapper<>();
        if (userSearch.getUsername() != null && !userSearch.getUsername().trim().equals(""))
            wrapper.like("username", userSearch.getUsername());
        if (userSearch.getNickname() != null && !userSearch.getNickname().trim().equals("")) {
            wrapper.like("nick_name", userSearch.getNickname());
        }
        if (userSearch.getStartTime() != null && !userSearch.getStartTime().trim().equals(""))
            wrapper.ge("gmt_create", userSearch.getStartTime());
        if (userSearch.getEndTime() != null && !userSearch.getEndTime().trim().equals("")) {
            wrapper.le("gmt_create", userSearch.getEndTime());
        }
        List<AclUser> list = userService.list(wrapper);
        list.forEach(it -> {
            List<AclRole> hasRolesByUserId = roleService.getHasRolesByUserId(it.getId());
            List<String> collect = hasRolesByUserId.stream().map(i -> i.getRoleName()).collect(Collectors.toList());
            it.setRoles(collect);
        });
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
//        return R.ok().data("rows", list).data("total", list.size());
        return result.toJSONString();
    }

    @ResponseBody
    @PostMapping("/getInfo")
    public String getUserInfo() {
        System.out.println("====================");
        QueryWrapper<AclUser> wrapper = new QueryWrapper<>();
        wrapper.orderByAsc("gmt_create");
        List<AclUser> list = userService.list(null);
        list.forEach(it -> {
            List<AclRole> hasRolesByUserId = roleService.getHasRolesByUserId(it.getId());
            List<String> collect = hasRolesByUserId.stream().map(i -> i.getRoleName()).collect(Collectors.toList());
            it.setRoles(collect);
        });
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
        System.out.println(list);
        System.out.println(result.toJSONString());
        return result.toJSONString();
    }

    @RequestMapping("/user/list")
    public String toList() {
        return "pages/acl/user/list";
    }
}

