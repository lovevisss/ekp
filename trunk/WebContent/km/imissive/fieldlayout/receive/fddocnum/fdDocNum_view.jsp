<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
	<c:if test="${not empty kmImissiveReceiveMainForm.fdDocNum}">
		<c:out value="${kmImissiveReceiveMainForm.fdDocNum}"/>
	</c:if>	
</span>