<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.sys.news.actions.SysNewsMainAction" %>
<%@ include file="/resource/jsp/common.jsp" %>
<c:set var="fdModelId" value="${requestScope[param.formName].fdId}" scope="request"/>
<c:set var="fdModelName" value="${requestScope[param.formName].modelClass.name}" scope="request"/>
<% new SysNewsMainAction().viewAllPublishPrint(request, response);%>
<c:choose>
	<c:when test="${not empty listPublishRecord}">
		<table class="tb_normal" width="100%">
			<tr class="tr_normal">
				<td width="5%" class="td_normal_title">
					<bean:message key="page.serial"/>
				</td>
				<td width="25%" class="td_normal_title">
					<bean:message bundle="sys-news" key="sysNewsPublishMain.submitor"/>
				</td>
				<td width="30%" class="td_normal_title">
					<bean:message bundle="sys-news" key="sysNewsPublishMain.subTime"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-news" key="sysNewsPublishMain.fdCayegoryName"/>
				</td>
				<td width="20%" class="td_normal_title">
					<bean:message bundle="sys-news" key="sysNewsPublishMain.docStatus"/>
				</td>
			</tr>
			<c:forEach items="${listPublishRecord}" var="sysNewsMain" varStatus="vStatus">
				<tr>
					<td>
						<c:out value="${vStatus.count}"/>
					</td>
					<td>
						<c:out value="${sysNewsMain.docCreator.fdName}"/>
					</td>
					<td>
						<kmss:showDate value="${sysNewsMain.docCreateTime}" type="datetime"/>
					</td>
					<td>
						<c:out value="${sysNewsMain.fdTemplate.fdName}"/>
					</td>
					<td>
						<sunbor:enumsShow value="${sysNewsMain.docStatus}" enumsType="kmImissive_common_status" />
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
		<%@ include file="/resource/jsp/list_norecord_simple.jsp" %>
	</c:otherwise>
</c:choose>