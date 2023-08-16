<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>

<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="mainonline" />
			<c:param  name="fdMulti" value="false" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			<c:param name="formName" value="kmImeetingTopicForm"/>
			<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty kmImeetingTopicForm.attachmentForms['mainonline'].attachments}">
			<div style="padding-left:9px;padding-bottom: 15px;">
			  	<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="mainonline"/>
					<c:param  name="fdMulti" value="false" />
					<c:param name="uploadAfterSelect" value="true" />
					<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
					<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				</c:import>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>