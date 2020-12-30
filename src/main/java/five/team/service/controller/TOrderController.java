package five.team.service.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.AclUser;
import five.team.service.entity.R;
import five.team.service.entity.TOrder;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import five.team.service.service.TOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

/**
 * <p>
 * 订单表 前端控制器
 * </p>
 *
 * @author testjava
 * @since 2020-12-31
 */
@Controller
@RequestMapping("/t-order")
public class TOrderController {

    @Autowired
    private AclUserService userService;

    @Autowired
    private TOrderService orderService;

    @RequestMapping("list")
    public String list() {
        return "pages/order/list";
    }
    @PostMapping("bug")
    public @ResponseBody
    R bug(TOrder tOrder) {

        System.out.println("==============================");
        System.out.println(tOrder);
        String price = tOrder.getPrice1().substring(0, tOrder.getPrice1().length() - 1);
        BigDecimal bigDecimal = new BigDecimal(price);
        bigDecimal = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP);
        tOrder.setPrice(bigDecimal);
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AclUser aclUser = userService.getOne(new QueryWrapper<AclUser>().eq("username", username));
        tOrder.setMemberId(aclUser.getId());
        orderService.save(tOrder);
        return R.ok();
    }
}

