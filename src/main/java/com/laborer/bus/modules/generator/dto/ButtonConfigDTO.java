package com.laborer.bus.modules.generator.dto;

import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * 按钮配置
 * @author zhao zhenqiang
 * @Date 2019/06/13 10:47
 */
@Data
@Accessors(chain = true)
@ToString
public class ButtonConfigDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;
    private String name;
    private String key;
    private String perId;   // 权限标识
    private String colorScheme;
    private String icon;
}
