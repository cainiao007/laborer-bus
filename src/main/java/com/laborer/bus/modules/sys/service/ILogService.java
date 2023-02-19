package com.laborer.bus.modules.sys.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.laborer.bus.modules.sys.entity.Log;

/**
 * <p>
 * 日志表 服务类
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2023-02-18
 */
public interface ILogService extends IService<Log> {

    Page<Log> listLogPage(Log log);

}
