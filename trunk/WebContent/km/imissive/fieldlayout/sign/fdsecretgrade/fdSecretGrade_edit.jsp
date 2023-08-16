<%-- 密级程度设置 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
	<%
	    String fdSecretGradeId = parse.getParamValue("fdSecretGradeId");
	    String defaultValue = parse.acquireValue("fdSecretGradeId",fdSecretGradeId);
		parse.addStyle("width", "control_width", "auto");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));	
	%>
	<div id="_fdSecretGrade" valField="fdSecretGradeId" xform_type="select">
	<xform:select property="fdSecretGradeId" mobile="${param.mobile eq 'true'? 'true':'false'}" subject="${lfn:message('km-imissive:kmImissiveSignMain.fdSecretGrade')}" required="<%=required%>" style="<%=parse.getStyle()%>" showStatus="edit" value="<%=defaultValue%>">
		<xform:beanDataSource serviceBean="kmImissiveSecretGradeService"
						      selectBlock="fdId,fdName"
							  whereBlock="kmImissiveSecretGrade.fdIsAvailable=true"
							  orderBy="kmImissiveSecretGrade.fdOrder"
							  langSupport="true" />
	</xform:select>
	</div>
