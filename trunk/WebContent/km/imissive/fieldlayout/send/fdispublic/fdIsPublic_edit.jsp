<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<div id="_fdIsPublic" xform_type="radio">
<xform:radio property="fdIsPublic" mobile="${param.mobile eq 'true'? 'true':'false'}" style="<%=parse.getStyle()%>">
   <xform:enumsDataSource  enumsType="kmMissive_fdIsPublic"></xform:enumsDataSource>
</xform:radio>
</div>
