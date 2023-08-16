<%-- 拟稿日期 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%"); %>
<div id="_fdPrintTime" xform_type="datetime">
<xform:datetime property="fdPrintTime"
				required="<%=required %>"
                showStatus="edit" 
                dateTimeType="date" 
                mobile="${param.mobile eq 'true'? 'true':'false'}"
                subject="${lfn:message('km-imissive:kmImissiveSendMain.fdPrintTime')}"
                style="<%=parse.getStyle()%>"/>	
</div>