<%-- 收文日期 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%"); %>
<div id="_fdReceiveTime" xform_type="datetime">
<xform:datetime property="fdReceiveTime" mobile="${param.mobile eq 'true'? 'true':'false'}"
				required="<%=required %>"
                showStatus="edit" 
                dateTimeType="date" 
                subject="${lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveTime')}"
                style="<%=parse.getStyle()%>" />
</div>	