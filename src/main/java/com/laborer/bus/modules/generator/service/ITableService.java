package com.laborer.bus.modules.generator.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.laborer.bus.modules.generator.dto.TableColumnDTO;
import com.laborer.bus.modules.generator.dto.TableDTO;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface ITableService {

    IPage<TableDTO> listTablePage(String tableName, int current, int size);

    List<TableColumnDTO> listTableColumn(String tableName);
}
