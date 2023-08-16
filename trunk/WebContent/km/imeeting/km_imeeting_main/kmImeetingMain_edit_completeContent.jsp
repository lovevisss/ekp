<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import=" com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="java.util.Map"%>	

	
	<!-- 会中设置 -->
	<c:if test="${_isBoenEnable}">
		<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_inMeetingConfigE.jsp">
			<c:param name="_isBoenEnable" value="${_isBoenEnable}" />
		</c:import>
	</c:if>
	<%--权限机制 --%>
	<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingMainForm" />
		<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
	</c:import>
	<%-- 发布机制隐藏页面 --%>
	<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingMainForm" />
			<c:param name="fdKey" value="ImeetingMain" />
			<c:param name="isShow" value="false" />
		</c:import>
	<%-- 流程 --%>
	<c:if test="${param.approveModel ne 'right'}">
		<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingMainForm" />
			<c:param name="fdKey" value="ImeetingMain" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
		</c:import>
	</c:if>
	<c:if test="${param.approveModel eq 'right'}">
	<%--流程--%>
		<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingMainForm" />
			<c:param name="fdKey" value="ImeetingMain" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
			<c:param name="approveType" value="right" />
		</c:import>
	</c:if>	
<%-- 日程同步 --%>
<c:set var="sysAgendaMainForm" value="${requestScope['kmImeetingMainForm']}" />
<c:if test="${sysAgendaMainForm.syncDataToCalendarTime eq 'feedbackEnd'||sysAgendaMainForm.syncDataToCalendarTime eq 'personAttend'}">
		<ui:content title="${ lfn:message('sys-agenda:module.sys.agenda.syn') }">
			<table class="tb_normal" width=100%>
				<tr>
				   <td width="15%"  class="tb_normal">
				   		<%--同步时机--%>
				       	<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
				   </td>
				   <td width="85%" colspan="3">
				      	<xform:radio property="syncDataToCalendarTime" showStatus="edit">
		       				<xform:enumsDataSource enumsType="kmImeetingMain_syncDataToCalendarTime" />
						</xform:radio>
						<br>
						<font color="red"><bean:message bundle="km-imeeting" key="kmImeetingMain.agenda.syn.tip"/></font>
				   </td>
				</tr>
				<tr>
					<td colspan="4" style="padding: 0px;">
						<c:import url="/sys/agenda/import/sysAgendaMain_general_edit.jsp"	charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingMainForm" />
							<c:param name="fdKey" value="ImeetingMain" />
							<c:param name="fdPrefix" value="sysAgendaMain_formula_edit" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
							<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
							<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
							<c:param name="noSyncTimeValues" value="noSync" />
						</c:import>
					</td>
				</tr>
			</table>
		</ui:content>
</c:if>
		
