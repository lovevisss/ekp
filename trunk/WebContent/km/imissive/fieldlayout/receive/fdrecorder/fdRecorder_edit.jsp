<%-- 登记人 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span  class="xform_fieldlayout" style="<%=parse.getStyle()%>">
${kmImissiveReceiveMainForm.fdRecorderName}
</span>