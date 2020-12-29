package five.team.service.service;

import five.team.service.entity.AclUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author testjava
 * @since 2020-12-24
 */
public interface AclUserService extends IService<AclUser> {

    void updateUserById(List<String> roleIds, String userId, String isDeleted);

    AclUser getByUsername(String username);
}
