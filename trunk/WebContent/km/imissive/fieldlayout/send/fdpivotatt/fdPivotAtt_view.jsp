<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>	
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['fdPivotAtt'].attachments}">
	<c:choose>
		<c:when test="${param.mobile eq 'true'}">
			<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSendMainForm"></c:param>
				<c:param name="fdKey" value="fdPivotAtt"></c:param>
				<c:param name="fdModelId" value="${param.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
		</c:when>
		<c:otherwise>
			<%if(!"singletab".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
			<c:choose>
				<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
					<c:import url="/resource/html_locate/sysAttMain_view.jsp"  charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="fdPivotAtt" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="fdPivotAtt" />
					</c:import>
				</c:otherwise>
			</c:choose>
			<%}else{%>
			<c:choose>
				<c:when test="${kmImissiveSendMainForm.method_GET eq 'viewXformInfo'}">
					<c:import url="/resource/html_locate/sysAttMain_view.jsp"  charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="fdPivotAtt" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="fdLabel" value="办理要报附件" />
						<c:param name="fdGroup" value="pivotAtt" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="fdPivotAtt" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="fdLabel" value="办理要报附件" />
						<c:param name="fdGroup" value="pivotAtt" />
					</c:import>
				</c:otherwise>
			</c:choose>
			<%}%>
		</c:otherwise>
	</c:choose>
</c:if>