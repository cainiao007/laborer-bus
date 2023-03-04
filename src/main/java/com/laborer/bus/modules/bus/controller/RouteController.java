package com.laborer.bus.modules.bus.controller;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.common.controller.BaseController;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.modules.bus.dto.RouteDto;
import com.laborer.bus.modules.bus.entity.Route;
import com.laborer.bus.modules.bus.service.RouteService;


/**
 * <p>
 * 班车线路表 前端控制器
 * </p>
 * @since 2023-03-01 20:57:58
 */
@RestController
@RequestMapping("bus/route")
public class RouteController extends BaseController {

    @Autowired
    private RouteService routeService;

    @RequiresPermissions("bus:route:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("bus/route");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long id) {
        ModelAndView mv = new ModelAndView("bus/route_edit");
        Route route;
        if (id == null) {
            route = new Route();
        } else {
            route = routeService.getById(id);
        }
        mv.addObject("editInfo", route);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Route route) {
        Page<Route> page = routeService.listRoutePage(route);
        return R.ok(page);
    }

    @GetMapping(value = "list/reservable")
    public R reservable(RouteDto route) {
        Page<Route> page = routeService.reservable(route);
        return R.ok(page);
    }

    @RequiresPermissions("bus:route:add")
    @PostMapping(value = "add")
    public R add(Route route) {
        // 校验路线重复
        LambdaQueryWrapper<Route> wrapper = new LambdaQueryWrapper<Route>()
                .eq(Route::getStartAddress, route.getStartAddress())
                .eq(Route::getEndAddress, route.getEndAddress())
                .eq(Route::getPlanDepartTime, route.getPlanDepartTime());
        List<Route> list = routeService.list(wrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            return R.fail("班车路线已存在");
        }
        routeService.save(route);
        return R.ok();
    }

    @RequiresPermissions("bus:route:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("ids") List<Long> ids) {
        routeService.removeByIds(ids);
        return R.ok();
    }

    @RequiresPermissions("bus:route:edit")
    @PostMapping(value = "edit")
    public R edit(Route route) {
        // 校验路线重复
        LambdaQueryWrapper<Route> wrapper = new LambdaQueryWrapper<Route>()
                .eq(Route::getStartAddress, route.getStartAddress())
                .eq(Route::getEndAddress, route.getEndAddress())
                .eq(Route::getPlanDepartTime, route.getPlanDepartTime());
        List<Route> list = routeService.list(wrapper);
        if (CollectionUtils.isNotEmpty(list) && !route.getId().equals(list.get(0).getId())) {
            return R.fail("班车路线已存在");
        }
        routeService.updateById(route);
        return R.ok();
    }

    @RequiresPermissions("bus:route:del")
    @PostMapping(value = "del/{id}")
    public R del(@PathVariable Long id) {
        routeService.removeById(id);
        return R.ok();
    }

    @GetMapping(value = "get/{id}")
    public R get(@PathVariable Long id) {
        return R.ok(routeService.getById(id));
    }

}

