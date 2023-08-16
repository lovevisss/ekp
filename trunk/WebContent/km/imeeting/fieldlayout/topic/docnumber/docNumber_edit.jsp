<%-- 议题名称 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<span style="float: right;margin-right: 1.2rem;">
			<c:out value="${lfn:message('km-imeeting:kmImeetingTopic.docNumber.edit')}"></c:out>
		</span>
	</c:when>
	<c:otherwise>
		<c:out value="${lfn:message('km-imeeting:kmImeetingTopic.docNumber.edit')}"></c:out>
	</c:otherwise>
</c:choose>
