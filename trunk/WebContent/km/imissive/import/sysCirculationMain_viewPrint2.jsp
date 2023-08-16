<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.sys.circulation.actions.SysCirculationMainAction" %>
<%@ include file="/resource/jsp/common.jsp" %>
<c:set var="fdModelId" value="${requestScope[param.formName].fdId}" scope="request"/>
<c:set var="fdModelName" value="${requestScope[param.formName].modelClass.name}" scope="request"/>
<% new SysCirculationMainAction().listPrint(request, response);%>
<c:choose>
	<c:when test="${not empty queryList}">
		<table class="tb_normal" width="100%">
			<tr class="tr_normal">
				<td width="5%" class="td_normal_title">
					<bean:message key="page.serial"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-circulation" key="sysCirculationMain.fdCirculationTime"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-circulation" key="sysCirculationMain.fdExpireTime"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-circulation" key="sysCirculationMain.fdCirculatorId"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-circulation" key="table.sysCirculationCirculors"/>
				</td>
				<td width="15%" class="td_normal_title">
					<bean:message bundle="sys-circulation" key="sysCirculationMain.fdRemark"/>
				</td>
			</tr>
			<c:forEach items="${queryList}" var="sysCirculationMain" varStatus="vStatus">
				<tr>
					<td>
						<c:out value="${vStatus.count}"/>
					</td>
					<td>
						<kmss:showDate value="${sysCirculationMain.fdCirculationTime}" type="datetime"/>
					</td>
					<td>
						<kmss:showDate value="${sysCirculationMain.fdExpireTime}" type="datetime"/>
					</td>
					<td>
						<c:out value="${sysCirculationMain.fdCirculator.fdName}"/>
					</td>
					<td>
						<c:forEach
							items="${sysCirculationMain.receivedCirCulators}"
							var="receivedCirCulators"
							varStatus="vstatus">
							<c:out value="${receivedCirCulators.fdName}" />
							<c:if test="${fn:length(sysCirculationMain.receivedCirCulators)!=vstatus.count }">;</c:if>
						</c:forEach>
					</td>
					<td>
						<c:out value="${sysCirculationMain.fdRemark}"/>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
		<%@ include file="/resource/jsp/list_norecord_simple.jsp" %>
	</c:otherwise>
</c:choose>