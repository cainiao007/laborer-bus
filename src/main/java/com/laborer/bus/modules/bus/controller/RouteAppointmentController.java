package com.laborer.bus.modules.bus.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.controller.BaseController;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.common.utils.ShiroKit;
import com.laborer.bus.modules.bus.dto.RouteAppointmentDto;
import com.laborer.bus.modules.bus.entity.Route;
import com.laborer.bus.modules.bus.entity.RouteAppointment;
import com.laborer.bus.modules.bus.service.RouteAppointmentService;
import com.laborer.bus.modules.bus.service.RouteService;
import com.laborer.bus.modules.bus.vo.RouteAppointmentVo;


/**
 * <p>
 * 班车预约表 前端控制器
 * </p>
 *
 * @since 2023-03-01 20:57:59
 */
@RestController
@RequestMapping("bus/routeAppointment")
public class RouteAppointmentController extends BaseController {

    @Autowired
    private RouteAppointmentService routeAppointmentService;

    @Autowired
    private RouteService routeService;

    @RequiresPermissions("bus:routeAppointment:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("bus/routeAppointment");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long id) {
        ModelAndView mv = new ModelAndView("bus/routeAppointment_edit");
        RouteAppointmentVo routeAppointment;
        if (id == null) {
            routeAppointment = new RouteAppointmentVo();
        } else {
            routeAppointment = routeAppointmentService.info(id);
        }
        mv.addObject("editInfo", routeAppointment);
        return mv;
    }

    @GetMapping(value = "appointment")
    public ModelAndView appointment(Long routeId) {
        ModelAndView mv = new ModelAndView("bus/routeAppointment_add");
        Route route;
        if (routeId == null) {
            route = new Route();
        } else {
            route = routeService.getById(routeId);
        }
        RouteAppointmentVo vo = new RouteAppointmentVo();
        BeanUtils.copyProperties(route, vo);
        vo.setRouteId(routeId);
        vo.setId(null);
        mv.addObject("editInfo", vo);
        return mv;
    }

    @RequiresPermissions("bus:routeAppointment:record")
    @GetMapping("record")
    public ModelAndView record() {
        return new ModelAndView("bus/routeAppointment_record");
    }

    @GetMapping("list/record")
    public R record(RouteAppointmentDto routeAppointment) {
        Page<RouteAppointmentVo> page = routeAppointmentService.record(routeAppointment);
        return R.ok(page);
    }

    @GetMapping(value = "list/data")
    public R listData(RouteAppointment routeAppointment) {
        Page<RouteAppointment> page = routeAppointmentService.listRouteAppointmentPage(routeAppointment);
        return R.ok(page);
    }

    @RequiresPermissions("bus:routeAppointment:add")
    @PostMapping(value = "add")
    public R add(RouteAppointment routeAppointment) {
        routeAppointment.setAppointmentUid(ShiroKit.getUserId());
        routeAppointmentService.save(routeAppointment);
        return R.ok();
    }

    @RequiresPermissions("bus:routeAppointment:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("ids") List<Long> ids) {
        routeAppointmentService.removeByIds(ids);
        return R.ok();
    }

    @RequiresPermissions("bus:routeAppointment:edit")
    @PostMapping(value = "edit")
    public R edit(RouteAppointment routeAppointment) {
        routeAppointmentService.updateById(routeAppointment);
        return R.ok();
    }

    @RequiresPermissions("bus:routeAppointment:del")
    @PostMapping(value = "del/{id}")
    public R del(@PathVariable Long id) {
        routeAppointmentService.update(new LambdaUpdateWrapper<RouteAppointment>()
                .eq(RouteAppointment::getId, id)
                .set(RouteAppointment::getState, Constants.APPOINTMENT_STATUS_CANCEL));
        return R.ok();
    }

    @RequiresPermissions("bus:routeAppointment:depart")
    @PostMapping(value = "depart")
    public R depart(RouteAppointmentDto routeAppointment) {
        routeAppointmentService.depart(routeAppointment);
        return R.ok();
    }

    @GetMapping(value = "get/{id}")
    public R get(@PathVariable Long id) {
        return R.ok(routeAppointmentService.getById(id));
    }

}

