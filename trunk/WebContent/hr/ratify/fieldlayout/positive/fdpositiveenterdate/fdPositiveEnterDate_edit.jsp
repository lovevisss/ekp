<%-- 收文日期 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/hr/ratify/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%"); %>
<div id="_fdPositiveEnterDate"  xform_type="datetime">
<xform:datetime property="fdPositiveEnterDate" mobile="${param.mobile eq 'true'? 'true':'false'}"
				required="<%=required %>"
                showStatus="edit" 
                dateTimeType="date" 
                subject="${lfn:message('hr-ratify:hrRatifyPositive.fdPositiveEnterDate')}"
                style="<%=parse.getStyle()%>" htmlElementProperties="id='fdPositiveEnterDate'"/>	
                   </div>	