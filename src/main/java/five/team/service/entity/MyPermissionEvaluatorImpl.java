package five.team.service.entity;

import five.team.service.service.AclRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

//@Component
public class MyPermissionEvaluatorImpl /*implements PermissionEvaluator */{

//    @Autowired
    private AclRoleService roleService;
    /**
     * @param authentication 认证过的信息
     * @param targetDomainObject   要访问的目标路径
     * @param permission   要访问的目标路径需要的权限
     * @return
     */
//    @Override
    public boolean hasPermission(Authentication authentication, Object targetDomainObject, Object permission) {
        System.out.println("========================目标url：" + targetDomainObject);
        System.out.println("========================目标权限:" + permission);
        // 获得loadUserByUsername()方法的结果
        // User是org.springframework.security.core.userdetails.User
        // 是Userdetails的实现类
        User user = (User) authentication.getPrincipal();
        // 获得loadUserByUsername()中注入的角色
        Collection<GrantedAuthority> authorities = user.getAuthorities();
        // 遍历登录用户中所有角色
        for (GrantedAuthority authority : authorities) {
            //1. 获得角色名称  RoleName
            String roleName = authority.getAuthority();
            System.out.println("=================roleName:" + roleName);
            //2. 根据角色名查出角色信息并获得角色信息  获得RoleId
            AclRole role = roleService.findRoleIdByRoleName(roleName);
            //3. 再根据角色ID查询角色权限中间表 对应的权限ID   一对多关系：一个RoleID对应多个PermissionId  返回集合
            List<AclRolePermission> permissionsIdByRoleId = roleService.findPermissionsIdByRoleId(role.getId());
            for (AclRolePermission aclRolePermission : permissionsIdByRoleId) {
                //4. 再根据权限ID查询权限信息  是一对一关系   一个权限id只对应一个权限信息
                AclPermission aclPermission = roleService.findPermissionByPermissionId(aclRolePermission.getPermissionId());
                System.out.println("角色是："+roleName+"--对应的权限是："+aclPermission);
                if (targetDomainObject.equals(aclPermission.getPath()) && permission.equals(aclPermission.getPermissionValue())){
                    System.out.println("权限校验成功");
                    return true;
                }else {
                    System.out.println("权限校验失败");
                }
            }
        }
        return false;
    }

//    @Override
    public boolean hasPermission(Authentication authentication, Serializable targetId, String targetType, Object permission) {
        return false;
    }
}
