<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:if test="${wpsoaassist eq 'true'}">
	<script type="text/javascript">
		Com_IncludeFile("kmImissiveSendRedhead_script.js",Com_Parameter.ContextPath + "km/imissive/wps/","js",true);
	</script>
</c:if>
<%
	SysFieldsParamsParse parse = new SysFieldsParamsParse(request).parse();
	boolean required = Boolean.parseBoolean(parse.getParamValue("control_required", "false"));
%>