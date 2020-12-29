package five.team.service.service.impl;

import five.team.service.entity.AclRolePermission;
import five.team.service.mapper.AclRolePermissionMapper;
import five.team.service.service.AclRolePermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 角色权限 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Service
@Transactional
public class AclRolePermissionServiceImpl extends ServiceImpl<AclRolePermissionMapper, AclRolePermission> implements AclRolePermissionService {

}
