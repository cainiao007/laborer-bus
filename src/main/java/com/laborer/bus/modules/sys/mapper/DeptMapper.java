package com.laborer.bus.modules.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.modules.sys.entity.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 部门表 Mapper 接口
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2019-04-29
 */
public interface DeptMapper extends BaseMapper<Dept> {

    List<Dept> selectDeptList(@Param("dept") Dept dept, Page page);

}
