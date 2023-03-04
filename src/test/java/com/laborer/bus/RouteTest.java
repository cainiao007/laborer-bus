package com.laborer.bus;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.dto.R;
import com.laborer.bus.modules.bus.controller.RouteController;
import com.laborer.bus.modules.bus.entity.Route;

/**
 * @description: 班车管理测试类
 * @package: com.laborer.bus
 * @author: zhaozhenqiang
 * @date: 2023/3/4 17:28
 * @version: 1.0
 */
public class RouteTest extends BaseJunitTest{

    @Autowired
    private RouteController controller;

    /**
     * 新增班车路线
     */
    @Test
    public void add(){
        String json = "{\"carNumber\":\"京B66666\",\"carType\":2,\"capacity\":40,\"driverUid\":1,\"startAddress\":\"霍营1\"," +
                "\"endAddress\":\"北土城11\",\"planDepartTime\":\"00:00\"}";
        Route route = JSON.parseObject(json, Route.class);
        R r = controller.add(route);
        Assert.assertTrue(Constants.OK_CODE == r.getCode());
    }

    /**
     * 修改班车路线
     */
    @Test
    public void edit(){
        String json = "{\"id\":1,\"carNumber\":\"京B66666\",\"carType\":2,\"capacity\":40,\"driverUid\":1,\"startAddress\":\"霍营1\"," +
                "\"endAddress\":\"北土城11\",\"planDepartTime\":\"00:00\"}";
        Route route = JSON.parseObject(json, Route.class);
        R r = controller.edit(route);
        Assert.assertTrue(Constants.OK_CODE == r.getCode());
    }

    /**
     * 查询班车路线列表
     */
    @Test
    public void reservable(){
        R r = controller.listData(new Route());
        Assert.assertTrue(Constants.OK_CODE == r.getCode());
    }
}
