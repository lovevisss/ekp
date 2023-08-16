<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script>
    seajs.use(['theme!form']);
	Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
</script>
	<html:form action="/hr/ratify/hr_ratify_feedback/hrRatifyFeedback.do">
	<div style="text-align: right;padding-right: 20px;">
		<c:if test="${hrRatifyFeedbackForm.method_GET=='edit'}">
		    <ui:button text="${ lfn:message('button.update') }" order="2"  onclick="Com_Submit(document.hrRatifyFeedbackForm, 'update');">
			</ui:button>
		</c:if> 
		<c:if test="${hrRatifyFeedbackForm.method_GET=='add'}">
		    <ui:button text="${ lfn:message('button.submit') }" order="2"  onclick="Com_Submit(document.hrRatifyFeedbackForm, 'save');">
			</ui:button>
		</c:if> 
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		</ui:button>
	</div>

	<p class="txttitle"><bean:message bundle="hr-ratify"
		key="table.hrRatifyFeedback" /></p>

	<center>
	<table class="tb_normal" width=95%>
		<!-- 反馈人 -->
		<tr>
			<td class="td_normal_title" width=30%>
				<html:hidden property="fdDocId" /> 
				<html:hidden property="docCreatorId"/>
				<bean:message bundle="hr-ratify" key="hrRatifyFeedback.docCreator" />
			</td>
			<td>
				<html:text property="docCreatorName" readonly="true" style="width:50%" />
			</td>
		</tr>
		<!-- 反馈时间 -->
		<tr>
			<td class="td_normal_title" width=30%>
				<bean:message bundle="hr-ratify" key="hrRatifyFeedback.docCreateTime" />
			</td>
			<td>
				<html:text property="docCreateTime" readonly="true" style="width:50%" />
			</td>
		</tr>
		<!-- 提要 -->
		<tr>
			<td class="td_normal_title" width=30%>
				<bean:message bundle="hr-ratify" key="hrRatifyFeedback.fdSummary" />
			</td>
			<td>
				<xform:text property="fdSummary" style="width:97%" />
			</td>
		</tr>
		<!-- 反馈内容 -->
		<tr>
			<td class="td_normal_title" width=30%><bean:message
				bundle="hr-ratify" key="hrRatifyFeedback.docContent" /></td>
			<td><html:textarea property="docContent" style="width:97%" /></td>
		</tr>
		<!-- 文档附件 -->
		<tr>
			<td class="td_normal_title" width=10%><bean:message
 				bundle="hr-ratify" key="hrRatifyFeedback.attachment"/></td> 
			<td>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="feedBackAttachment"/>
				</c:import>	
			</td>
		</tr>
		
		<!-- 通知人员 -->
		<tr>
			<td class="td_normal_title" width=30%><bean:message
				bundle="hr-ratify" key="hrRatifyFeedback.fdNotifyPeople" /></td>
			<td>
			<xform:address propertyId="fdNotifyId" propertyName="fdNotifyPeople" mulSelect="true" orgType="ORG_TYPE_ALL" style="width:97%"></xform:address>
			<br>
			
			</td>
		</tr>
		<!-- 通知方式 -->
		<tr>
			<td class="td_normal_title" width=10%><bean:message
				bundle="hr-ratify" key="hrRatifyFeedback.fdNotifyType" /></td>
			<td>
				<kmss:editNotifyType property="fdNotifyType"/>
			</td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<script language="JavaScript">
			$KMSSValidation(document.forms['hrRatifyFeedbackForm']);
</script>
	</template:replace>
</template:include>
