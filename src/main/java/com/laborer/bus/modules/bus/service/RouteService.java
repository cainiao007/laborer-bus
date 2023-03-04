package com.laborer.bus.modules.bus.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.laborer.bus.modules.bus.dto.RouteDto;
import com.laborer.bus.modules.bus.entity.Route;

/**
 * <p>
 * 班车线路表 服务类
 * </p>
 * @since 2023-03-01 20:57:58
 */
public interface RouteService extends IService<Route> {

    /**
     * 获取列表。分页
     * @param route 查询参数
     * @return page
     */
    Page<Route> listRoutePage(Route route);

    /**
     * 可预约列表
     * @param route 查询参数
     * @return page
     */
    Page<Route> reservable(RouteDto route);
}
