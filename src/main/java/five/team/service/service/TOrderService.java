package five.team.service.service;

import five.team.service.entity.TOrder;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 订单表 服务类
 * </p>
 *
 * @author testjava
 * @since 2020-12-31
 */
public interface TOrderService extends IService<TOrder> {

    List<TOrder> getAllList();

}
