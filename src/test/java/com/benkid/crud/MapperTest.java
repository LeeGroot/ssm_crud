package com.benkid.crud;

import com.benkid.crud.bean.Department;
import com.benkid.crud.bean.Employee;
import com.benkid.crud.dao.DepartmentMapper;
import com.benkid.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author XiaoLi
 * @create 2020-01-08 1:03 AM
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession session;

    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

//     1.插入部门；
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        2.插入员工
//        employeeMapper.insertSelective(new Employee(null,"张三","男","1232456@qq.com",1));
//  3.批量插入员工1000个；
        EmployeeMapper mapper = session.getMapper(EmployeeMapper.class);
        for(int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid, "男", uid+"@qq.com", 1));
        }

        System.out.println("批量完成");
    }
}