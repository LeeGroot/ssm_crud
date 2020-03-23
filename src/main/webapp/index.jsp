<%@ page isELIgnored="false" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="update_dept_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="add_dept_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--删除，新增按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="myModal-btn">新增</button>
            <button class="btn btn-danger" id="delete_all">删除</button>
        </div>
    </div>
    <%--显示数据的表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--导航列--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    //1.页面加载完成，发送ajax请求,要到分页数据
    $(function () {
        to_page(1);
        }
    )
    $("#myModal-btn").click(function () {
        //清除表单数据
        $("#myModal form")[0].reset();
        $("#empName_add_input").parent().removeClass("has-success has-error");
        $("#empName_add_input").next("span").text("");
        $("#email_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").next("span").text("");
        //发ajax请求获取所有部门
        getDepts("#add_dept_select");
        //2.显示模态框
        $("#myModal").modal({
            backdrop:"static"
        });
    })
    $("#emp_save_btn").click(function () {
        //前端校验
        // if (!validate_add_form()){
        //     return false;
        // }
        if($(this).attr("ajax-va") == "error"){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#myModal form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    //关闭模态框
                    $("#myModal").modal('hide');
                    //跳到最后一页，显示刚保存的数据
                    to_page(totalRecord);
                }else{
                    if(undefined != result.extend.errorFeilds.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFeilds.email);
                    }
                    if(undefined != result.extend.errorFeilds.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFeilds.empName);
                    }
                }
            }
        })
    })

    $("#empName_add_input").change(function () {
        var empName = $("#empName_add_input").val();
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }

        })
    })
    //表单校验
    function validate_add_form() {
        var empName = $("#empName_add_input").val();
            var regName = 	/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名可以是6-16个字符或2-5个汉字！");
            show_validate_msg("#empName_add_input","error","用户名可以是6-16个字符或2-5个汉字！");
            return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input","error","邮箱格式不正确！");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }

        return true;
    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else{
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $.each(result.extend.depts,function () {
                    var optionELe = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionELe.appendTo(ele);
                })
            }
        })
    }
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {

                //console.log(result);
                //1.解析并显示员工数据；

                build_emps_table(result);

                //2.解析并显示分页数据

                build_page_info(result);

                //解析显示分页条数据
                build_page_nav(result);


            }
        })
    }
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index, item) {
            var checkBoxTd = $("<td></td>").append(" <input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.id);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append((item.gender=='M'||item.gender=="男")?"男":"女");
            var empEmailTd = $("<td></td>").append(item.email);
            var empDepartmentTd = $("<td></td>").append(item.department.deptName);
            var editButton = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editButton.attr("edit-id",item.id);
            var delButton = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delButton.attr("del-id",item.id);
            var button = $("<td></td>").append(editButton).append(delButton);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDepartmentTd)
                .append(button)
                .appendTo("#emps_table tbody");
        })

    }

    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"
            + result.extend.pageInfo.pageNum + "页，总共"
            + result.extend.pageInfo.pages +"页，总共"
            + result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            })

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")).attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })

            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })
        }
        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    $(document).on("click",".edit_btn",function () {
        //弹出模态框前先查出员工信息
        //部门信息
        getDepts("#update_dept_select");
        getEmp($(this).attr("edit-id"));

        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    
    
    function getEmp(id) {

        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData = result.extend.emp;
                empData.gender = (empData.gender=='M'||empData.gender=="男")?'M':'F';
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);

            }
        })
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {

        //校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确！");
            show_validate_msg("#email_update_input","error","邮箱格式不正确！");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }

        //发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                //修改完成，关闭模态框，返回当前页
                $("#empUpdateModal").modal("hide");
                //回到本页
                to_page(currentPage);
            }
        });

    });

    //单个删除事件
    $(document).on("click",".delete_btn",function () {
        //alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        if (confirm("确定删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });


    //全选，全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;

        $("#check_all").prop("checked",flag);

    });

    $("#delete_all").click(function () {
        var empNames = "";
        var empIds = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        empIds = empIds.substring(0,empIds.length-1);
        empNames = empNames.substring(0,empNames.length-1);

        if (confirm("确定删除【"+empNames+"】吗")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                    $("#check_all").prop("checked",false);
                }
            });
        }
    });
    

</script>
</body>
</html>
