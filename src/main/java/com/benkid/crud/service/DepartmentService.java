package com.benkid.crud.service;

import com.benkid.crud.bean.Department;
import com.benkid.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiaoLi
 * @create 2020-02-17 8:52 PM
 */

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
