package com.benkid.crud.controller;

import com.benkid.crud.bean.Employee;
import com.benkid.crud.bean.Msg;
import com.benkid.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;


import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author XiaoLi
 * @create 2020-01-08 11:40 PM
 */



@Controller
public class EemployeeController {


    @Autowired
    EmployeeService employeeService;


    //通过员工id删除员工
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String idstr){
        if (idstr.contains("-")){
            List<Integer> ids = new ArrayList<>();
            String[] str_ids = idstr.split("-");
            for(String s:str_ids){
                ids.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(ids);
            return Msg.success();
        }else{
            Integer id = Integer.parseInt(idstr);
            employeeService.deleteEmp(id);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //用户名规则校验
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16字母、数字、-的组合或2-5个汉字");
        }

        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail();
        }
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors){
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFeilds", map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //        引入pagehelper插件
        //传入页码以及每页的大小
        PageHelper.startPage(pn,5 );
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了，封装了详细额分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo", page);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model){
//        引入pagehelper插件
        //传入页码以及每页的大小
        PageHelper.startPage(pn,5 );
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了，封装了详细额分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
