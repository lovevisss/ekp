<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.km.imeeting.model.KmImeetingScheme"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true" formName="kmImeetingSchemeForm" fdUseForm="${kmImeetingSchemeForm.docUseXform == 'true' || empty kmImeetingSchemeForm.docUseXform}" formUrl="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_scheme/kmImeetingScheme.do">
			<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewHead.jsp" charEncoding="UTF-8">
				<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
 		 	</c:import>
 		 	<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	<c:otherwise>
		<template:include ref="default.view" sidebar="auto">
			<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>