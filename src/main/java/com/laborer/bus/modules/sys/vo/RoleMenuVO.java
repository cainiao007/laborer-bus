package com.laborer.bus.modules.sys.vo;

import com.laborer.bus.modules.sys.entity.Role;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * 角色菜单
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class RoleMenuVO extends Role {
    private Long[] menuIds;
}
