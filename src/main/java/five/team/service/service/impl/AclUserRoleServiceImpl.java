package five.team.service.service.impl;

import five.team.service.entity.AclUserRole;
import five.team.service.mapper.AclUserRoleMapper;
import five.team.service.service.AclUserRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-27
 */
@Service
@Transactional
public class AclUserRoleServiceImpl extends ServiceImpl<AclUserRoleMapper, AclUserRole> implements AclUserRoleService {

}
