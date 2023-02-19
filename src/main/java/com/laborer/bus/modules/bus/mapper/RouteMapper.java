package com.laborer.bus.modules.bus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.laborer.bus.modules.bus.entity.Route;

import java.util.List;

/**
 * <p>
 * 班车路线表 Mapper 接口
 * </p>
 * @since 2023-02-19 17:43:30
 */
public interface RouteMapper extends BaseMapper<Route> {

    /**
     * 查询列表(分页)
     * @param route 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Route> selectRouteList(@Param("route") Route route, IPage page);

}
