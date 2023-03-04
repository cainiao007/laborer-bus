package com.laborer.bus.modules.bus.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.exception.BusinessException;
import com.laborer.bus.common.utils.ShiroKit;
import com.laborer.bus.modules.bus.dto.RouteAppointmentDto;
import com.laborer.bus.modules.bus.entity.RouteAppointment;
import com.laborer.bus.modules.bus.entity.RouteDepart;
import com.laborer.bus.modules.bus.mapper.RouteAppointmentMapper;
import com.laborer.bus.modules.bus.service.RouteAppointmentService;
import com.laborer.bus.modules.bus.service.RouteDepartService;
import com.laborer.bus.modules.bus.vo.RouteAppointmentVo;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;

/**
 * <p>
 * 班车预约表 服务实现类
 * </p>
 *
 * @since 2023-03-01 20:57:59
 */
@Service
public class RouteAppointmentServiceImpl extends ServiceImpl<RouteAppointmentMapper, RouteAppointment> implements RouteAppointmentService {

    @Autowired
    private RouteDepartService routeDepartService;

    @Override
    public Page<RouteAppointment> listRouteAppointmentPage(RouteAppointment routeAppointment) {
        Page<RouteAppointment> page = new Page<>(routeAppointment.getCurrent(), routeAppointment.getSize());
        List<RouteAppointment> routeAppointments = baseMapper.selectRouteAppointmentList(routeAppointment, page);
        return page.setRecords(routeAppointments);
    }

    @Override
    public void add(RouteAppointment routeAppointment) {
        Long userId = ShiroKit.getUserId();

        // 查询该用户是否已预约该路线
        LambdaQueryWrapper<RouteAppointment> queryWrapper = new LambdaQueryWrapper<RouteAppointment>()
                .eq(RouteAppointment::getAppointmentUid, userId)
                .eq(RouteAppointment::getRouteId, routeAppointment.getRouteId())
                .eq(RouteAppointment::getAppointmentDate,routeAppointment.getAppointmentDate())
                .ne(RouteAppointment::getState, Constants.APPOINTMENT_STATUS_CANCEL);
        Integer count = baseMapper.selectCount(queryWrapper);
        if (count > 0) {
            throw new BusinessException("用户已预约该班车路线");
        }

        // 保存预约信息
        routeAppointment.setAppointmentUid(userId);
        baseMapper.insert(routeAppointment);
    }

    @Override
    public Page<RouteAppointmentVo> record(RouteAppointmentDto routeAppointment) {
        Page<RouteAppointmentVo> page = new Page<>(routeAppointment.getCurrent(), routeAppointment.getSize());
        routeAppointment.setAppointmentUid(ShiroKit.getUserId());
        List<RouteAppointmentVo> list = baseMapper.record(routeAppointment, page);
        return page.setRecords(list);
    }

    @Override
    public RouteAppointmentVo info(Long id) {
        RouteAppointmentVo routeAppointmentVo = baseMapper.info(id);
        return routeAppointmentVo;
    }

    @Override
    @Transactional
    public void depart(RouteAppointmentDto dto) {
        // 查询发车记录
        LambdaQueryWrapper<RouteDepart> wrapper = new LambdaQueryWrapper<RouteDepart>()
                .eq(RouteDepart::getRouteId, dto.getRouteId())
                .eq(RouteDepart::getPlanDepartTime, DateUtil.format(dto.getAppointmentDate(), DatePattern.NORM_DATE_PATTERN) + " " + dto.getPlanDepartTime());
        RouteDepart routeDepart = routeDepartService.getOne(wrapper);
        if (Objects.isNull(routeDepart)) {
            throw new BusinessException("司机未发车");
        }

        // 修改预约记录
        RouteAppointment routeAppointment = new RouteAppointment();
        routeAppointment.setId(dto.getId());
        routeAppointment.setDepartId(routeDepart.getId());
        routeAppointment.setState(Constants.APPOINTMENT_STATUS_FINISH);
        routeAppointment.setDepartTime(new Date());
        baseMapper.updateById(routeAppointment);
    }
}
