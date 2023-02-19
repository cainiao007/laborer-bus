package com.laborer.bus.modules.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.modules.sys.entity.Log;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 日志表 Mapper 接口
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2023-02-18
 */
public interface LogMapper extends BaseMapper<Log> {

    List<Log> selectLogList(@Param("log") Log log, Page page);

}
