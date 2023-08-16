<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<template:include ref="default.archive" sidebar="no">
<template:replace name="head">
</template:replace>
<template:replace name="title">
	<c:out value="${hrRatifyRetireForm.docSubject }"></c:out>
</template:replace>
<template:replace name="toolbar">
</template:replace>
<template:replace name="content">
<c:set var="p_defconfig" value="${p_defconfig}" scope="request"/>
<form name="hrRatifyRetireForm" method="post" action="<c:url value="/hr/ratify/hr_ratify_retire/hrRatifyRetire.do"/>">
<center>
<div class="print_title_header">
<p id="title" class="print_txttitle">
	<bean:write name="hrRatifyRetireForm" property="docSubject" />
</p>
<div class="printDate">
  	<bean:message bundle="hr-ratify" key="hrRatifyDocumentLableName.transferDate" />:<% out.print(DateUtil.convertDateToString(new Date(), DateUtil.TYPE_DATE, request.getLocale()));%>
</div>
</div>
<div id="printTable" style="border: none;">
<div printTr="true" style="border: none;">

<%-- 基本信息 width="650px" --%>
<div>
    <div class="tr_label_title"> 
       <div class="title">
      	 <bean:message bundle="hr-ratify" key="hrRatifyDocumentLableName.baseInfo" />
       </div>
    </div>
	<table class="tb_normal" width=100%>
		<!--主题-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.docSubject" /></td>
			<td colspan=3>
				<bean:write name="hrRatifyRetireForm" property="docSubject" /></td>
		</tr>
		<!--模板名称-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.docTemplate" /></td>
			<td colspan=3>
				<bean:write name="hrRatifyRetireForm" property="docTemplateName" /></td>
		</tr>
		<!--申请人-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.docCreator" /></td>
			<td width=35%>
				<html:hidden name="hrRatifyRetireForm" property="docCreatorId" /> 
				<bean:write name="hrRatifyRetireForm" property="docCreatorName" /></td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.docNumber" /></td>
			<td width=35%>
				<bean:write name="hrRatifyRetireForm" property="docNumber" /></td>
		</tr>
		<!--部门-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.fdDepartment" /></td>
			<td>
				<bean:write name="hrRatifyRetireForm" property="fdDepartmentName"/></td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.docCreateTime" /></td>
			<td width=35%>
				<bean:write name="hrRatifyRetireForm" property="docCreateTime" /></td>
		</tr>
		<!--实施反馈人-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMain.fdFeedback" /></td>
			<td colspan=3>
				<bean:write name="hrRatifyRetireForm" property="fdFeedbackNames" /></td>
		</tr>
		<!--关键字-->
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="hr-ratify" key="hrRatifyMKeyword.docKeyword" /></td>
			<td colspan=3>
				<bean:write name="hrRatifyRetireForm" property="fdKeywordNames" /></td>
		</tr>
	</table>
</div>

<%-- 审批内容 --%>
<div>
    <div class="tr_label_title">
	    <div class="title">
	       <bean:message bundle="hr-ratify" key="hrRatifyDocumentLableName.reviewContent" />
	    </div>
    </div>
	
	<c:if test="${hrRatifyRetireForm.docUseXform == 'false' }">
		<table id="info_content" class="tb_normal" width=100% >
			<tr>
                <td colspan="4">${hrRatifyRetireForm.docXform}</td>
            </tr>
		</table>
	</c:if>
	<c:if test="${hrRatifyRetireForm.docUseXform == 'true' || empty hrRatifyRetireForm.docUseXform }">
		<table id="info_content" width=100% >
			<tr>
				<td id="_xform_detail">
					<%-- 表单 --%>
					<c:import url="/resource/html_locate/sysForm.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="hrRatifyRetireForm" />
						<c:param name="fdKey" value="hrRatifyMain" />
						<c:param name="messageKey" value="hr-ratify:hrRatifyDocumentLableName.reviewContent" />
						<c:param name="useTab" value="false" />
						<c:param name="isPrint" value="true" />
					</c:import>
				</td>
			</tr>
		</table>
	 </c:if>
</div>

<%-- 审批记录 --%>
<c:if test="${saveApproval }">
<div>
    <div class="tr_label_title">
	    <div class="title">
	       <bean:message bundle="hr-ratify" key="hrRatify.note" />
	    </div>
    </div>
	<table width=100%>
		<!-- 审批记录 -->
		<tr>
			<td colspan=4>
				<c:import url="/resource/html_locate/lbpmAuditNote.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="hrRatifyRetireForm" />
				</c:import>
			</td>
		</tr>
	</table>
</div>
</c:if>
</div>
</div>


</center>
</form>
</template:replace>
		
</template:include>

