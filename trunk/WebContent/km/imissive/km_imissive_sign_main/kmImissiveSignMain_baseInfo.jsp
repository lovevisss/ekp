 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<div class="lui_form_content_frame" style="padding-top:10px">
	<!-- 流程状态标识 -->
	<c:import url="/km/imissive/km_imissive_main/kmImissiveMain_banner.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignMainForm" />
	</c:import>
	<c:if test="${not empty kmImissiveSignMainForm.fdModelId && not empty kmImissiveSignMainForm.fdModelName}">
	<c:import url="/km/imissive/import/kmImissiveMain_relationFile.jsp" charEncoding="UTF-8">
		<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdModelId}" />
		<c:param name="fdModelName" value="${kmImissiveSignMainForm.fdModelName}" />
	</c:import>
</c:if>
<c:if test="${kmImissiveSignMainForm.fdIsSupervised eq true  and not empty fdSuperviseId}">
	<div class="imissiveRelationDiv">
		<span class="imissiveRelationSpan">
			相关督办:
		</span>
		<c:set var="canOpen" value="false"/>
		<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${fdSuperviseId}" requestMethod="GET">
			<c:set var="canOpen" value="true"/>
		</kmss:auth>		
		<c:choose>
			<c:when test="${canOpen eq 'true'}">
				<a class="imissiveRelationA" href='<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${fdSuperviseId}" ></c:url>' target="_blank" style="color: #4285f4">
					<c:out value="${fdSuperviseName}"></c:out>
				</a>
			</c:when>
			<c:otherwise>
				<c:out value="${fdSuperviseName}"></c:out>
			</c:otherwise>
		</c:choose>
	</div>	
</c:if>	
   <c:import url="/sys/xform/include/sysForm_view.jsp"	charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignMainForm" />
		<c:param name="fdKey" value="signMainDoc" />
		<c:param name="messageKey" value="km-imissive:kmImissiveSignMain.baseinfo"/>
		<c:param name="useTab" value="false"/>
	</c:import>
</div>
<c:choose>
	<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.addSupervise eq true}">
		<div id="superVisedDiv">
			<div style="margin-bottom: 10px; font-size: 16px">督办基本信息:</div>
			<ui:iframe id="superVisedFrame" src=""></ui:iframe>
		</div>
	</c:when>
	<c:otherwise>
		<c:if test="${kmImissiveSignMainForm.fdIsSupervised eq true  and not empty fdSuperviseId}">
			<div style="margin-bottom: 10px; font-size: 16px">督办基本信息:</div>
			<ui:iframe src="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=viewBase&fdId=${fdSuperviseId}"></ui:iframe>
		</c:if>
	</c:otherwise>
</c:choose>