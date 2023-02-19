package com.laborer.bus.modules.bus.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.laborer.bus.common.entity.BaseEntity;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

/**
 * <p>
 * 班车路线表
 * </p>
 * @since 2023-02-19 17:43:30
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("bus_route")
public class Route extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 车牌号
     */
    private String carNum;

    /**
     * 车辆类型
     */
    private Integer carType;

    /**
     * 车牌类型
     */
    private Integer carNumType;

    /**
     * 司机ID
     */
    private Long driverUid;

    /**
     * 最大乘车数
     */
    private Integer capacity;

    /**
     * 出发地
     */
    private String startAdress;

    /**
     * 目的地
     */
    private String endAdress;

    /**
     * 发车时间
     */
    private String departTime;

    /**
     * 删除标识。0：未删除；1：已删除
     */
    private Integer delFlag;

    /**
     * 创建人
     */
    private Long createBy;

    /**
     * 创建时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    /**
     * 修改人
     */
    private Long updateBy;

    /**
     * 更新时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

}
