<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="kmImeetingScheme" />
			<c:param name="fdModelId" value="${param.fdId}" />
			<c:param name="fdMulti" value="false" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
			<c:param name="formName" value="kmImeetingSchemeForm"/>
		</c:import> 
    </c:when>
    <c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmImeetingSchemeForm" />
			<c:param name="fdKey" value="kmImeetingScheme" />
			<c:param name="fdMulti" value="false" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
		</c:import>
	</c:otherwise>
</c:choose>
