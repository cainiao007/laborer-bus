package com.laborer.bus.modules.sys.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laborer.bus.modules.sys.entity.Log;
import com.laborer.bus.modules.sys.mapper.LogMapper;
import com.laborer.bus.modules.sys.service.ILogService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 日志表 服务实现类
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2023-02-18
 */
@Service
public class LogServiceImpl extends ServiceImpl<LogMapper, Log> implements ILogService {

    @Override
    public Page<Log> listLogPage(Log log) {
        Page<Log> page = new Page<>(log.getCurrent(), log.getSize());
        List<Log> logs = baseMapper.selectLogList(log, page);
        return page.setRecords(logs);
    }
}
