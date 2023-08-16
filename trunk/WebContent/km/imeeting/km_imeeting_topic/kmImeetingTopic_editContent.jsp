<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content id="kmImeetingTopicContent" title="议题详情" expand="true" >
	<html:hidden property="fdId" />
	<html:hidden property="fdModelId" />
	<html:hidden property="fdModelName" />
	<html:hidden property="docStatus" />
	<html:hidden property="docCreateTime"/>
	<html:hidden property="method_GET" />
	<html:hidden property="fdIsOtherDraft" />
	
	<c:choose>
		<c:when test="${notXFormFilePath eq 'true'}">
			<c:import url="/km/imeeting/km_imeeting_topic/import/topic_xform_default_edit.jsp"
				charEncoding="UTF-8">
			</c:import>
		</c:when>
		<c:when test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
			<c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
		        <c:param name="formName" value="kmImeetingTopicForm" />
		        <c:param name="fdKey" value="mainTopic" />
		        <c:param name="useTab" value="false" />
		    </c:import>
		</c:when>
	</c:choose>
</ui:content>