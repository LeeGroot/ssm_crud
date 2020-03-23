package com.benkid.crud.controller;

import com.benkid.crud.bean.Department;
import com.benkid.crud.bean.Msg;
import com.benkid.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiaoLi
 * @create 2020-02-17 8:51 PM
 */


@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}
