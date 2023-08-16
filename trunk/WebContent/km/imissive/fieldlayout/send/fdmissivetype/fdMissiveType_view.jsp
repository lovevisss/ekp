<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
		<c:if test="${empty kmImissiveSendMainForm.fdMissiveType or kmImissiveSendMainForm.fdMissiveType eq '0'}"><bean:message  bundle="km-imissive" key="missiveType.unlimited"/></c:if>
		<c:if test="${kmImissiveSendMainForm.fdMissiveType eq '1'}"><bean:message  bundle="km-imissive" key="missiveType.distribute"/></c:if>
		<c:if test="${kmImissiveSendMainForm.fdMissiveType eq '2'}"><bean:message  bundle="km-imissive" key="missiveType.report"/></c:if>
</span>
