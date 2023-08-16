<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="基本信息" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width="100%" >
		<!--方案名称-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingScheme.docSubject"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.docSubject}"></c:out>
			</td>
		</tr>
		<!--方案开始时间-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingScheme.fdBeginDate"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.fdBeginDate}"></c:out>
			</td>
		</tr>
		<!--方案结束时间-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingScheme.fdEndDate"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.fdEndDate}"></c:out>
			</td>
		</tr>
		<!--主持人-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdHost"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.fdHostName}"></c:out>
			</td>
		</tr>
		<!--职务-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingScheme.fdPost"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.fdStaffingLevel}"></c:out>
			</td>
		</tr>
		<!--会议地点-->
		<tr>
			<td width=30% class="tr_normal_title">
				<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlace"/>
			</td>
			<td>
				<c:out value="${kmImeetingSchemeForm.fdSchemePlace}"></c:out>
			</td>
		</tr>
		
		<%-- 所属场所 --%>
		<%-- <c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
               <c:param name="id" value="${kmImeetingSchemeForm.authAreaId}"/>
               <c:param name="rightModel" value="true"/>
         </c:import> --%> 
	</table>
</ui:content>