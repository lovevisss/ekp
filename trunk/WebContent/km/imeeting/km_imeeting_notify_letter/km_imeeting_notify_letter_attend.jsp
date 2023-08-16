<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KKUtil"%>
<%--管理员、会议审批人员看到的会议通知单详情--%>
<div style="float: right;margin:10px;">
	<span style="margin-right: 10px;">
		<bean:message bundle="km-imeeting" key="kmImeetingMain.fdMeetingNum"/>：
		<c:out value="${kmImeetingMainForm.fdMeetingNum}"></c:out>
		<c:if test="${empty  kmImeetingMainForm.fdMeetingNum}">
			<bean:message bundle="km-imeeting" key="kmImeetingMain.createStep.base.fdMeetingNum.tip"/>
		</c:if>
	</span>
	<span>
		<bean:message bundle="km-imeeting" key="kmImeetingMain.docStatus"/>：
		<c:if test="${kmImeetingMainForm.docStatus!='30' && kmImeetingMainForm.docStatus!='41' }">
			<sunbor:enumsShow value="${kmImeetingMainForm.docStatus}" enumsType="kmImeeting_common_status" />
		</c:if>
		<%--未召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isBegin==false }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.unHold"/>
		</c:if>
		<%--正在召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isBegin==true && isEnd==false }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.holding"/>
		</c:if>
		<%--已召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isEnd==true }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.hold"/>
		</c:if>
		<%--已取消--%>
		<c:if test="${kmImeetingMainForm.docStatus=='41' }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.cancel"/>
		</c:if>
	</span>
</div>

<div class="lui_form_content_frame" style="padding-top:20px"> 
	<table class="tb_normal" width=100% id="Table_Main">
		<tr>
			<td colspan="4" id="docSubject" style="text-align:center">
				<c:out value="${kmImeetingMainForm.fdName}"></c:out>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<div style="margin-left:0px">
					<span class="com_subject" style="font-size: 110%;font-weight: bold;">关联会议方案：</span>
					<a href="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${kmImeetingMainForm.fdSchemeId}" target="_blank" style="color: #4285f4;">${fdSchemeName}</a>
				</div>
			</td>
		</tr>
		<c:if test="${not empty kmImeetingMainForm.changeMeetingReason}">
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingMain.changeMeetingReason"/>
				</td>
				<td colspan="3">
					<c:out value="${kmImeetingMainForm.changeMeetingReason}"></c:out>
				</td>
			</tr>
		</c:if>
		<tr >
			<td class="td_normal_title" width="15%">
				<bean:message key="kmImeetingMain.fdMeetingNum" bundle="km-imeeting" />
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdMeetingNum}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
				<bean:message key="kmImeetingMain.fdDate" bundle="km-imeeting" />
			</td>
			<td width="35%" >
				<c:out value="${kmImeetingMainForm.fdHoldDate}"></c:out>
				<span style="position: relative;top:-5px;">~</span>
				<c:out value="${kmImeetingMainForm.fdFinishDate}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNeedPlace" />
			</td>
			<td width="35%">
				<c:choose>
					<c:when test="${fdNeedMultiRes}">
					</c:when>
					<c:otherwise>
						<c:out value="${kmImeetingMainForm.fdPlaceName}"></c:out>
						<input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
								subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }"/>
						&nbsp;	&nbsp;
			 			<c:set var="hasSysAttend" value="false"></c:set>
						<kmss:ifModuleExist path="/sys/attend">
							<c:set var="hasSysAttend" value="true"></c:set>
						</kmss:ifModuleExist>
						<c:if test="${hasSysAttend == true }">
							<c:out value="${kmImeetingMainForm.fdOtherPlace}"></c:out>
							<%-- <c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
								<c:param name="propertyName" value="fdOtherPlace"></c:param>
								<c:param name="propertyCoordinate" value="fdOtherPlaceCoordinate"></c:param>
								<c:param name="validators" value="validateplace"></c:param>
								<c:param name="placeholder" value="km-imeeting:kmImeetingMain.fdOtherPlace"></c:param>
								<c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdPlace')}"></c:param>
								<c:param name="style" value="width:46%;"></c:param>
								<c:param name="showStatus" value="view"></c:param>
							</c:import> --%>
						</c:if>
						<c:if test="${hasSysAttend == false }">
							<c:out value="${kmImeetingMainForm.fdOtherPlace}"></c:out>
							<xform:text property="fdOtherPlace" style="width:46%;" showStatus="view" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherPlace') }'"></xform:text>
						</c:if>
						<div class="roomDetail" style="display: none;margin: 5px 0;padding: 5px;background-color: #fff5d8;border: 1px solid #e0a385;"></div>
					</c:otherwise>
				</c:choose>
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
				<%-- <xform:staffingLevel propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" style="width:95%;"></xform:staffingLevel> --%>
				<c:out value="${kmImeetingMainForm.fdPosition}"></c:out>
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
			<td width="35%" >
				<c:out value="${kmImeetingMainForm.fdSummaryInputPersonName}"></c:out>
			</td>
			<td class="td_normal_title" width="15%">
					会服人员
			</td>
			<td width="35%">
				<c:out value="${kmImeetingMainForm.fdAssistPersonNames}"></c:out>
			</td>
		</tr>
		<tr >
			<td class="td_normal_title" width="15%">
				<!-- 工作安排 -->
				工作安排
			</td>
			<td width="85%" colspan="3">
				<c:out value="${kmImeetingMainForm.workArrangement}"></c:out>
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
					<%@include file="/km/imeeting/km_imeeting_agenda/kmImeetingAgenda_viewTopic.jsp"%>
				</td>
			</tr>
		</table>
	</div>
			
	<!-- 出席单位 -->
	<%@include file="/km/imeeting/import/kmImeeting_attendUnit.jsp"%>
</div> 
