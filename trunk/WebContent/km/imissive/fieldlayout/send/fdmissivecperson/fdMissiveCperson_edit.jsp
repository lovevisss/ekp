<%-- 抄送个人--%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdMissiveCpersonIds = parse.getParamValue("fdMissiveCpersonIds");
    String fdMissiveCpersonNames = parse.getParamValue("fdMissiveCpersonNames");
    
    String defaultFdMissiveCpersonIds = parse.acquireValue("fdMissiveCpersonIds",fdMissiveCpersonIds);
    String defaultFdMissiveCpersonNames = parse.acquireValue("fdMissiveCpersonNames",fdMissiveCpersonNames);
    request.setAttribute("defaultFdMissiveCpersonIds",defaultFdMissiveCpersonIds);
    request.setAttribute("defaultFdMissiveCpersonNames",defaultFdMissiveCpersonNames);
	parse.addStyle("width", "control_width", "95%");
%>	
<div id="_fdMissiveCperson" valField="fdMissiveCpersonIds" xform_type="address">
	<xform:address 
	            isLoadDataDict="false"
	            showStatus="edit"
	            mulSelect="true"
	            mobile="${param.mobile eq 'true'? 'true':'false'}"
				style="<%=parse.getStyle()%>"
				required="<%=required%>"
				idValue="${defaultFdMissiveCpersonIds}"
				nameValue="${defaultFdMissiveCpersonNames}"
				subject="${lfn:message('km-imissive:kmImissiveUnit.fdId')}"
				propertyId="fdMissiveCpersonIds" propertyName="fdMissiveCpersonNames"
				orgType='ORG_TYPE_PERSON|ORG_TYPE_POST' className="input">
	</xform:address>	
</div>	