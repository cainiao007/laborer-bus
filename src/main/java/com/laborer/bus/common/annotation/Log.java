package com.laborer.bus.common.annotation;

import java.lang.annotation.*;

/** 
 * 【作用】系统操作日志注解<br>
 * 【说明】（无）
 * @author zhao zhenqiang
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {
    
    String value() default ""; // 操作说明
}

