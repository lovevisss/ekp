<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<c:choose>
	<c:when test="${param.fdTemplateId == null || param.fdTemplateId == ''}">
		<jsp:include page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_simple.jsp" />
	</c:when>
	<c:otherwise>
		<%--会议通知单--%>
		<c:if test="${param.type=='admin'  }">
			<%--管理员，可以看到通知单所有信息--%>
			<jsp:include page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_admin.jsp" />
		</c:if>
		<c:if test="${param.type=='attend' }">
			<%--会议主持人/参加人/列席人员看到的会议通知单--%>
			<jsp:include page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_attend.jsp"/>
		</c:if>
		<c:if test="${param.type=='assist' }">
			<%--会议协助人看到的会议通知单--%>
			<jsp:include page="/km/imeeting/km_imeeting_notify_letter/km_imeeting_notify_letter_assist.jsp" />
		</c:if>
	</c:otherwise>
</c:choose>