package com.laborer.bus.modules.bus.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.laborer.bus.modules.bus.dto.RouteDto;
import com.laborer.bus.modules.bus.entity.Route;

/**
 * <p>
 * 班车线路表 Mapper 接口
 * </p>
 * @since 2023-03-01 20:57:58
 */
public interface RouteMapper extends BaseMapper<Route> {

    /**
     * 查询列表(分页)
     * @param route 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Route> selectRouteList(Route route, IPage page);

    /**
     * 可预约列表
     * @param route 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Route> reservable(RouteDto route, IPage page);
}
