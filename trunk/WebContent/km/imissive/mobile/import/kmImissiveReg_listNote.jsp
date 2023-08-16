<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.actions.KmImissiveRegAction"%>
<%@page import="com.landray.kmss.common.actions.RequestContext"%>
<%@page import="net.sf.json.JSONObject"%>

<c:set var="fdModelId" value="${param.fdMainId}" scope="request"/>
<c:set var="fdModelName" value="${param.fdModelName}" scope="request"/>
<c:set var="formBeanName" value="${param.formBeanName}" scope="request"/>
<c:set var="fdMainId" value="${param.fdRegId}" scope="request"/>
<%
	new KmImissiveRegAction().listNote4m(null, null, request, response);
%>
<c:if test="${not empty auditNotes}">
<script>
	var LbpmAuditNoteList = ${auditNotes};
</script>
	<div id="auditNoteList">
		<c:forEach items="${auditNotes}" var="auditNote" varStatus="vstatus">
			<c:if test="${ auditNote.fdActionKey ne '_pocess_end' }">
			<%
				JSONObject auditNote = (JSONObject) pageContext.getAttribute("auditNote");
				System.out.print(auditNote);
			%>
			<c:if test="${auditNote.fdActionKey=='_concurrent_branch' }">
				<%
					if (auditNote.getBoolean("firstBlank")) {
				%>
				<div
					data-dojo-type="sys/lbpmservice/mobile/lbpm_audit_note/js/LbpmserviceAuditLabelItem"
					data-dojo-props="fdFactNodeName:'<bean:message bundle="sys-lbpmservice" key="mui.lbpmservice.flowchart.process.branch"/>',toggle:true,fdExecutionId:'${auditNote.fdParentExecutionId }'"></div>
				<%
					}
				%>
				<div
					data-dojo-type="sys/lbpmservice/mobile/lbpm_audit_note/js/LbpmserviceAuditBranchItem"
					data-dojo-props="store:LbpmAuditNoteList['${vstatus.index }']"></div>
			</c:if>
			<c:if test="${auditNote.fdActionKey!='_concurrent_branch' }">
				<%
					if (auditNote.getBoolean("firstNode")) {
				%>
					
					<div  class="muiLbpmserviceAuditSelArea muiLbpmserviceAuditLabelItem muiLbpmserviceAuditNormal" onclick="doCheckJb(this);">
						<c:choose>
							<c:when test="${param.showCheckBox ne 'false'}">
								<div class="muiLbpmserviceAuditLabelItemSel" data-value="${auditNote.fdId}">
									<i class="mui mui-checked muiCateSelected" style="display: none;"></i>
								</div>
							</c:when>
							<c:otherwise>
								<div class="muiLbpmserviceAuditLabelItemDot"><i class=""></i></div>
							</c:otherwise>
						</c:choose>
						<div class="muiLbpmserviceAuditLabelItemTitle">
							${auditNote.fdFactNodeName}
						</div>
					</div>
				
				<%
					}
				%>
				<div
					data-dojo-type="sys/lbpmservice/mobile/lbpm_audit_note/js/LbpmserviceAuditNodeItem"
					data-dojo-props="store:LbpmAuditNoteList['${vstatus.index }'],formBeanName:'${ formBeanName}'">
					<c:if test="${auditNote.fdIsHide eq '2'}">
						<c:forEach items="${auditNote.auditNoteListsJsps4Mobile}" var="auditNoteListsJsp" varStatus="vstatus">
							<c:import url="${auditNoteListsJsp}" charEncoding="UTF-8">
								<c:param name="auditNoteFdId" value="${auditNote.fdId}" />
								<c:param name="modelName" value="${auditNote.fdProcess.fdModelName}" />
								<c:param name="modelId" value="${auditNote.fdProcess.fdModelId}" />
								<c:param name="formName" value="${formBeanName}" />
							</c:import>
						</c:forEach>
						
						<c:import url="/sys/attachment/mobile/import/view.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="${ formBeanName}"></c:param>
							<c:param name="fdKey" value="${auditNote.fdId}"></c:param>
							<c:param name="fdViewType" value="simple"></c:param>
						</c:import>
					</c:if>
				</div>
			</c:if>
			</c:if>
		</c:forEach>
	</div>
	<c:if test="${param['docStatus']>='30' || param['docStatus']=='00'}">
		<script type="text/javascript">
			require(["dojo/ready","dojo/dom-style","dojo/dom"], function(ready,domStyle,dom) {
				ready(function(){
					var _Lbpm_SettingInfo = new KMSSData().AddBeanData("lbpmSettingInfoService").GetHashMapArray()[0]; //统一在此获取流程默认值与功能开关等配置	
					var isShow = true;
					if (typeof _Lbpm_SettingInfo != "undefined" && 
							_Lbpm_SettingInfo.isShowApprovalTime === "false"){
						isShow = false;
					}
					if (!isShow){
						var vEfficiencyWrap = dom.byId("efficiencyWrap");
						if (vEfficiencyWrap != null){
							domStyle.set(vEfficiencyWrap,"display","none");
						}
					}
				});
			});
		</script>
	</c:if>
</c:if>
