<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			<c:param name="formName" value="kmImeetingTopicForm"/>
			<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty kmImeetingTopicForm.attachmentForms['attachment'].attachments}">
			<div style="padding-left:9px;padding-bottom: 15px;">
				<div class="lui_form_subhead">
					<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
					(${fn:length(kmImeetingTopicForm.attachmentForms['attachment'].attachments)})个
				</div>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="attachment" />
					<c:param name="uploadAfterSelect" value="true" />
					<c:param name="fdRequired" value="<%=String.valueOf(required) %>" />
					<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
					<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				</c:import>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>