<%-- 拟搞人 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "45%"); %>
<div id="_fdDrafter" valField="fdDrafterId" xform_type="address">
 <xform:address 
        propertyId="fdDrafterId"
        propertyName="fdDrafterName" 
        orgType="ORG_TYPE_PERSON"
        mobile="${param.mobile eq 'true'? 'true':'false'}"
        required="<%=required%>" 
        style="<%=parse.getStyle()%>"
        className="inputsgl">
</xform:address>
</div>