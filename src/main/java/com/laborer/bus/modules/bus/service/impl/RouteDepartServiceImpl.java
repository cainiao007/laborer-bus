package com.laborer.bus.modules.bus.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.utils.ShiroKit;
import com.laborer.bus.modules.bus.dto.RouteDepartDto;
import com.laborer.bus.modules.bus.entity.RouteDepart;
import com.laborer.bus.modules.bus.mapper.RouteAppointmentMapper;
import com.laborer.bus.modules.bus.mapper.RouteDepartMapper;
import com.laborer.bus.modules.bus.service.RouteDepartService;
import com.laborer.bus.modules.bus.vo.RouteDepartVo;

/**
 * <p>
 * 班车发车记录表 服务实现类
 * </p>
 * @since 2023-03-01 20:57:59
 */
@Service
public class RouteDepartServiceImpl extends ServiceImpl<RouteDepartMapper, RouteDepart> implements RouteDepartService {

    @Autowired
    private RouteAppointmentMapper routeAppointmentMapper;

    @Override
    public Page<RouteDepartVo> listData(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = new Page<>(routeDepart.getCurrent(), routeDepart.getSize());
        List<RouteDepartVo> list = baseMapper.record(routeDepart, page);
        return page.setRecords(list);
    }

    @Override
    public Page<RouteDepartVo> toDepart(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = new Page<>(routeDepart.getCurrent(), routeDepart.getSize());
        routeDepart.setDriverUid(ShiroKit.getUserId());
        List<RouteDepartVo> list = baseMapper.toDepart(routeDepart, page);
        return page.setRecords(list);
    }

    @Override
    @Transactional
    public void depart(RouteDepart routeDepart) {
        // 保存发车记录
        routeDepart.setDepartTime(new Date());
        routeDepart.setState(Constants.STATUS_1);
        baseMapper.insert(routeDepart);
    }

    @Override
    public Page<RouteDepartVo> record(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = new Page<>(routeDepart.getCurrent(), routeDepart.getSize());
        routeDepart.setDriverUid(ShiroKit.getUserId());
        List<RouteDepartVo> list = baseMapper.record(routeDepart, page);
        return page.setRecords(list);
    }
}
