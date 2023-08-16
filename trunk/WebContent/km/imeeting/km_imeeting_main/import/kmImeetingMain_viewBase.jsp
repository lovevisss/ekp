<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingMainUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	String fdId = (String)request.getParameter("fdId");
	request.setAttribute("isCanLookFeedback", KmImeetingMainUtil.isCanLookFeedback(fdId));
%>

<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/view.css?s_cache=${MUI_Cache}" />
<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/attend.css?s_cache=${MUI_Cache}" />
<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/mainPrint.css?s_cache=${MUI_Cache}" />

<div class="lui_form_content_frame" > 
	<table class="tb_normal" width=100% id="Table_Main">
		<tr>
			<td colspan="4" id="docSubject" style="text-align:center">
				<div style="text-align:center;display: inline-block;">${kmImeetingMainForm.fdName}</div>
				<span id="docSubjectSpan">通知单</span>
			</td>
		</tr>
		<tr>
			<td colspan="4"  class="com_subject">
				<div style="margin-left:0px">
					<span style="margin-right:25px;font-weight: bold;">关联会议方案：${kmImeetingMainForm.fdSchemeName}</span>
				</div>
			</td>
		</tr>
		<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag eq 'true'}">
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingMain.changeMeetingReason"/>
				</td>
				<td colspan="3" width="85%" style="color: red;">
					<div style="width:95%;color:red;">${kmImeetingMainForm.changeMeetingReason}</div>
				</td>
			</tr>
		</c:if>
		<tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<bean:message key="kmImeetingMain.fdMeetingNum" bundle="km-imeeting" />
			</td>
			<td width="35%">
				${kmImeetingMainForm.fdMeetingNum}
			</td>
			<td class="td_normal_title" width="15%">
				<bean:message key="kmImeetingMain.fdDate" bundle="km-imeeting" />
			</td>
			<td width="35%" >
				${kmImeetingMainForm.fdHoldDate}
				<span style="position: relative;">~</span>
				${kmImeetingMainForm.fdFinishDate}
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNeedPlace" />
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdPlaceName}"></c:out>
				<c:if test="${not empty kmImeetingMainForm.fdPlaceName and not empty kmImeetingMainForm.fdOtherPlace}">
					<br>
				</c:if>
				<c:out value="${kmImeetingMainForm.fdOtherPlace}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
				报名截止时间
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdFeedBackDeadline}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHost"/>
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdHostName}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
				职务
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdPosition}"></c:out>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width="15%">
				会议发起人
			</td>
			<td width="35%" >
				<c:out value="${kmImeetingMainForm.docCreatorName}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
				发起人部门
			</td>
			<td width="35%" >
				<c:out value="${kmImeetingMainForm.fdCreatorDeptName}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				出席会议人员
			</td>
			<td width="85%" colspan="3" >
				<c:out value="${kmImeetingMainForm.fdAttendPersonNames}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				邀请参加人员
			</td>
			<td width="85%" colspan="3">
				<c:out value="${kmImeetingMainForm.fdInvitePersonNames}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				列席会议人员
			</td>
			<td width="85%" colspan="3">
				<c:out value="${kmImeetingMainForm.fdParticipantPersonNames}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<!-- 纪要人员 -->
				<bean:message key="kmImeetingMain.createStep.base.fdSummaryInputPerson" bundle="km-imeeting" />
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdSummaryInputPersonName}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
				会服人员
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdAssistPersonNames}"></c:out>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width="15%">
				<!-- 工作安排 -->
				<bean:message key="kmimeetingmain.workArrangement" bundle="km-imeeting" />
			</td>
			<td colspan="3" width="85%">
				<div><c:out value="${kmImeetingMainForm.workArrangement}"></c:out></div>
			</td>
		</tr>
	</table>
	
	<div class="lui_form_content_frame" style="margin-top:15px">
		<table class="tb_normal" width=100% id="Table_Main"> 
			<tr>
				<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
					<bean:message bundle="km-imeeting" key="kmImeetingMain.createStep.base.agenda"/>
				</td>
			</tr>
			<tr>
				<%--会议议题信息--%>
				<td colspan="4">
					<html:hidden property="fdIsTopic" value="1"/>
					<c:set var="isOnMainPage" value="true"></c:set>
					<%@include file="/km/imeeting/km_imeeting_agenda/kmImeetingAgenda_viewTopic_print.jsp"%>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 出席单位 -->
	<jsp:include page="/km/imeeting/import/kmImeeting_attendUnit.jsp">
		<jsp:param value="true" name="isPrint"/>
		<jsp:param value="${param.forIndex}" name="forIndex"/>
	</jsp:include>
	
	<div class="lui_form_content_frame" style="margin-top: 15px;">
		<table class="tb_normal" width=100% id="Table_Main"> 
			<tr>
				<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
					<c:out value="会议辅助资源"></c:out>
				</td>
			</tr>
			<tr>
	 		<%--会议室辅助设备--%>
	 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingEquipment.tip') }">
	 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingEquipment"/>
	 		</td>
	 		<td width="85%"  colspan="3">
	 			 <input type="hidden" name="kmImeetingEquipmentIds" value="${kmImeetingMainForm.kmImeetingEquipmentIds}"/>
	 			<c:out value="${kmImeetingMainForm.kmImeetingEquipmentNames}"></c:out>
			</td>
	 	</tr>
	 	<tr>
	 		<%--会议室辅助服务--%>
	 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingDevices.tip') }">
	 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
	 		</td>
	 		<td width="85%"  colspan="3" class="meeting-device-style">
	 			<c:out value="${kmImeetingMainForm.kmImeetingDeviceNames}"></c:out>
			</td>
	 	</tr>
		</table>
	</div>
	
	<div class="lui_form_content_frame" style="margin-top: 15px;">
		<table class="tb_normal" width=100% id="Table_Main"> 
			<tr>
				<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
					<c:out value="短信内容"></c:out>
				</td>
			</tr>
			<tr>
				<!-- 短息内容 -->
				<td class="td_normal_title" width="15%">
					<c:out value="短信内容"></c:out>
				</td>
				<td>
					<c:out value="${kmImeetingMainForm.fdSMSContent}"></c:out>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 变更记录 -->
	<div class="lui_form_content_frame">
		<ui:dataview>
			<ui:source type="AjaxJson">
				{url:'/km/imeeting/km_imeeting_main_history/kmImeetingMainHistory.do?method=getChangeHistorysByMeeting&meetingId=${JsParam.fdId }'}
			</ui:source>
			<ui:render type="Template">
				<c:import url="/km/imeeting/resource/tmpl/changeHistory.jsp" charEncoding="UTF-8"></c:import>
			</ui:render>
		</ui:dataview>
	</div>
</div>