package five.team.service.service.impl;

import five.team.service.entity.Review;
import five.team.service.mapper.ReviewMapper;
import five.team.service.service.ReviewService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 评论表 服务实现类
 * </p>
 *
 * @author testjava
 * @since 2020-12-30
 */
@Service
public class ReviewServiceImpl extends ServiceImpl<ReviewMapper, Review> implements ReviewService {

}
