package five.team.service.service.impl;

import five.team.service.entity.TOrder;
import five.team.service.mapper.TOrderMapper;
import five.team.service.service.TOrderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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

}
