package com.laborer.bus.modules.bus.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.laborer.bus.modules.bus.dto.RouteAppointmentDto;
import com.laborer.bus.modules.bus.entity.RouteAppointment;
import com.laborer.bus.modules.bus.vo.RouteAppointmentVo;

/**
 * <p>
 * 班车预约表 服务类
 * </p>
 * @since 2023-03-01 20:57:59
 */
public interface RouteAppointmentService extends IService<RouteAppointment> {

    /**
     * 获取列表。分页
     * @param routeAppointment 查询参数
     * @return page
     */
    Page<RouteAppointment> listRouteAppointmentPage(RouteAppointment routeAppointment);

    /**
     * 班车雨夜
     * @param routeAppointment
     */
    void add(RouteAppointment routeAppointment);

    /**
     * 预约记录
     * @param routeAppointment 查询参数
     * @return page
     */
    Page<RouteAppointmentVo> record(RouteAppointmentDto routeAppointment);

    /**
     * 查询预约详情
     * @param id 查询参数
     * @return
     */
    RouteAppointmentVo info(Long id);

    /**
     * 乘车
     * @param routeAppointment
     */
    void depart(RouteAppointmentDto routeAppointment);

}
