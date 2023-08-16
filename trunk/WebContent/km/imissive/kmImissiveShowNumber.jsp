<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="auto">
<template:replace name="body"> 
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<script>
	seajs.use(['theme!form']);
</script>
<script language="JavaScript">
var fdLimits;
var tempId;
seajs.use(['lui/jquery'],function($){
	$(document).ready(function(){
		tempId = "${JsParam.fdId}";
		var type = "${JsParam.type}";
		var url = "";
		var className = "";
		if(type == "send"){
			url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getNumber";
			className = "com.landray.kmss.km.imissive.model.KmImissiveSendMain";
	    }else if (type == "receive"){
	    	url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getNumber";
	    	className = "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
	    }else if(type == "sign"){
	    	url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getNumber";
	    	className = "com.landray.kmss.km.imissive.model.KmImissiveSignMain";
	    }
		 if(url != ""){
			 $.ajax({     
	    	     type:"post",    
	    	     url:url,   
	    	     data:{"tempId":tempId},
	    	     async:false,    //用同步方式 
	    	     success:function(data){
	    	    	if(data){
	    	    		var results =  eval("("+data+")");
		    		    //if(results['docNum']!=""){
		    		    	
		    		    	// var docArray = results['docNum'].split(";");
		    		    	 /*
		    		    	document.getElementsByName("FdName")[0].value  = docArray[0];
		    		    	document.getElementsByName("FdVirtualNumberValue")[0].value  = docArray[1];
		    		    	document.getElementsByName("fdFlowNum")[0].value  = docArray[2];
		    		    	*/
		    		    	var contentHTML = '<table class="tb_normal" width=95% style="margin-top:10px;table-layout:fixed">';
		    		    	contentHTML += '<tr>';
		    		    	contentHTML += '<td width=25%>';
							contentHTML += '编号规则名称';
							contentHTML += '</td>';
							contentHTML += '<td>';
							contentHTML += results['fdName'];
							contentHTML += '</td>';
							contentHTML += '</tr>';
							contentHTML += '<tr>';
		    		    	contentHTML += '<td width=25%>';
							contentHTML += '编号模拟值';
							contentHTML += '</td>';
							contentHTML += '<td>';
							contentHTML += results['fdVirtualNumberValue'];
							contentHTML += '</td>';
							contentHTML += '</tr>';
							contentHTML += '<tr>';
		    		    	contentHTML += '<td width=25%>';
							contentHTML += '当前最大流水号';
							contentHTML += '</td>';
							contentHTML += '<td>';
							contentHTML += results['fdFlowNum'];
							contentHTML += '</td>';
							contentHTML += '</tr>';
							contentHTML += '<tr>';
		    		    	contentHTML += '<td width=25% >';
							contentHTML += '漏号';
							contentHTML += '</td>';
							contentHTML += '<td style="word-break:break-all;word-wrap:break-word">';
							if(results['fdUnuseNum']){
								var unUseArr = results['fdUnuseNum'].split(";");
								contentHTML += "<table width='100%'>"
								for(var i = 0;i<unUseArr.length;i++){
									if(i%3 == 0){
										contentHTML += "<tr>"
									}
									contentHTML += "<td style='padding-right:6px'>"+unUseArr[i]+"</td>"
									if(i%3 == 2){
										contentHTML += "</tr>"
									}
								}
								contentHTML += "</table>"
		    		        }else{
		    		        	contentHTML += '没查找到任何漏号';
		    		        }
							contentHTML += '</td>';
							contentHTML += '</tr>';
							if(getTempNumberFromDb(results['fdNumberId'])){
								contentHTML += '<tr class="clearTr">';
								contentHTML += '<td colspan="2">';
								contentHTML += '1、文件编号操作时，为防止编号跳号，预览时会将该编号规则生成的编号缓存到数据库<br>2、当对编号规则进行预览操作后又修改了模板起始流水号，此时可通过以下清除按钮清除缓存编号<br>3、由于公式定义器的解析和执行依赖于主文档和数据字典，故该漏号显示时过滤了规则中的公式自定义元素，若模板编号规则包含公式定义器，则重号校验结果以实际校验结果为准';
								contentHTML += '</td>';
								contentHTML += '</tr>';
								contentHTML += '<tr class="clearTr">';
								contentHTML += '<td colspan="2">';
								contentHTML += '<center><input type="button" class="lui_form_button" value="清除" onclick="clearNum(\''+results['fdNumberId']+'\');"/></center>';
								contentHTML += '</td>';
								contentHTML += '</tr>';
							}
							contentHTML += '</table>';
							$("#containDiv").html(contentHTML);
							if(results['fdLimits']){
								fdLimits = results['fdLimits'];
								loadCondition(url,className,results['fdLimits']);
							}
		    			//}
	    	    	}else{
	    	    		var contentHTML = '<div style="padding-top:50px;padding-bottom:40px">该模板编号规则为不限制，无预览编号!</div>';
	    	    		$("#containDiv").html(contentHTML);
	    			}
	    		}   
	        }); 
		 }
	});
	
	window.loadCondition = function(url,className,fdLimits){
		url = Com_SetUrlParameter(url, "method", "loadDictProperties");
		url += "&className="+className+"&fdLimits="+fdLimits;
		$("#conditionFrame").prop("src",url);
	}
});

</script>
<%
%>

<center>
	<div id="containDiv">
	</div>
	<iframe id="conditionFrame" frameborder="0" width="95%" src="">
	</iframe>
</center>
</template:replace>
</template:include>

