<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
	<%
		String fdTemplateId = request.getParameter("fdTemplateId");
		String showYear = "false";
		if(ImissiveUtil.isAcrossYearNumber(fdTemplateId, "com.landray.kmss.km.imissive.model.KmImissiveSignTemplate")){
			showYear = "true";
		}
		pageContext.setAttribute("showYear", showYear);
	%>	
	<script language="JavaScript">
	seajs.use(['theme!form']);
	seajs.use(['lui/jquery'],function($){
		$(document).ready(function(){
			if("${showYear}" == "true"){
				Year_Select("fdYearNo",1);
			}
			generateNum();
		});
	});
	var _fdVirtualNum = "";
	var _fdYearNo = "";
	function generateNum(){
		var fdNumberId="${JsParam.fdNumberId}";
		var fdYearNo = "";
		var date = new Date();
		fdYearNo = date.getFullYear();
		var fdYearNoEle = document.getElementsByName("fdYearNo");
		if(fdYearNoEle.length > 0){
			fdYearNo = document.getElementsByName("fdYearNo")[0].value;
		}
		 var fdVirtualNum ="";
   		 var docNum = document.getElementsByName("fdNum")[0];
   		 var fdRtnNum = document.getElementsByName("fdRtnNum")[0];
   		 document.getElementById("errorDiv").style.display = "none";
  		var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=generateNumByNumberId"; 
  		 $.ajax({     
   	    	     type:"post",     
   	    	     url:url,     
   	    	     data:{fdNumberId:fdNumberId,fdId:"${JsParam.fdId}",fdYearNo:fdYearNo},
   	    	     async:false,    //用同步方式 
   	    	     success:function(data){
   	    	 	    var results =  eval("("+data+")");
   	    	 	   if(results['hasError']=="true"){
   	    	 		  document.getElementById("errorDiv").style.display = "block";
   	    			}
	   	    	 	if(results['fdVirtualNum']!=null){
		   		     fdVirtualNum = results['fdVirtualNum'];
		   		     _fdVirtualNum = fdVirtualNum;
			   		  if(results['fdYearNo']){
		 		    		 _fdYearNo = results['fdYearNo'];
		 		     }
		   		    if(results['docNum']!=null){
		   	    		    	var fdFlowNo = getFlowNum(results['docNum']);
   		    					fdNumberMainId = getNumberMainId(results['docNum']);
   			    		        showEle(fdVirtualNum,fdFlowNo);
   			    		   	    docNum.value = formatNum(fdVirtualNum,fdFlowNo);
	   		    		   parent.document.cookie=(fdNumberId+'='+encodeURI(results['docNum']));
	   		    		    if("${JsParam.isAdd}" == 'true'){
	   		    		    	parent.document.cookie=(fdNumberId+'='+encodeURI(results['docNum']));
	   			    	   }
	   	    			}else{
	   	    				 docNum.value = "";
	   	    			}
	   	    	 	}
   	    		    
   	    		}  
		}); 
	}
	function optSubmit(){
		var rtn = {};
		var fdNum = document.getElementsByName("fdNum")[0].value;
		var fdRtnNum = document.getElementsByName("fdRtnNum")[0].value;
		var flag = false;
		 var r = /^-?\d+$/;　　//正整数
		 if($('input[name^=flow]').length > 0){
			 var length = $('input[name^=flow]').length;
			 var count = 0;
			 $('input[name^=flow]').each(function(index){
				  if(!r.test($(this).val())){
		  			flag = false;
			  	  }else{
			  		count++;
			  		if(count == index+1){
			  			flag = true;
			  		}
			  	  }
			 });
			 if(count != length && !flag){
				 seajs.use(['sys/ui/js/dialog'],function(dialog) {
	  	 			dialog.alert("流水号只能输入整数!");
	  	 			return false;
	  	 		});
			 }
		 }else{
			 flag = true;
		 }
		if(flag){
			rtn.fdNum = fdNum;
			rtn.fdRtnNum = fdRtnNum;
			rtn.fdYearNo = _fdYearNo;
			parent.fdVirtualNum = _fdVirtualNum;
			$dialog.hide(rtn);
		}
	}
	</script>
	<center>
		<div  style="overflow-x:hidden;overflow-y:auto">
			<table class="tb_normal" width=95% style="margin-top:25px">
				<c:if test="${showYear eq 'true'}">
					<tr>
					    <td class="titleTd">编号年份</td>
						<td class="titleTd">
						 	<select id="fdYearNo" name="fdYearNo"></select>
						 	&nbsp;&nbsp;
							 <ui:button text="${lfn:message('km-imissive:kmMissive.number.preview') }" order="2"  onclick="generateNum();">
						     </ui:button>
						</td>
						
					</tr>
				</c:if>
				<tr>
				    <td><bean:message bundle="km-imissive" key="kmImissiveSignMain.fdDocNum"/></td>
					<td>
					 <input type="text" name="fdNum" readonly="readonly" style="border:none;width:97%"/>
					 <input type="hidden" name="fdRtnNum" class="inputsgl" style="width:97%"/>
					</td>
				</tr>
			</table>
			<div id = "numberEle">
			</div>
		</div>
	</center>
	<div id="errorDiv" style="color:red;padding-top:10px;margin-left: 10px;margin-right: 10px;display:none">
		<div>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info1"/><br>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info2"/><br>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info3"/><br>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info4"/><br>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info5"/><br>
			<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info6"/>
		</div>
	</div>
	<center>
		<div  style="margin-top: 25px;margin-bottom:20px;">
		    <ui:button id="ok_id" text="${lfn:message('button.ok') }" order="2"  onclick="optSubmit();">
			</ui:button>&nbsp;&nbsp;
			<ui:button text="${lfn:message('button.cancel') }" order="2"  onclick="$dialog.hide();">
			</ui:button>
		</div> 
	</center>
	</template:replace>
</template:include>
