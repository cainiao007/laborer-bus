package com.laborer.bus.modules.sys.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.modules.sys.entity.Log;
import com.laborer.bus.modules.sys.service.ILogService;
import com.laborer.bus.common.controller.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * 日志表 前端控制器
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2023-02-18
 */
@RestController
@RequestMapping("sys/log")
public class LogController extends BaseController {

    @Autowired
    private ILogService logService;

    @RequiresPermissions("sys:log:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("sys/log");
    }

    @GetMapping(value = "list/data")
    public R listData(Log log) {
        Page<Log> page = logService.listLogPage(log);
        return R.ok(page);
    }

}

