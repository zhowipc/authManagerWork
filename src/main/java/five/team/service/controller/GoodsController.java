package five.team.service.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import five.team.service.entity.AclRole;
import five.team.service.entity.AclUser;
import five.team.service.entity.Goods;
import five.team.service.entity.R;
import five.team.service.entity.vo.searchVo;
import five.team.service.service.AclRoleService;
import five.team.service.service.AclUserService;
import five.team.service.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.acl.Acl;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @RequestMapping("/add")
    public String toAdd() {
        return "pages/goods/add";
    }

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private AclUserService userService;

    @GetMapping("list")
    public String list() {
        return "pages/goods/list";
    }

    @GetMapping("get/{goodsId}")
    public R getByGoodsId(@PathVariable String goodsId) {
        Goods infoById = goodsService.getInfoById(goodsId);
        return R.ok().data("item", infoById);
    }

    @PostMapping("updateGoods")
    public @ResponseBody
    String updateGoods(Goods goods) {
        goodsService.updateById(goods);
        return "true";
    }

    @PostMapping("/addGoods")
    public @ResponseBody
    String addGoods(Goods goods) {
        System.out.println("=========================================GoodsController.addGoods");
        System.out.println(goods);
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AclUser aclUser = userService.getOne(new QueryWrapper<AclUser>().eq("username", username));
        goods.setMemberId(aclUser.getId());
        goods.setCover(goods.getFile());
        goodsService.save(goods);
        return "true";
    }


    @PostMapping("deleteGoodsInfo")
    public @ResponseBody
    String deleteGoodsInfo(String id) {
        goodsService.removeById(id);
        return "true";
    }

    @PostMapping("deleteBatchIds")
    public @ResponseBody
    String deleteBatchIds(@RequestParam("ids") String[] ids) {
        List<String> stringList = new ArrayList<>();
        if (ids != null && ids.length != 0)
            stringList = Arrays.asList(ids);
        for (String id : stringList) {
            goodsService.removeById(id);
        }
        return "true";

    }

    //获取商品
    @GetMapping("getAllGoods")
    public @ResponseBody
    String getAllGoods() {

        List<Goods> list = goodsService.list(new QueryWrapper<Goods>().orderByDesc("gmt_create"));
        for (Goods goods : list) {
            AclUser id = userService.getOne(new QueryWrapper<AclUser>().eq("id", goods.getMemberId()));
            if (id != null)
                goods.setMember(id.getUsername());
        }
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
        System.out.println(list);
        System.out.println(result.toJSONString());
        return result.toJSONString();
    }

    @PostMapping("/searchInfo")
    public @ResponseBody
    String searchUser(searchVo searchVo) {
        QueryWrapper<Goods> wrapper = new QueryWrapper<>();
        if (searchVo != null) {
            if (searchVo.getTitle() != null && !searchVo.getTitle().trim().equals(""))
                wrapper.like("title", searchVo.getTitle());
            if (searchVo.getUsername() != null && !searchVo.getUsername().trim().equals("")) {
                AclUser username = userService.getOne(new QueryWrapper<AclUser>().eq("username", searchVo.getUsername()));
                if (username != null)
                    wrapper.like("member_id", username.getId());
                else
                    wrapper.eq("member_id", "dd");
            }
            if (searchVo.getMinPrice() != null && !searchVo.getMinPrice().trim().equals(""))
                wrapper.ge("price", searchVo.getMinPrice());
            if (searchVo.getMaxPrice() != null && !searchVo.getMaxPrice().trim().equals("")) {
                wrapper.le("price", searchVo.getMaxPrice());
            }
        }
        wrapper.orderByDesc("gmt_create");
        List<Goods> list = goodsService.list(wrapper);
        for (Goods goods : list) {
            AclUser id = userService.getOne(new QueryWrapper<AclUser>().eq("id", goods.getMemberId()));
            goods.setMember(id.getUsername());
        }
        JSONObject result = new JSONObject();
        result.put("rows", list);
        result.put("total", list.size());
//        return R.ok().data("rows", list).data("total", list.size());
        return result.toJSONString();
    }

    //    ==========================================================================================================
    @RequestMapping("toshow")
    public String toShow() {
        return "pages/goods/show";
    }

    @PostMapping("getInitData/{page}/{limit}")
    public @ResponseBody
    R getInitData(@PathVariable long page, @PathVariable long limit, searchVo searchVo) {
        QueryWrapper<Goods> goodsQueryWrapper = new QueryWrapper<>();
        if (searchVo != null) {
            if (searchVo.getTitle() != null && !searchVo.getTitle().trim().equals("")) {
                goodsQueryWrapper.like("title", searchVo.getTitle());
            }
            if (searchVo.getMinPrice() != null && !searchVo.getMinPrice().trim().equals("")) {
                goodsQueryWrapper.ge("price", searchVo.getMinPrice());
            }
            if (searchVo.getMaxPrice() != null && !searchVo.getMaxPrice().trim().equals("")) {
                goodsQueryWrapper.le("price", searchVo.getMaxPrice());
            }
        }
        goodsQueryWrapper.orderByDesc("gmt_create");
        Page<Goods> goods = new Page<>(page, limit);
        goodsService.page(goods, goodsQueryWrapper);
        if (goods.getPages() < page && goods.getPages() != 0) {
            System.out.println("====================总页面" + goods.getPages() + "跳转页面:" + page);
            return R.error();
        }
        return R.ok().data("item", goods.getRecords())
                .data("title", goods.getTotal())
                .data("pages", goods.getPages())
                .data("current", goods.getCurrent());
    }

    @GetMapping("getInfoById/{goodsId}")
    public @ResponseBody
    R getInfoById(@PathVariable String goodsId) {
        Goods infoById = goodsService.getInfoById(goodsId);
        return R.ok().data("title", infoById.getTitle())
                .data("src", infoById.getCover())
                .data("price", infoById.getPrice())
                .data("belongId", infoById.getMemberId());
    }
}
