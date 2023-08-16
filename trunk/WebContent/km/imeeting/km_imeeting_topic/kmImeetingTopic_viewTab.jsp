<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
<c:if test="${param.approveModel ne 'right'}">
	<c:if test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
		<form name="kmImeetingTopicForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do">
	</c:if>
</c:if>
	
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				<c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_viewContent.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>
					<c:param name="formBeanName" value="kmImeetingTopicForm"/>
				</c:import>
				<c:choose>
					<c:when test="${kmImeetingTopicForm.docStatus>='30' || kmImeetingTopicForm.docStatus=='00'}">
						<c:choose>
							<c:when test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingTopicForm" />
									<c:param name="fdKey" value="mainTopic" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingTopicForm, 'publishDraft');" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
									<c:param name="needInitLbpm" value="true" />
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingTopicForm" />
									<c:param name="fdKey" value="mainTopic" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
									<c:param name="needInitLbpm" value="true" />
								</c:import>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingTopicForm" />
									<c:param name="fdKey" value="mainTopic" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingTopicForm, 'publishDraft');" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingTopicForm" />
									<c:param name="fdKey" value="mainTopic" />
									<c:param name="showHistoryOpers" value="true" />
									<c:param name="isExpand" value="true" />
									<c:param name="approveType" value="right" />
								</c:import>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTopicForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false">
				<c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_viewContent.jsp" charEncoding="UTF-8">
				</c:import>
				<%--流程机制 --%>
				<c:choose>
					<c:when test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingTopicForm" />
							<c:param name="fdKey" value="mainTopic" />
							<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingTopicForm, 'publishDraft');" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingTopicForm" />
							<c:param name="fdKey" value="mainTopic" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<%--权限机制 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTopicForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				</c:import>
			</ui:tabpage>
			<c:if test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
				</form>
			</c:if>
		</c:otherwise>
	</c:choose>
<script language="JavaScript">
	var validation = $KMSSValidation(document.forms['kmImeetingTopicForm']);
</script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<c:choose>
			<c:when test="${kmImeetingTopicForm.docStatus>='30' || kmImeetingTopicForm.docStatus=='00'}">
				<ui:accordionpanel>
					<!-- 基本信息-->
					<c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_viewBaseInfo.jsp" charEncoding="UTF-8">
					</c:import>
				</ui:accordionpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
					<c:choose>
						<c:when test="${kmImeetingTopicForm.docUseXform == 'true' || empty kmImeetingTopicForm.docUseXform}">
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImeetingTopicForm" />
								<c:param name="fdKey" value="mainTopic" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="onClickSubmitButton" value="Com_Submit(document.kmImeetingTopicForm, 'publishDraft');" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right" />
								<c:param name="approvePosition" value="right" />
							</c:import>
						</c:when>
						<c:otherwise>
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImeetingTopicForm" />
								<c:param name="fdKey" value="mainTopic" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right" />
								<c:param name="approvePosition" value="right" />
							</c:import>
						</c:otherwise>
					</c:choose>
					<!-- 审批记录 -->
					<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingTopicForm" />
						<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
					</c:import>
					<!-- 基本信息-->
					<c:import url="/km/imeeting/km_imeeting_topic/kmImeetingTopic_viewBaseInfo.jsp" charEncoding="UTF-8">
					</c:import>
				</ui:tabpanel>
			</c:otherwise>
		</c:choose>
	</template:replace>
</c:if>	
