package com.laborer.bus.modules.bus.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.utils.ShiroKit;
import com.laborer.bus.modules.bus.dto.RouteDto;
import com.laborer.bus.modules.bus.entity.Route;
import com.laborer.bus.modules.bus.mapper.RouteMapper;
import com.laborer.bus.modules.bus.service.RouteService;

import cn.hutool.core.date.DateUtil;


/**
 * <p>
 * 班车线路表 服务实现类
 * </p>
 * @since 2023-03-01 20:57:58
 */
@Service
public class RouteServiceImpl extends ServiceImpl<RouteMapper, Route> implements RouteService {

    @Override
    public Page<Route> listRoutePage(Route route) {
        Page<Route> page = new Page<>(route.getCurrent(), route.getSize());
        List<Route> routes = baseMapper.selectRouteList(route, page);
        return page.setRecords(routes);
    }

    @Override
    public Page<Route> reservable(RouteDto route) {
        Page<Route> page = new Page<>(route.getCurrent(), route.getSize());
        // 校验时间
        if (!checkDepartDate(route)){
            return page;
        }
        Long userId = ShiroKit.getUserId();
        route.setAppointmentUid(userId);
        List<Route> routes = baseMapper.reservable(route, page);
        return page.setRecords(routes);
    }

    private boolean checkDepartDate(RouteDto route) {
        Date appointmentDate = route.getAppointmentDate();
        Date now = new Date();
        if (Objects.isNull(appointmentDate) || DateUtil.isSameDay(appointmentDate, now)) {
            route.setDateType(Constants.TODAY);
            route.setAppointmentDate(now);
            route.setPlanDepartTime(DateUtil.format(now, "HH:mm"));
        }
        else if (appointmentDate.before(now)){
            return false;
        }
        return true;
    }
}
