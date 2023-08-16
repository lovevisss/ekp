<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<list:data>
	<list:data-columns var="boenSignInRecords" list="${queryPage.list}">
		<list:data-column col="userName" title="参会人姓名">
			<c:out value="${boenSignInRecords.userName}"></c:out>
		</list:data-column>
		<list:data-column col="orgName" title="单位/部门">
			<c:out value="${boenSignInRecords.orgName}"></c:out>
		</list:data-column>
		<list:data-column col="signIn" title="是否签到">
			<c:choose>
				<c:when test="${boenSignInRecords.signIn eq 'false'}">
					<c:out value="否"></c:out>
				</c:when>
				<c:otherwise>
					<c:out value="是"></c:out>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column col="signTime" title="签到时间">
			<c:out value="${boenSignInRecords.signTime}"></c:out>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno}"
		pageSize="${queryPage.rowsize}" totalSize="${queryPage.totalrows}" >
	</list:data-paging>
</list:data>