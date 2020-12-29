package five.team.service.service;

import five.team.service.entity.AclPermission;
import five.team.service.entity.AclRole;
import com.baomidou.mybatisplus.extension.service.IService;
import five.team.service.entity.AclRolePermission;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
public interface AclRoleService extends IService<AclRole> {

    void chainUserRoles(String userId, List<String> rIds);

    List<AclRole> getHasRolesByUserId(String userId);

    void deleteRoleById(String id);

    AclRole findRoleIdByRoleName(String roleName);

    List<AclRolePermission> findPermissionsIdByRoleId(String id);

    AclPermission findPermissionByPermissionId(String permissionId);

    List<String> findRoleIdByUserName(String name);
}
