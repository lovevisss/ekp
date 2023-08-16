<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments }">
  	<div class="lui_form_content_frame">
		<div style="padding-left:9px;padding-bottom: 15px;">
			<div class="lui_form_subhead">
				<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
				${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }
			</div>
		  	<c:choose>
				<c:when test="${editAtt eq true}">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="attachment" />
						<c:param name="uploadAfterSelect" value="true" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="fdLabel" value="文档附件" />
						<c:param name="fdGroup" value="documentAtt" />
					</c:import>
				</c:when>
				<c:otherwise>	
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="fdLabel" value="文档附件" />
						<c:param name="fdGroup" value="documentAtt" />
					</c:import>
				</c:otherwise> 
			</c:choose>
		</div>
	</div>
</c:if>