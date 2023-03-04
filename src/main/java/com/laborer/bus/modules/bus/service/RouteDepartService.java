package com.laborer.bus.modules.bus.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.laborer.bus.modules.bus.dto.RouteDepartDto;
import com.laborer.bus.modules.bus.entity.RouteDepart;
import com.laborer.bus.modules.bus.vo.RouteDepartVo;

/**
 * <p>
 * 班车发车记录表 服务类
 * </p>
 * @since 2023-03-01 20:57:59
 */
public interface RouteDepartService extends IService<RouteDepart> {

    /**
     * 获取列表。分页
     * @param routeDepart 查询参数
     * @return page
     */
    Page<RouteDepartVo> listData(RouteDepartDto routeDepart);

    /**
     * 获取待发车列表。分页
     * @param routeDepart 查询参数
     * @return page
     */
    Page<RouteDepartVo> toDepart(RouteDepartDto routeDepart);

    /**
     * 立即发车
     * @param routeDepart
     */
    void depart(RouteDepart routeDepart);

    /**
     * 获取发车记录。分页
     * @param routeDepart 查询参数
     * @return page
     */
    Page<RouteDepartVo> record(RouteDepartDto routeDepart);
}
