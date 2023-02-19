package com.laborer.bus.modules.bus.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.laborer.bus.common.controller.BaseController;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.modules.bus.entity.Route;
import com.laborer.bus.modules.bus.service.RouteService;

import java.util.List;


/**
 * <p>
 * 班车路线表 前端控制器
 * </p>
 * @since 2023-02-19 17:43:30
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

    @RequiresPermissions("bus:route:add")
    @PostMapping(value = "add")
    public R add(Route route) {
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

