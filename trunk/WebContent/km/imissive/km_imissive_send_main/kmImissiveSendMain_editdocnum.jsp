<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script>
seajs.use(['theme!form']);
Com_IncludeFile("doclist.js|dialog.js|calendar.js");
</script>
<script>
Com_SetWindowTitle('<bean:message bundle="km-imissive" key="kmImissiveSendMain.editdocnum"/>');
function submitForm(){
	var validateFlag = true;
	var fdDocNum = document.getElementsByName("fdDocNum")[0];
	if(fdDocNum.value == null || fdDocNum.value == ""){
		alert('<bean:message key="kmImissiveSendMain.message.error.fdDocNum" bundle="km-imissive" />');
		validateFlag = false;
	}
	
	if(validateFlag){
		Com_Submit(document.kmImissiveSendMainForm, 'updateDocNum');
	}
}

var count = 0;
$(document).ready(function(){
	var fdNoRule = "${kmImissiveSendMainForm.fdNoRule}";
	if(fdNoRule!=""){
		/*
		var ruleArr = fdNoRule.split("@");
		var html;
		for(var i = 0;i<ruleArr.length;i++){
			if(ruleArr[i]!=""){
				count += 1;
				if(ruleArr[i]!='flow'){
					var row = '<tr><td colspan="2"><input type="text" class="inputsgl" style="width:90%" name="ele'+i+'" onchange="changeNum();" value="'+ruleArr[i]+'"/></td></tr>';
				}else{
					var row = '<tr><td colspan="2"><input type="text" class="inputsgl" style="width:90%" name="flow" onchange="changeNum();" value="${kmImissiveSendMainForm.fdFlowNo}"/></td></tr>';
				}
				$('#xxx').append(row);
			}
		}
		*/
		
		var ruleArr = fdNoRule.split("@");
		$('#numberEle').html("");
		var row = "";
		for(var i = 0;i<ruleArr.length;i++){
			if(ruleArr[i]!=""){
				count += 1;
				if(ruleArr[i]!='flow'){
					 row += '<div style="float:left;margin-left:15px;width:150px"><input type="text" class="inputsgl" style="width:100%" name="ele'+i+'" onchange="changeNum();" value="'+ruleArr[i]+'"/></div>';
				}else{
					 row += '<div style="float:left;margin-left:15px;width:150px"><input type="text" class="inputsgl" style="width:100%" name="flow" onchange="changeNum();" value="${kmImissiveSendMainForm.fdFlowNo}"/></div>';
				}
			}
		}
		$('#numberEle').html(row);
		$('#numberEle').css({
			"padding-top":"25px",
		    "height":"35px"
		});
		//changeNum();
	}
});

function changeNum(){
	var fdDocNum="";
	var fdNoRule="";
	var fdFlowNo="";
	for(var i=0;i<count;i++){
		var a = "ele"+i;
		var ele = document.getElementsByName(a);
		if(ele.length>0){
			fdDocNum +=ele[0].value;
			fdNoRule +=ele[0].value;
		}
		if(ele.length==0){
			ele = document.getElementsByName("flow");
			fdDocNum +=ele[0].value;
			fdNoRule +="@flow@";
		}
	}
	document.getElementsByName("fdDocNum")[0].value = fdDocNum;
	document.getElementsByName("fdNoRule")[0].value = fdNoRule;
	document.getElementsByName("fdFlowNo")[0].value = document.getElementsByName("flow")[0].value;
}
</script>
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">

<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissiveSendMain.editdocnum"/></p>

<center>
<div>
	<table class="tb_normal" width=95% id="xxx">
		<html:hidden property="fdId"/>
		<tr>
			<td colspan="2">
			   <div><font color="red">${repeatMsg}</font></div>
			   <font><bean:message  bundle="km-imissive" key="kmImissiveSendMain.editdocnum.info"/></font>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
			</td>
			<td width=85%>
			     <c:choose>
				    <c:when test="${not empty kmImissiveSendMainForm.fdNoRule}">
				       <html:text property="fdDocNum" style="width:85%" readonly="true"/>
				    </c:when>
				    <c:otherwise>
				       <html:text property="fdDocNum" style="width:85%"/>
				    </c:otherwise>
			     </c:choose>
			    <html:hidden property="fdNoRule"/>
			    <html:hidden property="fdFlowNo"/>
			</td>
		</tr>
	</table>
	<div id = "numberEle">
	</div>
</div>
<div style="padding-top:17px">
	   <ui:button text="${ lfn:message('button.submit') }"  onclick="submitForm();">
	   </ui:button>
	   <ui:button text="${ lfn:message('button.close') }" order="5" styleClass="lui_toolbar_btn_gray"  onclick="Com_CloseWindow()">
	    </ui:button>
 </div>
</center>
<html:hidden property="method_GET"/>
</html:form>
	</template:replace>
</template:include>
