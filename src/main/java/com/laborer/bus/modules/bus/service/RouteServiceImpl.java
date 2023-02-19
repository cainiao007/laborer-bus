package com.laborer.bus.modules.bus.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import com.laborer.bus.modules.bus.entity.Route;
import com.laborer.bus.modules.bus.mapper.RouteMapper;

import java.util.List;

/**
 * <p>
 * 班车路线表 服务实现类
 * </p>
 * @since 2023-02-19 17:43:30
 */
@Service
public class RouteServiceImpl extends ServiceImpl<RouteMapper, Route> implements RouteService {

    @Override
    public Page<Route> listRoutePage(Route route) {
        Page<Route> page = new Page<>(route.getCurrent(), route.getSize());
        List<Route> routes = baseMapper.selectRouteList(route, page);
        return page.setRecords(routes);
    }

}
