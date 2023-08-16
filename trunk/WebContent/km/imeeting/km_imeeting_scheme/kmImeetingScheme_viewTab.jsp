<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
<c:if test="${param.approveModel ne 'right'}">
		<form name="kmImeetingSchemeForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_scheme/kmImeetingScheme.do">
</c:if>
	
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel id="tabpanelDiv"  layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" >
				<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewContent.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmImeetingSchemeForm.fdId}"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme"/>
					<c:param name="formBeanName" value="kmImeetingSchemeForm"/>
				</c:import>
				<c:choose>
					<c:when test="${kmImeetingSchemeForm.docStatus>='30' || kmImeetingSchemeForm.docStatus=='00' || kmImeetingSchemeForm.docStatus=='10'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingSchemeForm" />
							<c:param name="fdKey" value="ImeetingScheme" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingSchemeForm, 'publishDraft');" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingSchemeForm" />
							<c:param name="fdKey" value="ImeetingScheme" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingSchemeForm, 'publishDraft');" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingSchemeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
				</c:import>
				
				<%--发布机制--%>
			 	<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="fdKey" value="ImeetingScheme" />
						<c:param name="order" value="12"/>
					</c:import>
				</c:if>
				
				<%-- 传阅 --%>
				<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="order" value="11" />
					</c:import>
				</c:if>

			</ui:tabpanel>
			<%@ include file="/km/imeeting/km_imeeting_scheme/kmImeetingAttPreview.jsp" %>
		</c:when>
		<c:otherwise>
			<ui:tabpage id="tabpanelDiv" expand="false">
				<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewContent.jsp" charEncoding="UTF-8">
				</c:import>
				<%--流程机制 --%>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingSchemeForm" />
					<c:param name="fdKey" value="ImeetingScheme" />
					<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingSchemeForm, 'publishDraft');" />
				</c:import>
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingSchemeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
				</c:import>
				<%--发布机制--%>
			 	<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="fdKey" value="ImeetingScheme" />
						<c:param name="order" value="12"/>
					</c:import>
				</c:if>
				<%-- 传阅 --%>
				<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="order" value="11" />
					</c:import>
				</c:if>
			</ui:tabpage>
			<c:if test="${param.approveModel ne 'right'}">
				</form>
			</c:if>
			<%@ include file="/km/imeeting/km_imeeting_scheme/kmImeetingAttViewPreview.jsp" %>
		</c:otherwise>
	</c:choose>
<script language="JavaScript">
	var validation = $KMSSValidation(document.forms['kmImeetingSchemeForm']);
</script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<c:choose>
			<c:when test="${kmImeetingSchemeForm.docStatus>='30' || kmImeetingSchemeForm.docStatus=='00'}">
			<!-- 基本信息-->
			<ui:accordionpanel>
				<c:import url="/km/imeeting/km_imeeting_scheme/kmImeetingTopic_viewBaseInfo.jsp" charEncoding="UTF-8">
				</c:import>
			</ui:accordionpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
					<c:if test="${kmImeetingSchemeForm.docStatus != '10'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingSchemeForm" />
							<c:param name="fdKey" value="ImeetingScheme" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingSchemeForm, 'publishDraft');" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
					</c:if>
					<!-- 审批记录 -->
					<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingSchemeForm" />
						<c:param name="fdModelId" value="${kmImeetingSchemeForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
					</c:import>
				</ui:tabpanel>
			</c:otherwise>
		</c:choose>
	</template:replace>
</c:if>	
