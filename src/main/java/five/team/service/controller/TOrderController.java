package five.team.service.controller;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import five.team.service.entity.AclUser;
import five.team.service.entity.R;
import five.team.service.entity.TOrder;
import five.team.service.entity.vo.searchVo;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import five.team.service.service.TOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

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

    @PostMapping("getListCont")
    public @ResponseBody
    String getListCont(searchVo searchVo) {
        System.out.println("=========================TOrderController.getListCont");
        System.out.println(searchVo);
        QueryWrapper<TOrder> tOrderQueryWrapper = new QueryWrapper<>();
        if (searchVo != null) {
            if (searchVo.getTitle() != null && !searchVo.getTitle().trim().equals("")) {
                tOrderQueryWrapper.like("title", searchVo.getTitle());
            }
            if (searchVo.getBelongName() != null && !searchVo.getBelongName().trim().equals("")) {
                AclUser aclUser = userService.getOne(new QueryWrapper<AclUser>().eq("username", searchVo.getBelongName()));
                tOrderQueryWrapper.eq("belong_id", aclUser.getId());
            }
            if (searchVo.getMinPrice() != null && !searchVo.getMinPrice().trim().equals("")) {
                tOrderQueryWrapper.ge("price", searchVo.getMinPrice());
            }
            if (searchVo.getMaxPrice() != null && !searchVo.getMaxPrice().trim().equals("")) {
                tOrderQueryWrapper.le("price", searchVo.getMaxPrice());
            }
        }
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AclUser aclUser = userService.getOne(new QueryWrapper<AclUser>().eq("username", username));

        tOrderQueryWrapper.eq("member_id", aclUser.getId());
        tOrderQueryWrapper.orderByDesc("gmt_create");

        List<TOrder> list = orderService.list(tOrderQueryWrapper);
        for (TOrder tOrder : list) {
            AclUser id = userService.getOne(new QueryWrapper<AclUser>().eq("id", tOrder.getBelongId()));
            if (id != null)
                tOrder.setBelongName(id.getUsername());
        }
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
        System.out.println(list);
        System.out.println(result.toJSONString());
        return result.toJSONString();
    }

    @GetMapping("getAllList")
    public @ResponseBody
    String getAllList() {

        List<TOrder> list = orderService.getAllList();
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
        System.out.println(list);
        System.out.println(result.toJSONString());
        return result.toJSONString();
    }
}

