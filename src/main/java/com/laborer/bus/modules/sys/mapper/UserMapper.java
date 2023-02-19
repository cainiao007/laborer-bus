package com.laborer.bus.modules.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laborer.bus.modules.sys.entity.User;
import com.laborer.bus.modules.sys.vo.UserQueryVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2019-04-29
 */
public interface UserMapper extends BaseMapper<User> {

    /**
     * 查询用户列表
     * @param queryVO 查询参数
     * @return
     */
    List<User> selectUserList(@Param("queryVO") UserQueryVO queryVO, Page page);

}
