<%@ page import="com.landray.kmss.sys.authorization.util.TripartiteAdminUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<%
		request.setAttribute("boenUrl", KmImeetingConfigUtil.getBoenUrl());
		request.setAttribute("unitAdmin", KmImeetingConfigUtil.getUnitAdmin());
	%>
	
    <%--签到页签，管理员、参与人、抄送人可见--%>
	<c:if test="${kmImeetingMainForm.docStatus!='10' and (type=='admin' or type=='attend' or type=='cc')}">
		<c:if test="${kmImeetingMainForm.docStatus ne '20' }">
			<%if(KmImeetingConfigUtil.isBoenEnable()){ %>
				<ui:content title="${ lfn:message('sys-attend:sysAttendCategory.importView.signDetail') }" cfg-order="2">
					<ui:iframe src="${boenUrl}/checkStatistics.html?userId=${unitAdmin}">
					</ui:iframe>
				</ui:content>
		  	<%}else{ %>
				<%-- 签到 --%>
				<% if(!TripartiteAdminUtil.IS_ENABLED_TRIPARTITE_ADMIN) { // 开启三员后不能使用 %>
				<kmss:ifModuleExist path="/sys/attend/">
					<c:set var="isShowBtn" value="false"></c:set>
					<c:set var="isExpandTab" value="false"></c:set>
					<kmss:auth
						requestURL="/sys/attend/sys_attend_category/sysAttendCategory.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&fdModelId=${kmImeetingMainForm.fdId}" requestMethod="GET">
						<c:if test="${kmImeetingMainForm.docStatus=='30' && isEnd==false }">
							<c:set var="isShowBtn" value="true"></c:set>
						</c:if>
					</kmss:auth>
					<c:if test="${HtmlParam.showtab=='attend'}">
						<c:set var="isExpandTab" value="true"></c:set>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatusFirstDigit=='3'}">
					<c:import url="/sys/attend/import/view.jsp" charEncoding="UTF-8">
						<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"></c:param>
						<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}"></c:param>
						<c:param name="isShowBtn" value="${isShowBtn}"></c:param>
						<c:param name="isExpandTab" value="${isExpandTab}"></c:param>
						<c:param name="expandCateId" value="${HtmlParam.expandCateId}"></c:param>
						<c:param name="order" value="2"></c:param>
					</c:import>
					</c:if>
				</kmss:ifModuleExist>
				<% } %>
			<% } %>
		</c:if>
	</c:if>
	
	<!-- 投票 -->
	<c:if test="${kmImeetingMainForm.docStatusFirstDigit=='3'}">
	<%if(KmImeetingConfigUtil.isBoenEnable()){ %>
		<c:if test="${canBallot || isAdmin}">
			<c:if test="${kmImeetingMainForm.fdVoteEnable == 'true' }">
				<ui:content title="${lfn:message('km-imeeting:kmImeetingVote.tab')}" cfg-order="3">
					<ui:iframe src="${LUI_ContextPath}/km/imeeting/km_imeeting_main/import/kmImeeting_vote.jsp?fdId=${kmImeetingMainForm.fdId}"></ui:iframe>
				</ui:content>
			</c:if>
			<c:if test="${kmImeetingMainForm.fdBallotEnable == 'true' && not empty kmImeetingMainForm.kmImeetingAgendaForms}">
				<ui:content title="${lfn:message('km-imeeting:kmImeetingAgenda.tab')}" cfg-order="3">
					<ui:iframe src="${LUI_ContextPath}/km/imeeting/km_imeeting_main/import/kmImeeting_ballot.jsp?fdId=${kmImeetingMainForm.fdId}"></ui:iframe>
				</ui:content>
			</c:if>
		</c:if>
		<c:if test="${canControl || isAdmin}">
			<c:import url="/km/imeeting/km_imeeting_main/import/kmImeeting_control.jsp" charEncoding="UTF-8">
	       		<c:param name="order" value="3"/>
	       	</c:import>
		</c:if>
	<%}else{ %>
		<kmss:ifModuleExist path="/km/vote">
			<c:import url="/km/vote/import/kmVoteMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
				<c:param name="order" value="3"/>
			</c:import>
		</kmss:ifModuleExist>
	<%} %>
	</c:if>
	
	<%-- 权限 --%>
	<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingMainForm" />
		<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
		<c:param name="order" value="7"/>
	</c:import>