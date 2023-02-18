package com.laborer.bus.common.exception;

import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.dto.R;
import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 统一异常处理类
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private final static Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(BusinessException.class)
    public R handleKvfException(BusinessException e) {
        LOGGER.error("bus error:", e);
        if (e.getErrorCode() == null) {
            return R.fail(e.getMsg());
        }
        return R.fail(e.getErrorCode(), e.getMsg());
    }

    @ExceptionHandler(UnauthorizedException.class)
    public R handleUnauthorizedExceptionException(UnauthorizedException e) {
        LOGGER.error("bus error:{}", e.getMessage());
        return R.fail(Constants.OTHER_FAIL_CODE, "权限不足，请联系管理员。");
    }

    @ExceptionHandler(Exception.class)
    public R handleException(Exception e) {
        LOGGER.error("bus error:", e);
        return R.fail(Constants.OTHER_FAIL_CODE, e.getMessage());
    }
}
