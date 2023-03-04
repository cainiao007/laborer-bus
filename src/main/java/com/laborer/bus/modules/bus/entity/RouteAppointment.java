package com.laborer.bus.modules.bus.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName("bus_route_appointment")
public class RouteAppointment extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 班车线路id
     */
    private Long routeId;

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
     * 乘车时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date departTime;

    /**
     * 发车记录id
     */
    private Long departId;

    /**
     * 状态 1预约成功 
2取消

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
