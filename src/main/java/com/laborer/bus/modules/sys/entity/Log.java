package com.laborer.bus.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.laborer.bus.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * <p>
 * 日志表
 * </p>
 *
 * @author zhao zhenqiang
 * @since 2023-02-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_log")
public class Log extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 登录名称
     */
    private String username;

    /**
     * 操作功能
     */
    private String operation;

    /**
     * 操作uri
     */
    private String forwardAction;

    /**
     * IP
     */
    private String ip;

    /**
     * 浏览器
     */
    private String browser;

    /**
     * 系统
     */
    private String os;

    /**
     * 执行时长(毫秒)
     */
    private Long time;

    /**
     * 创建时间
     */
    private Date createTime;


}
