<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<%
	String fdCurUserId = UserUtil.getKMSSUser().getUserId();
	KmImeetingMainForm mainForm = (KmImeetingMainForm) request.getAttribute("kmImeetingMainForm");
	if (fdCurUserId.equals(mainForm.getDocCreatorId()) 
			|| fdCurUserId.equals(mainForm.getFdControlPersonId())
			|| UserUtil.getKMSSUser().isAdmin()) {
		request.setAttribute("isBoenBtn", "true");
	} else {
		request.setAttribute("isBoenBtn", "false");
	}
%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.imeeting.model.KmImeetingMain"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true"  fdUseForm="true" formName="kmImeetingMainForm" formUrl="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main/kmImeetingMain.do">
			<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
			<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>