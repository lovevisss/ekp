<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">	
		<c:choose>
			<c:when test="${notXFormFilePath eq 'true'}">
				<c:import url="/km/imeeting/km_imeeting_topic/import/topic_xform_default_view.jsp"
					charEncoding="UTF-8">
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
			        <c:param name="formName" value="kmImeetingTopicForm" />
			        <c:param name="fdKey" value="mainTopic" />
			        <c:param name="useTab" value="false" />
			    </c:import>
			</c:otherwise>
		</c:choose>
	</template:replace> 
</template:include>