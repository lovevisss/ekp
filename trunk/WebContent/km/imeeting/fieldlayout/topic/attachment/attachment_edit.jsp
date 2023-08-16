<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment" />
			<c:param name="fdRequired" value="<%=String.valueOf(required) %>" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			<c:param name="formName" value="kmImeetingTopicForm"/>
			<c:param name="enabledFileType" value="doc|docx|xls|xlsx|ppt|pptx|xlc|mppx|xlcx|wps|et|vsd|rtf|pdf" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment" />
			<c:param name="uploadAfterSelect" value="true" />
			<c:param name="fdRequired" value="<%=String.valueOf(required) %>" />
			<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
		</c:import>
	</c:otherwise>
</c:choose> 
