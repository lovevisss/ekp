<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="_status" value="${JsParam.status}" scope="page" />
<c:set var="isBegin" value="${JsParam.isBegin}"/>
<c:set var="isEnd" value="${JsParam.isEnd}"/>
<%--废弃 --%>
<c:if test="${_status =='00' }">
	<div class="kmImeetingIndexItemTag muiMeetingDiscard"><bean:message key="status.discard"/></div>
</c:if>
<%--草稿 --%>
<c:if test="${_status =='10' }">
	<div class="kmImeetingIndexItemTag muiMeetingDraft"><bean:message key="status.draft"/></div>
</c:if>
<%--驳回 --%>
<c:if test="${_status =='11' }">
	<div class="kmImeetingIndexItemTag muiMeetingRefuse"><bean:message bundle="km-imeeting" key="kmImeeting.status.refuse"/></div>
</c:if>
<%--待审 --%>
<c:if test="${_status =='20' }">
	<div class="kmImeetingIndexItemTag muiMeetingExamine"><bean:message key="kmImeeting.status.append" bundle="km-imeeting"/></div>
</c:if>
<%--未召开--%>
<c:if test="${_status=='30' && isBegin==false }">
	<div class="kmImeetingIndexItemTag muiMeetingUnhold"><bean:message bundle="km-imeeting" key="kmImeeting.status.publish.unHold"/></div>
</c:if>
<%--正在召开--%>
<c:if test="${_status=='30' && isBegin==true && isEnd==false }">
	<div class="kmImeetingIndexItemTag muiMeetingHolding"><bean:message bundle="km-imeeting" key="kmImeeting.status.publish.holding"/></div>
</c:if>
<%--已召开--%>
<c:if test="${_status=='30' && isEnd==true }">
	<div class="kmImeetingIndexItemTag muiMeetingHold"><bean:message bundle="km-imeeting" key="kmImeeting.status.publish.hold"/></div>
</c:if>
<%--已取消--%>
<c:if test="${_status=='41' }">
	<div class="kmImeetingIndexItemTag muiMeetingCancel"><bean:message bundle="km-imeeting" key="kmImeeting.status.cancel"/></div>
</c:if>

