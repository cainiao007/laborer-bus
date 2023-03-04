package com.laborer.bus.modules.bus.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.laborer.bus.common.entity.BaseEntity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 班车预约表
 * </p>
 * @since 2023-03-01 20:57:59
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class RouteDepartVo extends BaseEntity {

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
     * 车型
     */
    private Integer carType;

    /**
     * 座位数
     */
    private Integer capacity;

    /**
     * 预约人数
     */
    private Integer appointmentCnt;

    /**
     * 乘车人数
     */
    private Integer passenger;

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
    private String planDepartTime;

    /**
     * 乘车时间
     */
    private String departTime;

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
