<%-- 试用期内工作总结 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/hr/ratify/fieldlayout/common/param_parser.jsp"%>
<%
parse.addStyle("width", "control_width", "95%");
required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
%>
<div id="_fdTransferHrView"  xform_type="textarea">
<xform:textarea property="fdTransferHrView" showStatus="edit" required="<%=required%>" style="<%=parse.getStyle()%>" mobile="${param.mobile eq 'true'? 'true':'false'}"></xform:textarea>
  </div>