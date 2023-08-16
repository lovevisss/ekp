<%-- 发文文种 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "95%"); %>
<%
   if(required)
	   request.setAttribute("required","required");
   else
	   request.setAttribute("required","");
	String selectedId = parse.acquireValue("fdDocTypeId");
	String ids = parse.getParamValue("fdMissiveTypesIds");
	request.setAttribute("fdDocTypeId", ids);
	request.setAttribute("selectedId", selectedId);

%>
<div id="_fdDocType" valField="fdDocTypeId" xform_type="select">
<xform:select property="fdDocTypeId" mobile="${param.mobile eq 'true'? 'true':'false'}" showStatus="edit" value="${selectedId}" style="<%=parse.getStyle()%>" showPleaseSelect="true"  required="<%=required %>" subject="${required=='required'?'文种':''}">
	<xform:customizeDataSource className="com.landray.kmss.km.imissive.service.spring.KmImissiveDocTypeDataSource"></xform:customizeDataSource>
</xform:select>
</div>
