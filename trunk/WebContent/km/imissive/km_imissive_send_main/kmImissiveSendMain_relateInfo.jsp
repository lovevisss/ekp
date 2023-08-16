<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<c:set var="mainForm" value="${requestScope[param.formName]}"/>
<c:if test="${not empty kmImissiveSendMainForm.fdMainId and not empty relatedSubject}">
	 <div class="lui_form_content_frame" style="padding-top:10px">
		<div  class="lui_form_subhead">
			关联收文: <a onclick="window.open('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveSendMainForm.fdId}&spreadAuth=true"/>','_blank');"><span class="handle_source_url"><c:out value="${relatedSubject}"></c:out></span></a>
		</div>
	  </div>
</c:if>  
<c:if test="${mainForm.docStatus !='30'}">
	<kmss:auth requestURL="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdReadSendOpinion=true&fdReceiveId=${mainForm.fdId}&fdModelId=${mainForm.fdMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&formBeanName=kmImissiveReceiveMainForm" requestMethod="GET">
	   <div class="lui_form_content_frame" style="padding-top:10px">
			<div>
				<%--
				<div class="lui_form_subhead">原审批意见：</div>
				<iframe  width="100%" style="margin-bottom: -4px;border: none;" src="<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdReadSendOpinion=true&fdReceiveId=${mainForm.fdId}&fdModelId=${mainForm.fdMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain&formBeanName=kmImissiveReceiveMainForm" />" scrolling="no" FRAMEBORDER=0></iframe>
				 --%>
				 <c:if test="${not empty fdModelId and not empty fdModelName and not empty formBeanName and not empty fdRegId }">
					<c:choose>
				 		<c:when test="${kmImissiveSendMainForm.fdIsFromOut eq 'true' }">
					 			<div class="lui_form_subhead">原审批意见：</div>
					 			
				 		</c:when>
				 		<c:otherwise>
					 			<div class="lui_form_subhead">原审批意见：</div>
					 			<c:import url="/km/imissive/km_imissive_reg/kmImissiveReg_listNote.jsp" charEncoding="UTF-8">
									<c:param name="fdMainId" value="${fdModelId}" />
									<c:param name="fdModelName" value="${fdModelName}" />
									<c:param name="formBeanName" value="${formBeanName}"/>
									<c:param name="fdRegId" value="${fdRegId}" />
								</c:import>
				 		</c:otherwise>
				 	</c:choose>
			 	</c:if>
			</div> 
	   </div>
  </kmss:auth> 
</c:if>
