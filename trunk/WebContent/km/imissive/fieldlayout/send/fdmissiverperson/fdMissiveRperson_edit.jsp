<%-- 抄报个人 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdMissiveRpersonIds = parse.getParamValue("fdMissiveRpersonIds");
    String fdMissiveRpersonNames = parse.getParamValue("fdMissiveRpersonNames");
    
    String defaultFdMissiveRpersonIds = parse.acquireValue("fdMissiveRpersonIds",fdMissiveRpersonIds);
    String defaultFdMissiveRpersonNames = parse.acquireValue("fdMissiveRpersonNames",fdMissiveRpersonNames);
    
    request.setAttribute("defaultFdMissiveRpersonIds",defaultFdMissiveRpersonIds);
    request.setAttribute("defaultFdMissiveRpersonNames",defaultFdMissiveRpersonNames);
    
	parse.addStyle("width", "control_width", "95%");
%>	
<div id="_fdMissiveRperson" valField="fdMissiveRpersonIds" xform_type="address">
	<xform:address 
	            isLoadDataDict="false"
	            showStatus="edit"
	            mulSelect="true"
	            mobile="${param.mobile eq 'true'? 'true':'false'}"
			    required="<%=required%>" style="<%=parse.getStyle()%>"
				idValue="${defaultFdMissiveRpersonIds}"
				nameValue="${defaultFdMissiveRpersonNames}"
				subject="${lfn:message('km-imissive:kmImissiveUnit.fdId')}"
				propertyId="fdMissiveRpersonIds" propertyName="fdMissiveRpersonNames"
				orgType='ORG_TYPE_PERSON|ORG_TYPE_POST' className="input">
	</xform:address>	
</div>