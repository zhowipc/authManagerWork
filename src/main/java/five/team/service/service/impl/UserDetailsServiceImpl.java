package five.team.service.service.impl;

import five.team.service.entity.*;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import five.team.service.utils.MD5;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private AclRoleService roleService;
    @Autowired
    private AclUserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        user.setUsername(username).setPassword(MD5.encrypt("123"));
        AclUser user = userService.getByUsername(username);
        User curUser = new User();
        BeanUtils.copyProperties(user, curUser);

        SecurityUser securityUser = new SecurityUser(curUser);
        List<String> authorities = new ArrayList<>();
        List<String> roleIdByUserName = roleService.findRoleIdByUserName(username);
        for (String roleId : roleIdByUserName) {
            List<AclRolePermission> permissionsIdByRoleId = roleService.findPermissionsIdByRoleId(roleId);
            for (AclRolePermission aclRolePermission : permissionsIdByRoleId) {
                AclPermission permissionByPermissionId = roleService.findPermissionByPermissionId(aclRolePermission.getPermissionId());
                if (permissionByPermissionId != null) {
                    int flag = 1;
                    for (String authority : authorities) {
                        if (authority != null
                                && authority.equals(permissionByPermissionId.getPermissionValue())) {
                            flag = 0;
                            break;
                        }
                    }
                    if (flag == 1) {
                        if (permissionByPermissionId.getPermissionValue() != null && !permissionByPermissionId.getPermissionValue().trim().equals(""))
                            authorities.add(permissionByPermissionId.getPermissionValue());
                    }
                }
            }
        }
        System.out.println("====================UserDetailsServiceImpl.loadUserByUsername");
        System.out.println(authorities);

        securityUser.setPermissionValueList(authorities);
        return securityUser;
    }
}
