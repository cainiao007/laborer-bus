package com.laborer.bus.modules.sys.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping(value = "sys/component")
public class ComponentController {

    @RequiresPermissions(value = "component:icons:index")
    @GetMapping("icons/index")
    public ModelAndView icons() {
        return new ModelAndView("component/icons");
    }

    @RequiresPermissions(value = "component:ueditor:index")
    @GetMapping("ueditor/index")
    public ModelAndView ueditor() {
        return new ModelAndView("component/ueditor");
    }
}
