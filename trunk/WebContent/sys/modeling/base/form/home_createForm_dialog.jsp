<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="config.edit" sidebar="no">
    <template:replace name="head">
        <link type="text/css" rel="stylesheet"
              href="${KMSS_Parameter_ContextPath}sys/modeling/base/resources/css/override.css?s_cache=${LUI_Cache}"/>
        <script>
            Com_IncludeFile("view.css", "${LUI_ContextPath}/sys/modeling/base/resources/css/", "css", true);
            Com_IncludeFile("dialog.css", "${LUI_ContextPath}/sys/modeling/base/resources/css/", "css", true);
        </script>
        <style>
            .lui_custom_list_boxs {
                border-top: 1px solid #d5d5d5;
                position: fixed;
                bottom: 0;
                width: 100%;
                background-color: #fff;
                z-index: 1000;
                height: 63px;
            }

            .appMenu_main_icon {
                width: 52px;
                height: 52px;
                background: #FFFFFF;
                /*box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.10);*/
                border-radius: 8px;
                display: inline-block;
                text-align: center;
                line-height: 52px;
                border: 1px solid #DFE3E9;
            }

            .appMenu_main_icon i {
                font-size: 30px;
            }

            .select_icon_btn {
                width: 90px;
                display: inline-block;
                height: 30px;
                border: 1px solid #DDDDDD;
                border-radius: 2px;
                border-radius: 2px;
                bottom: 4px;
                position: relative;
                margin-left: 15px;
                font-size: 14px;
                text-align: center;
                line-height: 30px;
            }
        </style>
    </template:replace>
    <template:replace name="content">
        <center>
            <form>
                    <%-- <h2 align="center" style="margin: 10px 0">
                        <span class="profile_config_title">${lfn:message('sys-modeling-base:modeling.model.createForm')}</span>
                    </h2> --%>
                <table class="tb_simple model-view-panel-table" style="margin-top:20px" width=95%>
                    <tr>
                        <td class="td_normal_title" width=15% style="line-height: 30px;">
                                ${lfn:message('sys-modeling-base:modeling.model.form.name')}
                        </td>
                        <td width=85% class="model-view-panel-table-td">
                            <input class="inputsgl form" placeholder="${lfn:message('sys-modeling-base:modeling.form.EnterFormName')}"
                                   style="width: 95%;padding-left:8px;font-size:12px;height:27px;border-radius: 2px"
                                   name="fdName" subject="${lfn:message('sys-modeling-base:modeling.model.form.name')}" type="text" validate="required  maxLength(100)"/><span
                                class="txtstrong">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width=15% style="line-height: 52px;">
                            ${lfn:message('sys-modeling-base:modeling.form.FormIcon')}
                        </td>
                        <td width=85% class="model-view-panel-table-td">
                            <div class="appMenu_main_icon"><i class="iconfont_nav"></i></div>
                            <span class="txtstrong">*</span>
                            <a href="javascript:void(0);" class="select_icon_btn" onclick="selectIcon();">
                                <!-- <i class="iconfont_nav" style="color:#999;font-size:40px;"></i> -->
                                ${lfn:message('sys-modeling-base:modeling.form.ChangeIcon')}
                            </a>
                            <input name="fdIcon" type="hidden" value="iconfont_nav"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width=15% style="line-height: 52px;">
                           ${lfn:message('sys-modeling-base:modeling.model.appName')}
                        </td>
                        <td width=85% class="model-view-panel-table-td" style="line-height: 52px;">
                            <select name="fdAppId" id="fdApp" class="inputsgl" subject="${lfn:message('sys-modeling-base:modeling.model.appName')}" validate="required" style="width: 60%;padding-left:8px;font-size:12px;height:27px;border-radius: 2px">

                            </select>
                            <span class="txtstrong">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_normal_title" width=15% style="line-height: 52px;">
                            ${lfn:message('sys-modeling-base:modeling.form.type')}
                        </td>
                        <td width=85% class="model-view-panel-table-td" style="line-height: 52px;">
                            <select name="type" class="inputsgl" subject="${lfn:message('sys-modeling-base:modeling.form.type')}" validate="required" style="width: 60%;padding-left:8px;font-size:12px;height:27px;border-radius: 2px">
                                <option value="1">${lfn:message('sys-modeling-base:modeling.form.FlowlessForm')}</option>
                                <option value="2">${lfn:message('sys-modeling-base:modeling.form.FlowForm')}</option>
                            </select>
                            <span class="txtstrong">*</span>
                        </td>
                    </tr>
                </table>
                    <%-- <div style="margin-top:20px">
                        <!-- 保存 -->
                        <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="submit();" order="1" ></ui:button>
                        <ui:button text="${lfn:message('button.close')}" height="35" width="120" onclick="cancle();" order="1" ></ui:button>
                    </div> --%>
                <div class="lui_custom_list_boxs" style="margin-top:20px">
                    <center>
                        <div class="lui_custom_list_box_content_col_btn" style="text-align: right;width: 95%">
                        	<ui:button styleClass="lui_custom_list_box_content_blue_btn" onclick="submit('save');" text="${ lfn:message('button.save') }">
                        	</ui:button>
                        	<ui:button styleClass="lui_custom_list_box_content_whith_btn" onclick="cancle();" text="${ lfn:message('button.cancel') }">
                        	</ui:button>
                        </div>
                    </center>
                </div>
            </form>
        </center>
        <script>
            var _validation=$KMSSValidation();
			var submitFlag = false;
			var appInfos = {};
            seajs.use(["lui/jquery", "lui/dialog"], function ($, dialog) {
                window.selectIcon = function () {
                    var url = "/sys/modeling/base/resources/iconfont.jsp?type=module";
                    dialog.iframe(url, "${lfn:message('sys-modeling-base:modeling.app.selectIcon')}", changeIcon, {
                        width: 750,
                        height: 500
                    })
                }

                $(document).ready(function (){
                    var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingApplication.do?method=getAllSelfBuildApps";
                    $.ajax({
                        url: url,
                        type: "post",
                        data: {},
                        success: function (rtn) {
                            if (rtn) {
                                    for(var i =0;i<rtn.apps.length;i++){
                                        var item = rtn.apps[i];
                                        $("#fdApp").append("<option value="+item.id+">"+item.name+"</option>");
                                    }

                            } else {

                            }
                        }
                    });
                });

                window.changeIcon = function (className) {
                    if (className) {
                        $("i.iconfont_nav").removeClass().addClass(className);
                        $("input[name='fdIcon']").val(className.split(" ")[1]);
                    }
                }

                function getAllForms() {
                    var fdAppId = $("[name='fdAppId']").val();
                    var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=findFormNumAndAppIsSelfBuild&fdAppId="+fdAppId;
                    $.ajax({
                        url:url,
                        async:false,
                        type:'GET',
                        dataType:'json',
                        success:function(result){
                            if (result){
                                appInfos =result ;
                            }else{
                                dialog.failure(result.errmsg);
                            }
                        }
                    });
                    return appInfos;
                }

                window.submit = function () {
                	if(submitFlag){
                		return;
                	}
                	window.submit_load = dialog.loading();
                    if (!_validation.validate()) {
                    	window.submit_load.hide();                
                        return
                    }
                    getAllForms();
                    if (appInfos.FormNums >= appInfos.maxNum){
                        window.submit_load.hide();
                        dialog.alert("${lfn:message('sys-modeling-base:modelingLicense.up.to.30.forms')}");
                        return;
                    }
                    if(validateSameName()){
                    	window.submit_load.hide();
                    	return 
                    }
                   	var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=saveBaseInfoByAjax";
                   	submitFlag=true;
                       $.ajax({
                           url: url,
                           type: "post",
                           data: $('form').serialize(),
                           success: function (rtn) {
                               var info;
                               if(typeof(rtn) === 'object'){
                                   info = rtn;
                               }
                               else{
                                   info = $.parseJSON(rtn);
                               }
                        	   submitFlag=false;
                               if (rtn.status === '00') {
                                   //刷新当前窗口
                                   var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=frame&fdId=" + rtn.data.id;
                                   top.open(url, "_self");
                                   //$dialog.___params["formWindow"].open(url,"_self");
                                   //$dialog.hide({type:'success'});
                               } else {
                                   dialog.failure(rtn.errmsg);
                               }
                               if(info.isMoreThanMaxCount){
                                   var html ='<span class="info" style="color:#ea4335">'+info.title+'</span>';
                                   if($(".inputsgl").next(".txtstrong").nextAll(".info").length > 0){
                                       $(".info").text(info.title);
                                   }else{
                                       $(".inputsgl").next(".txtstrong").after(html);
                                   }
                                   $(".info").css("display","block");
                                   result = true;
                               }l
                               window.submit_load.hide();
                           }
                       }); 
                }
            });

            function cancle() {
                $dialog.hide({type: 'cancle'});
            }
            
            function validateSameName(){
            	var formName = $("[name='fdName']").val();
            	var fdAppId = $("[name='fdAppId']").val();
            	if(!fdAppId){
            	    return true;
                }
                var url = Com_Parameter.ContextPath + "sys/modeling/base/modelingAppModel.do?method=validateSameName&fdAppId="+fdAppId+"&modelName="+formName;
                var isExistSameName = false;
                $.ajax({
                    url: url,
                    type: "post",
                    async: false,
                    success: function (rtn) {
                        var info;
                        if(typeof(rtn) === 'object'){
                            info = rtn;
                        }
                        else{
                            info = $.parseJSON(rtn);
                        }
                    	if(info.isExistSameName){
                    		var html ='<span class="info" style="color:#ea4335">'+info.title+'</span>';
                    		if($(".inputsgl.form").next(".txtstrong").nextAll(".info").length > 0){
                        		$(".info").text(info.title);
                    		}else{
                    			$(".inputsgl.form").next(".txtstrong").after(html);
                    		}
                    		$(".info").css("display","block");
                    		isExistSameName = true;
                    	}
                    }
                });
                return isExistSameName;
            }
            
            $(document).on("click",".inputsgl",function(){
            	$(".info").css("display","none");
            })
        </script>
    </template:replace>
</template:include>