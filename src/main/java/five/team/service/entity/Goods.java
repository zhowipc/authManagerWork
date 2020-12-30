package five.team.service.entity;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 商品表
 * </p>
 *
 * @author testjava
 * @since 2020-12-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(value = "Goods对象", description = "商品表")
public class Goods implements Serializable {

    private static final long serialVersionUID = 1L;


    @TableField(exist = false)
    private String member;
    @ApiModelProperty(value = "商品id")
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;

    @ApiModelProperty(value = "商品标题")
    private String title;

    @ApiModelProperty(value = "商品价格")
    private BigDecimal price;

    @TableField(exist = false)
    private String file;

    @ApiModelProperty(value = "商品封面")
    private String cover;

    @ApiModelProperty(value = "一级分类")
    private String subjectFirstId;

    @ApiModelProperty(value = "二级分类")
    private String subjectSecondId;

    @ApiModelProperty(value = "商品简介")
    private String intro;

    @ApiModelProperty(value = "提供该商品的商家id")
    private String memberId;

    @ApiModelProperty(value = "商品浏览人数")
    private Long viewCount;

    @ApiModelProperty(value = "商品购买人数")
    private Long buyCount;

    @ApiModelProperty(value = "商品评论人数")
    private Long reviewCount;

    @ApiModelProperty(value = "创建时间")
    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;

    @ApiModelProperty(value = "更新时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;


}
