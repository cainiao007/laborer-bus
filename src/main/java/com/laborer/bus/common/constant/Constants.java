package com.laborer.bus.common.constant;

/**
 * 常量类
 */
public class Constants {

    public final static int OK_CODE = 200;
    public final static int FAIL_CODE = 400;
    public final static int OTHER_FAIL_CODE = 333;    // 其它错误
    public final static String OK_MSG = "请求成功";
    public final static String FAIL_MSG = "请求失败";
    public final static int STATUS_0 = 0;   // 可用状态
    public final static int STATUS_1 = 1;   // 禁用状态

    public final static String CACHE_NAME = "KACache";

    public final static String XSS_NOTICE_KEY = "notice";

    /**
     * 用户文件上传基础路径
     */
    public final static String BASE_USER_FILE_PATH = "userFile";

    /**
     * TODAY.
     */
    public static final Integer TODAY = 0;

    /**
     * AFTER_TODAY.
     */
    public static final Integer AFTER_TODAY = 1;

    /**
     * 预约状态 0已预约 1已取消 2已结束.
     */
    public static final Integer APPOINTMENT_STATUS_RESERVED = 0;

    /**
     * 预约状态 0已预约 1已取消 2已结束.
     */
    public static final Integer APPOINTMENT_STATUS_CANCEL = 1;

    /**
     * 预约状态 0已预约 1已取消 2已结束.
     */
    public static final Integer APPOINTMENT_STATUS_FINISH = 2;

}
