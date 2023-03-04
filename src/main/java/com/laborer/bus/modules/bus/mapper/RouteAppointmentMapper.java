package com.laborer.bus.modules.bus.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.laborer.bus.modules.bus.dto.RouteAppointmentDto;
import com.laborer.bus.modules.bus.entity.RouteAppointment;
import com.laborer.bus.modules.bus.vo.RouteAppointmentVo;

/**
 * <p>
 * 班车预约表 Mapper 接口
 * </p>
 * @since 2023-03-01 20:57:59
 */
public interface RouteAppointmentMapper extends BaseMapper<RouteAppointment> {

    /**
     * 查询列表(分页)
     * @param routeAppointment 查询参数
     * @param page 分页参数
     * @return list
     */
    List<RouteAppointment> selectRouteAppointmentList(RouteAppointment routeAppointment, IPage page);

    /**
     * 预约记录
     * @param routeAppointment 查询参数
     * @param page 分页参数
     * @return list
     */
    List<RouteAppointmentVo> record(RouteAppointmentDto routeAppointment, IPage page);

    /**
     * 查询预约详情
     * @param id 查询参数
     * @return
     */
    RouteAppointmentVo info(Long id);

}
