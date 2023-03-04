package com.laborer.bus.modules.bus.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.common.controller.BaseController;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.modules.bus.dto.RouteDepartDto;
import com.laborer.bus.modules.bus.entity.RouteDepart;
import com.laborer.bus.modules.bus.service.RouteDepartService;
import com.laborer.bus.modules.bus.vo.RouteDepartVo;


/**
 * <p>
 * 班车发车记录表 前端控制器
 * </p>
 * @since 2023-03-01 20:57:59
 */
@RestController
@RequestMapping("bus/routeDepart")
public class RouteDepartController extends BaseController {

    @Autowired
    private RouteDepartService routeDepartService;

    @RequiresPermissions("bus:routeDepart:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("bus/routeDepart");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long id) {
        ModelAndView mv = new ModelAndView("bus/routeDepart_edit");
        RouteDepart routeDepart;
        if (id == null) {
            routeDepart = new RouteDepart();
        } else {
            routeDepart = routeDepartService.getById(id);
        }
        mv.addObject("editInfo", routeDepart);
        return mv;
    }

    @GetMapping(value = "list/toDepart")
    public R toDepart(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = routeDepartService.toDepart(routeDepart);
        return R.ok(page);
    }

    @RequiresPermissions("bus:routeDepart:list")
    @GetMapping("list")
    public ModelAndView list() {
        return new ModelAndView("bus/routeDepart_list");
    }

    @GetMapping(value = "list/data")
    public R listData(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = routeDepartService.listData(routeDepart);
        return R.ok(page);
    }

    @RequiresPermissions("bus:routeDepart:depart")
    @PostMapping(value = "depart")
    public R depart(RouteDepart routeDepart) {
        routeDepartService.depart(routeDepart);
        return R.ok();
    }

    @RequiresPermissions("bus:routeDepart:record")
    @GetMapping("record")
    public ModelAndView record() {
        return new ModelAndView("bus/routeDepart_record");
    }

    @GetMapping(value = "list/record")
    public R record(RouteDepartDto routeDepart) {
        Page<RouteDepartVo> page = routeDepartService.record(routeDepart);
        return R.ok(page);
    }

    @RequiresPermissions("bus:routeDepart:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("ids") List<Long> ids) {
        routeDepartService.removeByIds(ids);
        return R.ok();
    }

    @RequiresPermissions("bus:routeDepart:edit")
    @PostMapping(value = "edit")
    public R edit(RouteDepart routeDepart) {
        routeDepartService.updateById(routeDepart);
        return R.ok();
    }

    @RequiresPermissions("bus:routeDepart:del")
    @PostMapping(value = "del/{id}")
    public R del(@PathVariable Long id) {
        routeDepartService.removeById(id);
        return R.ok();
    }

    @GetMapping(value = "get/{id}")
    public R get(@PathVariable Long id) {
        return R.ok(routeDepartService.getById(id));
    }

}

