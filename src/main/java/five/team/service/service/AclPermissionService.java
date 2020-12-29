package five.team.service.service;

import five.team.service.dtree.DTree;
import five.team.service.dtree.Node;
import five.team.service.entity.AclPermission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 权限 服务类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
public interface AclPermissionService extends IService<AclPermission> {

    List<DTree> getPermissionMenuByRoleId(String roleId);


    void setAuthForRole(String id, List<String> permissionIds);

    List<String> getCheckedIds(String roleId);

    void addPermission(Node node);

    void editPermission(Node node);

    void deletePermission(Node node);

    List<DTree> getMenu();

    List<DTree> getMenuCont(String name);

}
