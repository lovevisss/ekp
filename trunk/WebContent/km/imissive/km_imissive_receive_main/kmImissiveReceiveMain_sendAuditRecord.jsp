<%@page import="com.landray.kmss.km.imissive.model.KmImissiveSendMain"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSendMainService"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveReceiveMainForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${requestScope[param.formName]}"/>
 <kmss:auth requestURL="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdAdviceFlag=true&fdReceiveId=${mainForm.fdId}&fdModelId=${mainForm.fdMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&formBeanName=kmImissiveSendMainForm" requestMethod="GET">
	<%
		KmImissiveReceiveMainForm kmImissiveReceiveMainForm = (KmImissiveReceiveMainForm)request.getAttribute("kmImissiveReceiveMainForm");
		if(kmImissiveReceiveMainForm != null){
			String fdMainId = kmImissiveReceiveMainForm.getFdMainId();
			IKmImissiveSendMainService kmImissiveSendMainService = (IKmImissiveSendMainService)SpringBeanUtil.getBean("kmImissiveSendMainService");
			KmImissiveSendMain  kmImissiveSendMain = (KmImissiveSendMain)kmImissiveSendMainService.findByPrimaryKey(fdMainId);
			if(kmImissiveSendMain!=null){
	%>
		<ui:content title="主流程意见" titleicon="lui-tab-icon tab-icon-09">
			<table class="tb_normal" style="width: 100%">
				<c:if test="${kmImissiveSendMain.fdIsPublic eq true}">
					<tr>
						<td>
							主流程: <a class="com_btn_link" href="javascript:void(0);" onclick="sendDetail('${regDetail.fdReceiveId}');"><%=kmImissiveSendMain.getDocSubject() %></a>
						</td>
					</tr>
				</c:if>
				<tr>
					<td>
						<div class="lui_form_subhead">主流程意见：</div>
						<iframe  width="100%" style="margin-bottom: -4px;border: none;" src="<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdReadSendOpinion=true&fdReceiveId=${mainForm.fdId}&fdModelId=${mainForm.fdMainId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&formBeanName=kmImissiveSendMainForm" />" scrolling="no" FRAMEBORDER=0></iframe>
					</td>
				</tr> 
			
			</table>
		</ui:content>
		
	<%
			} 
		}
	%>
</kmss:auth>
<script>
	function sendDetail(){
		window.open('<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveReceiveMainForm.fdId}&spreadAuth=true&fdTargetModelId=${kmImissiveReceiveMainForm.fdMainId}&fdTargetModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>','_blank');
		
	}
</script>