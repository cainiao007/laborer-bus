package com.laborer.bus.modules.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laborer.bus.modules.sys.entity.Dict;
import com.laborer.bus.modules.sys.mapper.DictMapper;
import com.laborer.bus.modules.sys.service.DictService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 * @since 2023-02-18 15:52:56
 */
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {

    @Override
    public Page<Dict> listDictPage(Dict dict) {
        Page<Dict> page = new Page<>(dict.getCurrent(), dict.getSize());
        if (StrUtil.isBlank(dict.getName())) {
            dict.setParentId(dict.getId() == null ? 0 : dict.getId()); // treegrid默认传的id作为parentId
        }
        List<Dict> dicts = baseMapper.selectDictList(dict, page);
        return page.setRecords(dicts);
    }

    @Override
    public Dict getByCode(String code) {
        return super.getOne(new LambdaQueryWrapper<Dict>().eq(Dict::getCode, code));
    }

    @Override
    public List<Dict> listAllDictItemByCode(String code) {
        return baseMapper.selectAllDictItemByCode(code);
    }

    @Override
    public List<Dict> listByParentId(Long parentId) {
        return super.list(new LambdaQueryWrapper<Dict>().eq(Dict::getParentId, parentId));
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteWithChildren(Long id) {
        super.removeById(id);
        this.deleteRecur(id);
    }

    private void deleteRecur(Long parentId) {
        List<Dict> dicts = this.listByParentId(parentId);
        dicts.forEach(dict -> {
            deleteRecur(dict.getId());
            super.removeById(dict.getId());
        });
    }


}
