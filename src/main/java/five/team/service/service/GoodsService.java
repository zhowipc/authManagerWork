package five.team.service.service;

import five.team.service.entity.Goods;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 商品表 服务类
 * </p>
 *
 * @author testjava
 * @since 2020-12-30
 */
public interface GoodsService extends IService<Goods> {

    Goods getInfoById(String goodsId);
}
