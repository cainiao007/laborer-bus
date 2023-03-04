package com.laborer.bus.modules.bus.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.laborer.bus.common.entity.BaseEntity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 班车线路表
 * </p>
 *
 * @since 2023-03-01 20:57:58
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class RouteDto extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     *
     */
    private Long id;

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
     * 司机uid
     */
    private Long driverUid;

    /**
     * 预约人uid
     */
    private Long appointmentUid;

    /**
     * 预约乘车日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date appointmentDate;

    /**
     * 日期类型 -1过去日期的  0当天的  1未来日期的
     */
    private Integer dateType;

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
     * 状态 0删除1启用
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
