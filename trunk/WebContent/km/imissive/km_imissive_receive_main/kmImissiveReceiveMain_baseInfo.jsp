<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<div class="lui_form_content_frame" style="padding-top:10px">
	<!-- 流程状态标识 -->
	<c:import url="/km/imissive/km_imissive_main/kmImissiveMain_banner.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveMainForm" />
	</c:import>
<c:set var="mainForm" value="${requestScope[param.formName]}" />

	<c:if test="${not empty mainForm.fdModelId && not empty mainForm.fdModelName}">
		<c:import url="/km/imissive/import/kmImissiveMain_relationFile.jsp" charEncoding="UTF-8">
			<c:param name="fdModelId" value="${mainForm.fdModelId}" />
			<c:param name="fdModelName" value="${mainForm.fdModelName}" />
			<c:param name="docStatus" value="${mainForm.docStatus}" />
		</c:import>
	</c:if>
<c:if test="${mainForm.fdIsSupervised eq true  and not empty fdSuperviseId}">
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
   <!-- 发文转过来的收文没有表单模板，用默认的查看页面查看 -->
   <c:import url="/sys/xform/include/sysForm_view.jsp"	charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveMainForm" />
		<c:param name="fdKey" value="receiveMainDoc" />
		<c:param name="messageKey" value="km-imissive:kmImissiveReceiveMain.baseinfo"/>
		<c:param name="useTab" value="false"/>
	</c:import>
</div>

<c:choose>
	<c:when test="${mainForm.sysWfBusinessForm.fdNodeAdditionalInfo.addSupervise eq true}">
		<div id="superVisedDiv">
			<div style="margin-bottom: 10px; font-size: 16px">督办基本信息:</div>
			<ui:iframe id="superVisedFrame" src=""></ui:iframe>
		</div>
	</c:when>
	<c:otherwise>
		<c:if test="${mainForm.fdIsSupervised eq true  and not empty fdSuperviseId}">
			<div style="margin-bottom: 10px; font-size: 16px">督办基本信息:</div>
			<ui:iframe  src="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=viewBase&fdId=${fdSuperviseId}"></ui:iframe>
		</c:if>
	</c:otherwise>
</c:choose>