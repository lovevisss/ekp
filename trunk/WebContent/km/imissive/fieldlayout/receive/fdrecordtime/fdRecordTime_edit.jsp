<%-- 登记时间 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span  class="xform_fieldlayout" style="<%=parse.getStyle()%>">
<c:out value="${kmImissiveReceiveMainForm.fdRecordTime}"/>
</span>