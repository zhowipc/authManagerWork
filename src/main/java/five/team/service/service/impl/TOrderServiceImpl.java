package five.team.service.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.AclUser;
import five.team.service.entity.TOrder;
import five.team.service.mapper.TOrderMapper;
import five.team.service.service.AclUserService;
import five.team.service.service.TOrderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 订单表 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-31
 */
@Service
public class TOrderServiceImpl extends ServiceImpl<TOrderMapper, TOrder> implements TOrderService {
    @Autowired
    private AclUserService userService;

    @Override
    public List<TOrder> getAllList() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AclUser aclUser = userService.getOne(new QueryWrapper<AclUser>().eq("username", username));


        QueryWrapper<TOrder> tOrderQueryWrapper = new QueryWrapper<>();
        tOrderQueryWrapper.orderByDesc("gmt_create");
        tOrderQueryWrapper.eq("member_id", aclUser.getId());
        List<TOrder> tOrders = baseMapper.selectList(tOrderQueryWrapper);
        for (TOrder tOrder : tOrders) {
            AclUser id = userService.getOne(new QueryWrapper<AclUser>().eq("id", tOrder.getBelongId()));
            if (id != null)
                tOrder.setBelongName(id.getUsername());
        }
        return tOrders;

    }
}
