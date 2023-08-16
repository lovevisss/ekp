<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>

<template:replace name="head">
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/view.css?s_cache=${MUI_Cache}" />
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/attend.css?s_cache=${MUI_Cache}" />
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/edit_simple.css" />
	<style>
		.meeting_cyclicity{
			top:-20px
		}
	</style>
</template:replace>
<template:replace name="title">
	<c:out value="${ kmImeetingMainForm.fdName} - ${ lfn:message('km-imeeting:table.kmImeetingMain') }"></c:out>
</template:replace>
<%--操作栏--%>
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
		<c:if test="${kmImeetingMainForm.docStatusFirstDigit=='3'}">
		
		<%-- 坐席安排，条件：1、已发送会议通知，2、会议未开始 --%>
		<c:if test="${(kmImeetingMainForm.fdNeedPlace eq 'true' or not empty kmImeetingMainForm.fdPlaceId or not empty kmImeetingMainForm.fdOtherPlace) && not empty kmImeetingMainForm.fdTemplateId}">
			<c:choose>
				<c:when test="${kmImeetingMainForm.fdIsSeatPlan == 'true' }">
					<ui:button  order="1" text="${ lfn:message('km-imeeting:kmImeetingMain.viewAgent') }"  onclick="viewSeatPlan();">
					</ui:button>
				</c:when>
				<c:otherwise>
					<c:if test="${isBegin==false}">
						<kmss:auth
							requestURL="/km/imeeting/km_imeeting_seat_plan/kmImeetingSeatPlan.do?method=add&fdImeetingMainId=${JsParam.fdId}" requestMethod="GET">
							<ui:button order="1" text="${ lfn:message('km-imeeting:kmImeetingMain.seatArr') }"  onclick="addSeatPlan();">
							</ui:button>
						</kmss:auth>
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:if>
		<%-- 
		<c:if test="${isBegin==false and kmImeetingMainForm.fdIsVideo eq 'true' and empty roomId}">
			<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=addSyncToKk&fdId=${JsParam.fdId}" requestMethod="GET">
				<ui:button  order="1" text="同步到kk"  onclick="syncVedioMeeting();">
				</ui:button>
			</kmss:auth>
		</c:if>	
		--%>
		<%-- 会议提前结束，条件：1、已发送会议通知 2、正在召开的会议 --%>
		<%-- <c:if test="${isBegin==true && isEnd==false}">
			<kmss:auth
				requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=earlyEndMeeting&fdId=${JsParam.fdId}"
				requestMethod="GET">
				<ui:button order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.earlyEnd') }" 
					onclick="earlyEndMeeting();">
				</ui:button>
			</kmss:auth>
		</c:if> --%>
		<%-- 会议变更，条件：1、已发送会议通知 2、未录入纪要 3、会议未开始 --%>
		<c:if test="${kmImeetingMainForm.fdSummaryFlag=='false' && isBegin==false}">
			<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeMeeting&fdId=${JsParam.fdId}" requestMethod="GET">
				<ui:button order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.change') }" onclick="updateChange();">
				</ui:button>
			</kmss:auth>
		</c:if>
		<%-- 取消会议，条件：1、已发送会议通知，2、会议未开始 --%>
		<c:if test="${isBegin==false}">
			<kmss:auth
				requestURL="/km/imeeting/km_imeeting_main/kmImeetingMainCancel.do?method=cancelMeeting&fdId=${JsParam.fdId}" requestMethod="GET">
				<ui:button id="cancelbtn" order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.cancel') }"  onclick="showCancelMeeting();">
				</ui:button>
			</kmss:auth>
		</c:if>
		<c:if test="${isEnd==false && kmImeetingMainForm.isBegin != 'true' && isBoenBtn eq 'true'}">
			<%if(KmImeetingConfigUtil.isBoenEnable()){ %>
				<c:if test="${fdIsSyncBoen eq true}">
					<ui:button  order="1" text="${lfn:message('km-imeeting:kmImeeting.btn.begin') }"  onclick="beginMeeting();"></ui:button>
				</c:if>
			<%} %>
		</c:if>
		<c:if test="${isEnd==true}">
			<%if(KmImeetingConfigUtil.isBoenEnable()){ %>
				<c:if test="${canBegin || isAdmin}">
					<ui:button  order="1" text="获取会议批注"  onclick="getMeetingAtt();">
					</ui:button>
				</c:if>
			<%} %>
		</c:if>
		<c:if test="${not empty kmImeetingMainForm.fdTemplateId}">
			<c:choose>
				<c:when test="${imissiveSummaryEnable == 'true' }">
					<%-- 会议纪要，条件：1、已发送会议通知 2、录入人才可录入 --%>
					<c:if test="${kmImeetingMainForm.fdSummaryFlag=='false'}">
						<kmss:authShow extendOrgIds="${kmImeetingMainForm.fdSummaryInputPersonId};${kmImeetingMainForm.docCreatorId}" roles="SYSROLE_ADMIN">
							<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
								<ui:button  order="1" text="${lfn:message('km-imeeting:kmImeeting.btn.addSummary') }"  onclick="addSummary();"></ui:button>
							</kmss:authShow>
						</kmss:authShow>
					</c:if>
					
				</c:when>
				<c:otherwise>
					<%-- 会议纪要，条件：1、已发送会议通知 2、录入人才可录入 --%>
					<c:if test="${kmImeetingMainForm.fdSummaryFlag=='false'}">
						<kmss:authShow extendOrgIds="${kmImeetingMainForm.fdSummaryInputPersonId};${kmImeetingMainForm.docCreatorId}" roles="SYSROLE_ADMIN,ROLE_KMIMEETING_SUMMARY_CREATE_WITHMEETING">
							<kmss:auth
								requestURL="/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=operateSummary&meetingId=${JsParam.fdId}"
								requestMethod="GET">
								<ui:button order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.addSummary') }" 
									onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=operateSummary&meetingId=${JsParam.fdId}','_blank');">
							    </ui:button>
							</kmss:auth>
						</kmss:authShow>
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${not empty summaryType && summaryType eq 'imeeting'}">
					<%-- 会议纪要(会议纪要创建后，所有可阅读者可见) --%>
					<c:if test="${kmImeetingMainForm.fdSummaryFlag=='true' and not empty summaryId}">
						<kmss:auth
							requestURL="/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=${summaryId}"
							requestMethod="GET">
							<ui:button order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.viewSummary') }" 
									onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=${summaryId}','_blank');">
							</ui:button>
						</kmss:auth>
					</c:if>
				</c:when>
				<c:when test="${not empty summaryType && summaryType eq 'imissive'}">
					<%-- 会议纪要(会议纪要创建后，所有可阅读者可见) --%>
					<c:if test="${kmImeetingMainForm.fdSummaryFlag=='true' and not empty summaryId}">
						<kmss:auth
							requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${summaryId}"
							requestMethod="GET">
							<ui:button order="4" text="${lfn:message('km-imeeting:kmImeeting.btn.viewSummary') }" 
									onclick="Com_OpenWindow('${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${summaryId}','_blank');">
							</ui:button>
						</kmss:auth>
					</c:if>
				</c:when>
			</c:choose>
		</c:if>
		
		</c:if>
		 <%-- 编辑文档 --%> 
		<c:if test="${kmImeetingMainForm.docStatus!='00' && kmImeetingMainForm.docStatus!='30'&& kmImeetingMainForm.docStatus!='41'}">
			 <kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=edit&fdId=${JsParam.fdId}" requestMethod="GET">
				     <ui:button order="3" text="${ lfn:message('button.edit') }"  onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=edit&fdId=${JsParam.fdId}','_self');">
					 </ui:button>
			</kmss:auth>
		</c:if>
		<!--打印 -->
		<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=print&fdId=${param.fdId}" requestMethod="GET">
		    <ui:button text="${ lfn:message('button.print') }"  onclick="Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=print&fdId=${param.fdId}','_blank');">
			</ui:button>
		</kmss:auth>
		<%-- 删除文档 --%>
		<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=delete&fdId=${JsParam.fdId}" requestMethod="GET">
			<ui:button order="4" text="${ lfn:message('button.delete') }"  onclick="Delete();"></ui:button>
		</kmss:auth>
		
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()"></ui:button>
	</ui:toolbar>
</template:replace>
<%--路径--%>
<template:replace name="path">
	<ui:combin ref="menu.path.category">
		<ui:varParams moduleTitle="${ lfn:message('km-imeeting:module.km.imeeting') }"
		    modulePath="/km/imeeting/"
			modelName="com.landray.kmss.km.imeeting.model.KmImeetingTemplate"
		    autoFetch="false" 
		    extHash="j_path=/kmImeeting_fixed&except=docStatus:00&cri.q=fdTemplate:!{value}"
		    href="/km/imeeting/"
			categoryId="${kmImeetingMainForm.fdTemplateId}" />
	</ui:combin>
</template:replace>
