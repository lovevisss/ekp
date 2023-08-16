<%-- 文档状态 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
<sunbor:enumsShow value="${kmImissiveSignMainForm.docStatus}" enumsType="kmImissive_common_status" />
</span>
