package five.team.service.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.AclUser;
import five.team.service.entity.AclUserRole;
import five.team.service.mapper.AclUserMapper;
import five.team.service.service.AclUserRoleService;
import five.team.service.service.AclUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-24
 */
@Service
@Transactional
public class AclUserServiceImpl extends ServiceImpl<AclUserMapper, AclUser> implements AclUserService {

    @Autowired
    private AclUserRoleService userRoleService;


    @Override
    public void updateUserById(List<String> roleIds, String userId, String isDeleted) {

        System.out.println(userId.trim().equals("1342310795677102000"));

        AclUser aclUser = baseMapper.selectById(userId.trim());

        System.out.println(aclUser);
        aclUser.setIsDeleted(isDeleted.equals("1"));
        baseMapper.updateById(aclUser);


        QueryWrapper<AclUserRole> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId);
        wrapper.select("id");
        List<AclUserRole> list = userRoleService.list(wrapper);
        List<String> collect = list.stream().map(i -> i.getId()).collect(Collectors.toList());

        System.out.println("=========================");
        System.out.println(collect);
        if (collect.size() != 0)
            userRoleService.removeByIds(collect);

        List<AclUserRole> aclUserRoles = new ArrayList<>();
        roleIds.forEach(it -> {
            AclUserRole aclUserRole = new AclUserRole();
            aclUserRole.setUserId(userId);
            aclUserRole.setRoleId(it);
            aclUserRole.setIsDeleted(isDeleted.equals("1"));
            aclUserRoles.add(aclUserRole);
        });
        System.out.println(aclUserRoles);
        if (aclUserRoles.size() != 0)
            userRoleService.saveBatch(aclUserRoles);

    }

    @Override
    public AclUser getByUsername(String username) {
        AclUser username1 = baseMapper.selectOne(new QueryWrapper<AclUser>().eq("username", username).eq("is_deleted",0));
        return username1;
    }
}
