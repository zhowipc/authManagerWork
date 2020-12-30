package five.team.service.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.Goods;
import five.team.service.mapper.GoodsMapper;
import five.team.service.service.GoodsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 商品表 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-30
 */
@Service
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {

    @Override
    public Goods getInfoById(String goodsId) {
        QueryWrapper<Goods> goodsQueryWrapper = new QueryWrapper<>();
        goodsQueryWrapper.eq("id", goodsId);
        Goods goods = baseMapper.selectOne(goodsQueryWrapper);
        return goods;
    }
}
