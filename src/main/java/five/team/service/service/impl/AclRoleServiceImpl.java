package five.team.service.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.*;
import five.team.service.mapper.AclRoleMapper;
import five.team.service.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Service
@Transactional
public class AclRoleServiceImpl extends ServiceImpl<AclRoleMapper, AclRole> implements AclRoleService {

    @Autowired
    private AclUserRoleService userRoleService;
    @Autowired
    private AclRolePermissionService rolePermissionService;

    @Autowired
    private AclPermissionService permissionService;

    @Autowired
    private AclUserService userService;

    @Override
    public void chainUserRoles(String userId, List<String> rIds) {
        List<AclUserRole> aclUserRoles = new ArrayList<>();
        for (String rId : rIds) {
            AclUserRole aclUserRole = new AclUserRole();
            aclUserRole.setUserId(userId);
            aclUserRole.setRoleId(rId);
            aclUserRoles.add(aclUserRole);
        }
        userRoleService.saveBatch(aclUserRoles);
    }

    @Override
    public List<AclRole> getHasRolesByUserId(String userId) {
        QueryWrapper<AclUserRole> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId);
        List<AclUserRole> list = userRoleService.list(wrapper);
        List<AclRole> roles = new ArrayList<>();
        list.forEach(it -> {
            QueryWrapper<AclRole> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("id", it.getRoleId());
            AclRole aclRole = baseMapper.selectOne(queryWrapper);
            roles.add(aclRole);
        });
        return roles;
    }

    @Override
    public void deleteRoleById(String roleId) {
        QueryWrapper<AclUserRole> wrapper = new QueryWrapper<>();
        wrapper.eq("role_id", roleId);
        userRoleService.remove(wrapper);

        baseMapper.deleteById(roleId);

        QueryWrapper<AclRolePermission> wrapper1 = new QueryWrapper<>();
        wrapper.eq("role_id", roleId);
        rolePermissionService.remove(wrapper1);
    }

    @Override
    public AclRole findRoleIdByRoleName(String roleName) {
        QueryWrapper<AclRole> aclRoleServiceQueryWrapper = new QueryWrapper<>();
        aclRoleServiceQueryWrapper.eq("role_name", roleName);
        AclRole aclRole = baseMapper.selectOne(aclRoleServiceQueryWrapper);
        System.out.println("====================AclRoleServiceImpl.findRoleIdByRoleName");
        System.out.println(aclRole);
        return aclRole;
    }

    @Override
    public List<AclRolePermission> findPermissionsIdByRoleId(String id) {
        QueryWrapper<AclRolePermission> aclRolePermissionQueryWrapper = new QueryWrapper<>();
        aclRolePermissionQueryWrapper.eq("role_id", id);
        List<AclRolePermission> list = rolePermissionService.list(aclRolePermissionQueryWrapper);
        System.out.println("================AclRoleServiceImpl.findPermissionsIdByRoleId");
        System.out.println(list);
        return list;
    }

    @Override
    public AclPermission findPermissionByPermissionId(String permissionId) {
        QueryWrapper<AclPermission> aclPermissionQueryWrapper = new QueryWrapper<>();
        aclPermissionQueryWrapper.eq("id", permissionId);
        AclPermission one = permissionService.getOne(aclPermissionQueryWrapper);
        System.out.println("================AclRoleServiceImpl.findPermissionByPermissionId");
        System.out.println(one);
        return one;
    }

    @Override
    public List<String> findRoleIdByUserName(String name) {
        QueryWrapper<AclUser> wrapper = new QueryWrapper<>();
        wrapper.eq("username", name);
        AclUser one = userService.getOne(wrapper);
        List<AclUserRole> user_id = userRoleService.list(new QueryWrapper<AclUserRole>().eq("user_id", one.getId()));
        List<String> collect = user_id.stream().map(i -> i.getRoleId()).collect(Collectors.toList());
        return collect;
    }
}
