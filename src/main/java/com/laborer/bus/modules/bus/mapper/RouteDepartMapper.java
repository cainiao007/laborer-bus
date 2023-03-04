package com.laborer.bus.modules.bus.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.modules.bus.dto.RouteDepartDto;
import com.laborer.bus.modules.bus.entity.RouteDepart;
import com.laborer.bus.modules.bus.vo.RouteDepartVo;

/**
 * <p>
 * 班车发车记录表 Mapper 接口
 * </p>
 * @since 2023-03-01 20:57:59
 */
public interface RouteDepartMapper extends BaseMapper<RouteDepart> {

    /**
     * 查询列表(分页)
     * @param routeDepart 查询参数
     * @param page 分页参数
     * @return list
     */
    List<RouteDepart> selectRouteDepartList(RouteDepart routeDepart, IPage page);

    /**
     * 查询待发车列表(分页)
     * @param routeDepart 查询参数
     * @param page 分页参数
     * @return list
     */
    List<RouteDepartVo> toDepart(RouteDepartDto routeDepart, Page<RouteDepartVo> page);

    /**
     * 查询发车记录(分页)
     * @param routeDepart 查询参数
     * @param page 分页参数
     * @return list
     */
    List<RouteDepartVo> record(RouteDepartDto routeDepart, Page<RouteDepartVo> page);
}
