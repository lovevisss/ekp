<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>Com_IncludeFile("dialog.js|doclist.js|calendar.js|jquery.js");</script>
<kmss:windowTitle subjectKey="km-imeeting:table.kmImeetingTopicCategory" moduleKey="km-imeeting:module.km.imeeting" />
<html:form action="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do" onsubmit="return validateKmImeetingTopicCategoryForm(this);">
		
	
	<div id="optBarDiv">
		<c:if
			test="${kmImeetingTopicCategoryForm.method_GET=='edit'}">
			<input type=button value="<bean:message key="button.update"/>"
				onclick="submitForm('update');" />
		</c:if> 
		<c:if test="${kmImeetingTopicCategoryForm.method_GET=='add'}">
			<input type=button value="<bean:message key="button.save"/>"
				onclick="submitForm('save');">
			<input type=button value="<bean:message key="button.saveadd"/>"
				onclick="submitForm('saveadd');">
		</c:if> 
		<input type="button" value="<bean:message key="button.close"/>"
			onclick="Com_CloseWindow();">
	</div>

	<p class="txttitle"><bean:message bundle="km-imeeting" key="table.kmImeetingTopicCategory" /></p>

	<center>
	<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="2">
		<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="requestURL" value="km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=add" />
			<c:param name="fdModelName" value="${param.fdModelName}" />
		</c:import>
		
       <c:import url="/sys/xform/include/sysFormTemplate_edit.jsp" charEncoding="UTF-8">
           <c:param name="formName" value="kmImeetingTopicCategoryForm" />
           <c:param name="fdKey" value="mainTopic" />
           <c:param name="messageKey" value="km-imeeting:py.BiaoDanMuBan" />
           <c:param name="fdMainModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
       </c:import>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="fdKey" value="mainTopic" /> 
		</c:import>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTopicCategoryForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory" />
				</c:import>
			</table>
			</td>
		</tr>
		<!-- 编号机制 -->
		<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>
		</c:import>
	</table>
	</center>
	<html:hidden property="fdId" />
	<html:hidden property="method_GET" />
	<script>
		Com_IncludeFile("dialog.js|jquery.js");
		var validation=$KMSSValidation();
		
		function submitTopicForm(method) {
			// 判断描述字符长度
		    var fdDesc = document.getElementsByName("fdDesc");
		    if(fdDesc.length > 0) {
			    var newvalue = fdDesc[0].value.replace(/[^\x00-\xff]/g, "***");
				if(newvalue.length > 1500) {
					var msg = '<bean:message key="errors.maxLength"/>'.replace("{0}", '<bean:message bundle="sys-simplecategory" key="sysSimpleCategory.fdDesc"/>').replace("{1}", 1500);
					alert(msg);
					return;
				}
		    }
		    Com_Submit(document.kmImeetingTopicCategoryForm, method);
		}
		
		function submitForm(method) {
			if(typeof XForm_BeforeSubmitForm != 'undefined' && XForm_BeforeSubmitForm instanceof Function){
				XForm_BeforeSubmitForm(function(){
					submitTopicForm(method);
				});
			}else{
				submitTopicForm(method);
		    }
		}
	</script>
</html:form>
<html:javascript formName="kmImeetingTopicCategoryForm" cdata="false" dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>
