<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<script>Com_IncludeFile("data.js");</script>
<script>
	function confirmDelete(msg){
	var del = confirm('<bean:message key="page.comfirmDelete"/>');
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/imeeting/km_imeeting_template/kmImeetingTemplate.do?method=edit&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmImeetingTemplate.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/imeeting/km_imeeting_template/kmImeetingTemplate.do?method=delete&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmImeetingTemplate.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-imeeting" key="table.kmImeetingTemplate.card"/></p>

<center>
<table id="Label_Tabel" width=95%>
	<%--会务安排--%>
	<tr LKS_LabelName="<bean:message  bundle="km-imeeting" key="kmImeetingTemplate.infoTitle"/>">
		<td>
		<table class="tb_normal" width=100%>
			<tr>
				<%--模板名称--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdName"/>
				</td>
				<td width="85%" colspan="3">
					<xform:text property="fdName" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--类别--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docCategoryId"/>
				</td>
				<td colspan="3">
					<c:out value="${kmImeetingTemplateForm.docCategoryName}" />
				</td>
			</tr>
			<tr>
				<%--排序号--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdOrder"/>
				</td>
				<td width="85%" colspan="3">
					<xform:text property="fdOrder" style="width:100px" />
				</td>
			</tr>
			<tr>
				<%--是否可用 --%>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable" /></td>
				<td width="85%" colspan="3">
					<label class="weui_switch">
						<input type="checkbox" style="display:none;" ${'true' eq kmImeetingTemplateForm.fdIsAvailable ? 'checked' : '' } disabled />
						<span style="cursor:default;"></span>
						<small style="cursor:default;"></small>
						<span id="fdIsAvailableText"></span>
					</label>
					<script type="text/javascript">
						function setText(status) {
							if(status) {
								$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.true" />');
							} else {
								$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.false" />');
							}
						}
						setText(${kmImeetingTemplateForm.fdIsAvailable});
					</script>
				</td>
			</tr>
			<tr>
				<%--可使用者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authReaders"/>
				</td>
				<td width="85%" colspan="3">
					<xform:address textarea="true"  propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--可维护者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authEditors"/>
				</td>
				<td width="85%" colspan="3">
					<xform:address textarea="true"  propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:85%" />
				</td>
			</tr>
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                <c:param name="id" value="${kmImeetingTemplateForm.authAreaId}"/>
            </c:import>	
			<tr><td colspan="4">&nbsp;</td></tr>
			<tr>
				<%--会议主题--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docSubject"/>
				</td>
				<td width="85%" colspan="3">
					<xform:text property="docSubject" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--纪要录入人--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryInputPerson"/>
				</td>
				<td width="85%" colspan="3">
					<xform:address propertyId="fdSummaryInputPersonId" propertyName="fdSummaryInputPersonName" orgType="ORG_TYPE_PERSON" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--创建者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docCreatorId"/>
				</td>
				<td width="35%">
					<c:out value="${kmImeetingTemplateForm.docCreatorName }" />
				</td>
				<%--创建时间--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docCreateTime"/>
				</td>
				<td width="35%">
					<c:out value="${kmImeetingTemplateForm.docCreateTime }" />
				</td>
			</tr>
			<tr>
				<%--修改者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docAlterId"/>
				</td>
				<td width="35%">
					<c:out value="${kmImeetingTemplateForm.docAlterorName }" />
				</td>
				<%--修改时间--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docAlterTime"/>
				</td>
				<td width="35%">
					<c:out value="${kmImeetingTemplateForm.docAlterTime }" />
				</td>
			</tr>
			<%-- <kmss:ifModuleExist path="/km/vote">
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeeting.relate.voteTemplate"/>
					</td>
					<td width="85%" colspan="3">
						<c:import url="/km/vote/import/kmVoteCategory_view.jsp">
							<c:param name="formName" value="kmImeetingTemplateForm"></c:param>
						</c:import>
					</td>
				</tr>
			</kmss:ifModuleExist> --%>
		</table>
		</td>
	</tr>
	<%-- 会议主文档--%>
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingTemplateForm" />
		<c:param name="fdKey" value="ImeetingMain" />
		<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.mainflow" />
	</c:import>
	<c:if test="${imissiveSummaryEnable != 'true'}">
		<%-- 纪要模板--%>	
		<tr LKS_LabelName="<bean:message  bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryContent"/>">
			<td>
			<table class="tb_normal" width=100%>
				<!-- 启用电子盖章 -->
				<kmss:ifModuleExist path="/elec/yqqs">
				 	<tr>
				 		<td class="td_normal_title" width=15%>
				 			<bean:message bundle="km-imeeting" key="KmImeetingTemplate.fdSignEnable"/>
				 		</td>
				 		<td colspan="3" >
							<ui:switch property="fdSignEnable" showType="show" checked="${kmImeetingTemplateForm.fdSignEnable}"  checkVal="true" unCheckVal="false"/>
						</td>
				 	</tr>
			 	</kmss:ifModuleExist>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imeeting" key="kmImeetingTemplate.fdSummaryContent"/>
					</td>
					<td colspan="3">
						<xform:rtf property="fdSummaryContent"></xform:rtf>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<%-- 纪要流程--%>	
		<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTemplateForm" />
			<c:param name="fdKey" value="ImeetingSummary" />
			<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.summaryTemplate" />
		</c:import>
	</c:if>
	<!--发布机制-->
	<c:import url="/sys/news/include/sysNewsPublishCategory_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingTemplateForm" />
		<c:param name="fdKey" value="ImeetingMain" />
	</c:import>
	<%-- 权限--%>	
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import  url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTemplateForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingTemplateForm" />
	    <c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
	 </c:import>
	 <!--日程机制(普通模块) 开始-->
	<tr LKS_LabelName="<bean:message bundle="sys-agenda" key="module.sys.agenda.syn" />">
	  <td>
		  <table class="tb_normal" width=100%>
		  	<tr>
				<td class="td_normal_title" width=15%>
			       <bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
				</td>
			    <td>
			    	<xform:radio property="syncDataToCalendarTime" >
						<xform:enumsDataSource enumsType="kmImeetingMain_syncDataToCalendarTime" />
					</xform:radio>
			    </td>
			</tr>
			<tr>
				<td colspan="4" style="padding: 0px;">
					 <c:import url="/sys/agenda/include/sysAgendaCategory_general_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingTemplateForm" />
						<c:param name="fdKey" value="ImeetingMain" />
						<c:param name="fdPrefix" value="sysAgendaCategory_formula_view" />
						<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
						<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
						<c:param name="noSyncTimeValues" value="noSync" />
					</c:import>
				</td>
			</tr>
		  </table>
	  </td>
	</tr>
	<!--日程机制(普通模块)  结束-->
	<c:if test="${imissiveSummaryEnable != 'true'}">
		<!-- 沉淀设置 -->
		<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTemplateForm" />
			<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
			<c:param name="templateService" value="kmImeetingTemplateService" />
		</c:import>
	</c:if>
	
	<c:choose>
		<c:when test="${imissiveSummaryEnable == 'true'}">
			<!-- 规则机制 -->
			<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingTemplateForm" />
				<c:param name="fdKey" value="ImeetingMain" />
				<c:param name="messageKey" value="会议流程规则设置" />
				<c:param name="templateModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"></c:param>
			</c:import>
		</c:when>
		<c:otherwise>
			<!-- 规则机制 -->
			<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingTemplateForm" />
				<c:param name="fdKey" value="ImeetingMain;ImeetingSummary" />
				<c:param name="messageKey" value="会议流程规则设置;纪要流程规则设置" />
				<c:param name="templateModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>