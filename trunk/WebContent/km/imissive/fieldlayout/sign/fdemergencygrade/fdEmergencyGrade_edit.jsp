<%-- 缓急程度 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdEmergencyGradeId = parse.getParamValue("fdEmergencyGradeId");
    String defaultValue = parse.acquireValue("fdEmergencyGradeId",fdEmergencyGradeId);
	parse.addStyle("width", "control_width", "auto");
	required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));	
%>
<div id="_fdEmergencyGrade" valField="fdEmergencyGradeId" xform_type="select">
    <xform:select property="fdEmergencyGradeId" mobile="${param.mobile eq 'true'? 'true':'false'}" subject="${lfn:message('km-imissive:kmImissiveSignMain.fdEmergencyGrade')}" showStatus="edit" required="<%=required%>" style="<%=parse.getStyle()%>" value="<%=defaultValue%>">
	   <xform:beanDataSource serviceBean="kmImissiveEmergencyGradeService"
					         selectBlock="fdId,fdName"
						     whereBlock="kmImissiveEmergencyGrade.fdIsAvailable=true"
						     orderBy="kmImissiveEmergencyGrade.fdOrder"
						     langSupport="true" />
    </xform:select>
</div>
