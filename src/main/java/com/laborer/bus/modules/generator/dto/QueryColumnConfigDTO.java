package com.laborer.bus.modules.generator.dto;

import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * 查询列配置
 * @author zhao zhenqiang
 * @Date 2019/06/13 10:45
 */
@Data
@Accessors(chain = true)
@ToString
public class QueryColumnConfigDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;
    private String nameCamelCase;
    private String dataType;
    private String comment;
}
