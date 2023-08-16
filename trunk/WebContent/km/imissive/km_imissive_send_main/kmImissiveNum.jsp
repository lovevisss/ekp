<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<style>
	.numberTb .titleTd{
		min-width:100px!important;
	}
	</style>
	<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
	<%
		String fdTemplateId = request.getParameter("fdTemplateId");
	    String showYear = "false";
		if(ImissiveUtil.isAcrossYearNumber(fdTemplateId, "com.landray.kmss.km.imissive.model.KmImissiveSendTemplate")){
			showYear = "true";
		}
		pageContext.setAttribute("showYear", showYear);
	%>
	<c:set var="definedId" value="${param.fdNoId}" scope="request"/>
	<c:set var="initNumberId" value="${not empty param.fdBufferNumId?param.fdBufferNumId:param.fdNoId}" scope="request"/>
	<link rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/chosen.css?s_cache=${MUI_Cache}" type="text/css"/>
	<script language="JavaScript">
	Com_IncludeFile("jquery.js");
	seajs.use(['theme!form']);
	</script>
		<div style="height: 350px;overflow-x:hidden;overflow-y:auto ">
			<center>
				<table class="tb_normal numberTb" width=95% style="margin-top:25px">
				   <tr>
					    <td class="titleTd"><bean:message bundle="km-imissive" key="kmMissive.number.select"/></td>
						<td class="titleTd">
						<%
							request.setAttribute("fdAllNumberFlag","1");
						    request.setAttribute("modelName","com.landray.kmss.km.imissive.model.KmImissiveSendMain");
						%>
						<xform:select property="fdNumberId" showStatus="edit" value="${initNumberId}" htmlElementProperties="id='numberSelect'" style="width:200px">
							<xform:customizeDataSource className="com.landray.kmss.sys.number.service.spring.SysNumberMainDataSource"></xform:customizeDataSource>
						</xform:select>&nbsp;&nbsp;
						 <ui:button text="${lfn:message('km-imissive:kmMissive.number.preview') }" order="2"  onclick="optGetNum();">
					     </ui:button>
						</td>
					</tr>		
					<c:if test="${showYear eq 'true'}">
						<tr>
						    <td class="titleTd">编号年份</td>
							<td class="titleTd">
							 	<select id="fdYearNo" name="fdYearNo"></select>
							</td>
						</tr>
					</c:if>			
					<tr>
					    <td class="titleTd"><bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/></td>
						<td class="titleTd">
						 <input type="text" name="fdNum" readonly="readonly" style="width:97%;border:none"/>
						 <input type="hidden" name="fdRtnNum" class="inputsgl" style="width:97%"/>
						</td>
					</tr>
					<tr style="display:none" id="unUseTr">
						<td id = "unUseTd" style="word-break:break-all;word-wrap:break-word" colspan="2">
						</td>
					</tr>
					<tr>
					    <td colspan="2"><font color="red"><bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.tips"/></font></td>
					</tr>
				</table>
				<div id = "numberEle">
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
				<div style="margin-top: 25px;margin-bottom:20px;z-index: 100">
				    <ui:button id="ok_id" text="${lfn:message('button.ok') }" order="2"  onclick="optSubmit();">
					</ui:button>&nbsp;&nbsp;
					<ui:button text="${lfn:message('button.cancel') }" order="2"  onclick="$dialog.hide();">
					</ui:button>
				</div> 
			</center>
		</div>
	<script src="${LUI_ContextPath}/km/imissive/resource/js/chosen.jquery.js" type="text/javascript"></script>
	<script language="JavaScript">
	$(document).ready(function(){
		if("${showYear}" == "true"){
			Year_Select("fdYearNo",1);
		}
		var docId = "${JsParam.fdId}";
		  generateNum(docId);
		 setTimeout(function(){
			 if($("#numberSelect")){
				 $("#numberSelect").chosen({
					 no_results_text:'<bean:message bundle="km-imissive" key="kmMissive.number.search.null"/>'
				 });
			 }
		 },300);
	});
	function generateNum(docId){
	   if("${initNumberId}"!=""){
			optGetNum();
	   }
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
			parent.fdBufferNumId = _fdBufferNumId;
			parent.fdVirtualNum = _fdVirtualNum;
			$dialog.hide(rtn);
		}
	}

	var fdNumberMainId = "";	
	
	function getUnUseNum(){
		var fdNumberId = document.getElementsByName("fdNumberId")[0].value;
		var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getUnUseNum"; 
		 $.ajax({     
   	     type:"post",    
   	     url:url,   
   	     data:{fdNumberId:fdNumberId,fdId:"${JsParam.fdId}",fdTemplateId:"${JsParam.fdTemplateId}"},
   	     async:false,    //用同步方式 
   	     success:function(data){
   	 	    var results =  eval("("+data+")");
 		   	 $('#unUseTr').show();
 		   	 if(results['unUseNum']!=null){
 		   		var unUseArr = results['unUseNum'].split(";");
 		   		var contentHTML = "<table><tr><td  colspan='3'>漏号:</td></tr>";
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
 		   		$('#unUseTd').html(contentHTML);
 		   	 }else{
 		   		$('#unUseTd').html('<bean:message bundle="km-imissive" key="kmMissive.number.unUse.null"/>');
 		   	 }
   		}   
       });
	}
	
	var _fdBufferNumId = "";
	var _fdVirtualNum = "";
	var _fdYearNo = "";
	function optGetNum(){
		var fdNumberId = document.getElementsByName("fdNumberId")[0].value;
		var fdYearNoEle = document.getElementsByName("fdYearNo");
		var fdYearNo = "";
		var nowYearNo = "";
		var date = new Date();
		fdYearNo = date.getFullYear();
		nowYearNo = date.getFullYear();
		if(fdYearNoEle.length > 0){
			fdYearNo = document.getElementsByName("fdYearNo")[0].value;
		}
		var fdVirtualNum ="";
		if(fdNumberId!=""){
		       var docNum = document.getElementsByName("fdNum")[0];
				var fdRtnNum = document.getElementsByName("fdRtnNum")[0];
				document.getElementById("errorDiv").style.display = "none";
				var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generateNumByNumberId"; 
				$.ajax({     
			    	     type:"post",    
			    	     url:url,   
			    	     data:{fdNumberId:fdNumberId,fdId:"${JsParam.fdId}",fdTemplateId:"${JsParam.fdTemplateId}",fdYearNo:fdYearNo},
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
			    		   	   parent.document.cookie=(fdNumberId+'='+encodeURI(results['docNum'])); //tomcat7下，cookie对中文支持不好，所以要进行编码
				    		   if("${JsParam.isAdd}" == 'true'){
				    		    		parent.document.cookie=(fdNumberId+'='+encodeURI(results['docNum']));
					    	   }
			    		   	   $('#unUseTr').show();
			    		   	   if(results['unUseNum']!=null &&  results['unUseNum']!= ""){
			    		   		 $('#unUseTd').show();
 			    		   		var unUseArr = results['unUseNum'].split(";");
 			     		   	var contentHTML = "<table><tr><td  colspan='3' style='font-size: 16px; line-height: 30px;'>漏号:</td></tr>";
 			    				for(var i = 0;i<unUseArr.length;i++){
 			    					if(i%3 == 0){
 			    						contentHTML += "<tr>";
 			    					}
 			    					contentHTML += "<td style='padding-right:6px'>"+unUseArr[i]+"</td>";
 			    					if(i%3 == 2){
 			    						contentHTML += "</tr>"
 			    					}
 			    				}
 			    			 	contentHTML += "</table>"
 			     		   	 	$('#unUseTd').html(contentHTML);
			    		   	   }else{
			    		   		   if(nowYearNo != fdYearNo){
			    		   			 $('#unUseTd').hide();
			    		   		   }else{
			    		   			 $('#unUseTd').html('<bean:message bundle="km-imissive" key="kmMissive.number.unUse.null"/>');
			    		   		   }
			    		   	   }
			    			}else{
			    				docNum.value = "";
			    			}
    			    	 	}
    			    	}
   			 });
		}
		//记下当前所选的编号规则，用于提交时清除cookie
	   _fdBufferNumId = fdNumberId;	  
	}
	</script>
	</template:replace>
</template:include>
