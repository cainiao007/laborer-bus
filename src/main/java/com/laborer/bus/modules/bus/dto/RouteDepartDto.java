package com.laborer.bus.modules.bus.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.laborer.bus.common.entity.BaseEntity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 待发车列表
 * </p>
 * @since 2023-03-01 20:57:59
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class RouteDepartDto extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    private Long id;

    /**
     * 班车线路id
     */
    private Long routeId;

    /**
     * 车牌号
     */
    private String carNumber;

    /**
     * 座位数
     */
    private Integer capacity;

    /**
     * 司机uid
     */
    private Long driverUid;

    /**
     * 起始地址
     */
    private String startAddress;

    /**
     * 目的地址
     */
    private String endAddress;

    /**
     * 计划发车时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String planDepartTime;

    /**
     * 乘车时间
     */
    private Date departTime;

    /**
     * 发车记录id
     */
    private Long departId;

    /**
     * 状态 1预约成功 2取消
     */
    private Integer state;

    /**
     * 
     */
    private Long createBy;

    /**
     * 
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    /**
     * 
     */
    private Long updateBy;

    /**
     * 
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateDate;

}
