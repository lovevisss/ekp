<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>

<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<%@include file="/km/imeeting/mobile/scheme/agenda_viewTopic.jsp"%>
	</c:when>
	<c:otherwise>
		<%@include file="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_viewTopic.jsp"%>
	</c:otherwise>
</c:choose>


