<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.km.imissive.actions.KmImissiveMainAction"%>
<script type="text/javascript">
Com_IncludeFile("jquery.treeTable.css","${KMSS_Parameter_ContextPath}sys/lbpmservice/resource/","css",true);
Com_IncludeFile("jquery.js");
Com_IncludeFile("jquery.treeTable.js","${KMSS_Parameter_ContextPath}sys/lbpmservice/resource/","js",true);
Com_AddEventListener(window,'load',function() {
	$("#auditNoteTable_${param.formBeanName}").treeTable({
		initialState:"expanded",
		treeColumn:1,
		stringExpand:"",
		stringCollapse:""
	});
});

function selectAllAudit(){
	$('#auditNoteTable_${param.formBeanName}').find("input[name='List_Selected_Audit']").each(function(){
		$(this).prop("checked",!$(this).is(":checked"));
	});
}

</script>
<c:set var="fdModelId" value="${param.fdMainId}" scope="request"/>
<c:set var="fdModelName" value="${param.fdModelName}" scope="request"/>
<c:set var="formBeanName" value="${param.formBeanName}" scope="request"/>
<%
	new KmImissiveMainAction().listNote(null, null, request, response);
%>
<%
	LbpmSetting lbpmSetting = new LbpmSetting();
	pageContext.setAttribute("printLbpmPostscript",lbpmSetting.getPrintLbpmPostscript());
%>
<c:set var="mainForm" value="${requestScope[param.formBeanName]}" scope="request" /> 
<c:if test="${auditNotes!=null && fn:length(auditNotes)>1}">
	<table class="tb_normal" width="100%" id="auditNoteTable_${param.formBeanName}" >
		<tr class="tr_normal">
			<td width="5%" class="td_normal_title"><input type="checkbox" name="List_Selected_All_Audit" onclick="selectAllAudit();"></td>
			<td width="15%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.date" />
			</td>
			<td width="15%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdFactNodeName" />
			</td>
			<td width="15%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdHandlerId" />
			</td>
			<td width="50%" class="td_normal_title">
				<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdAuditNote" />
			</td>
		</tr>
		<c:forEach items="${auditNotes}" var="lbpmAuditNote" varStatus="vStatus">
			<%--过滤处理人为空的，即系统操作 --%>
			<c:if test="${ lbpmAuditNote.fdActionKey ne '_pocess_end' and not empty lbpmAuditNote.fdHandler}">
				<tr 
					<c:if test="${lbpmAuditNote.fdActionKey == '_concurrent_branch'}">
						id="${lbpmAuditNote.fdExecutionId}"
						<c:if test="${empty rootExecutionId}">
							<c:set var="rootExecutionId" value="${lbpmAuditNote.fdParentExecutionId}" />
						</c:if>
						<c:if test="${lbpmAuditNote.fdParentExecutionId != rootExecutionId}">
							class="child-of-${lbpmAuditNote.fdParentExecutionId}"
						</c:if>
					</c:if>
					<c:if test="${lbpmAuditNote.fdActionKey != '_concurrent_branch'}">
						id="${lbpmAuditNote.fdId}"
						<c:if test="${not empty lbpmAuditNote.fdParentExecutionId}">
							class="child-of-${lbpmAuditNote.fdExecutionId}"
						</c:if>
					</c:if>
					>
					<td style="white-space: nowrap;word-break: keep-all;">
						<input type="checkbox" 	name="List_Selected_Audit" value="${lbpmAuditNote.fdId}">
					</td>
					<td style="white-space: nowrap;word-break: keep-all;">
						<kmss:showDate type="datetime" value="${lbpmAuditNote.fdCreateTime}"/>
					</td>
					<td style="padding-left:14px;">
						<c:out value="${lbpmAuditNote.fdFactNodeName}" />
					</td>
					<td>
						<span title='<c:out value="${lbpmAuditNote.detailHandlerName}" />'>
							<c:out value="${lbpmAuditNote.handlerName}" />
						</span>
					</td>
					<td>
						<c:if test="${lbpmAuditNote.fdActionKey != 'subFlowNode_start'}">
							<c:if test="${lbpmAuditNote.fdIsHide=='2'}">
								<table class="tb_noborder" width="100%">
									<tr>
										<td style="word-wrap: break-word;word-break: break-all;" style="border: none;">
										<kmss:showText value="${lbpmAuditNote.fdAuditNote}" />
										</td>
									</tr>
									<c:if test="${not empty lbpmAuditNote.auditNoteListsJsps4Pc}">
									<tr>
										<td>
									<c:forEach items="${lbpmAuditNote.auditNoteListsJsps4Pc}" var="auditNoteListsJsp" varStatus="vstatus">
										<c:import url="${auditNoteListsJsp}" charEncoding="UTF-8">
											<c:param name="auditNoteFdId" value="${lbpmAuditNote.fdId}" />
											<c:param name="modelName" value="${lbpmAuditNote.fdProcess.fdModelName}" />
											<c:param name="modelId" value="${lbpmAuditNote.fdProcess.fdModelId}" />
											<c:param name="formName" value="${param.formBeanName}"/>
											<c:param name="curHanderId" value="${lbpmAuditNote.fdHandler.fdId}"/>
										</c:import>
									</c:forEach>
										</td>
									</tr>
									</c:if>
									<tr>
										<td>
											<%
												pageContext.setAttribute("__fdUID", com.landray.kmss.util.IDGenerator.generateID());
											%>
											<c:set var="_workitemId_handlerId_key" value="${lbpmAuditNote.fdWorkitemId}_${lbpmAuditNote.fdHandler.fdId}" />
											<c:if test="${not empty mainForm.attachmentForms[_workitemId_handlerId_key] and not empty mainForm.attachmentForms[_workitemId_handlerId_key].attachments}">
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									          <c:param name="formBeanName" value="${formBeanName}"/>
									          <c:param name="fdKey" value="${lbpmAuditNote.fdWorkitemId}_${lbpmAuditNote.fdHandler.fdId}"/>
									          <c:param name="fdModelId" value="${lbpmAuditNote.fdProcess.fdModelId}"/>
									          <c:param name="fdModelName" value="${lbpmAuditNote.fdProcess.fdModelName}"/>
									          <c:param name="fdViewType" value="simple" />
									          <c:param name="fdForceDisabledOpt" value="edit" />
									          <c:param name="fdUID" value="${__fdUID}"></c:param>
									        </c:import>
									        </c:if>
									        <c:if test="${not empty mainForm.attachmentForms[lbpmAuditNote.fdId] and not empty mainForm.attachmentForms[lbpmAuditNote.fdId].attachments}">
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									          <c:param name="formBeanName" value="${formBeanName}"/>
									          <c:param name="fdKey" value="${lbpmAuditNote.fdId}"/>
									          <c:param name="fdModelId" value="${lbpmAuditNote.fdProcess.fdModelId}"/>
									          <c:param name="fdModelName" value="${lbpmAuditNote.fdProcess.fdModelName}"/>
									          <c:param name="fdViewType" value="simple" />
									          <c:param name="fdForceDisabledOpt" value="edit" />
									          <c:param name="fdUID" value="${__fdUID}"></c:param>
									        </c:import>
									        </c:if>
										</td>
									</tr>
									<c:if test="${not empty lbpmAuditNote.auditNoteFrom}">
									<tr>
										<td align="right" style="color:#999;">
											<kmss:showText value="${lbpmAuditNote.auditNoteFrom}" />
										</td>
									</tr>
									</c:if>
									<!-- 流程附言 -->
									<c:if test="${printLbpmPostscript == 'true'}">
										<tr>
											<td colspan="3" class="lbpmPostscript" style="padding-top:10px;">
												<c:import url="/sys/lbpmservice/support/lbpm_postscript/lbpmPostscript_list.jsp" charEncoding="UTF-8">
											          <c:param name="formBeanName" value="${formBeanName}"/>
											          <c:param name="fdAuditNoteId" value="${lbpmAuditNote.fdId}"/>
											          <c:param name="fdFactNodeId" value="${lbpmAuditNote.fdFactNodeId}" />
											          <c:param name="print" value="true" />
										        </c:import>
											</td>
										</tr>
									</c:if>
								</table>
							</c:if>
							<c:if test="${lbpmAuditNote.fdIsHide=='1'}" >
								<font style="font-style:italic"><bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.fdIsHide_1" /></font>
							</c:if>
							<c:if test="${lbpmAuditNote.fdIsHide=='3'}" >
								<font style="font-style:italic"><bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.fdIsHide_3" /></font>
							</c:if>
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
</c:if>