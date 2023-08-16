<%-- 主送个人 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdMissiveMpersonIds = parse.getParamValue("fdMissiveMpersonIds");
    String fdMissiveMpersonNames = parse.getParamValue("fdMissiveMpersonNames");
    
    String defaultFdMissiveMpersonIds = parse.acquireValue("fdMissiveMpersonIds",fdMissiveMpersonIds);
    String defaultFdMissiveMpersonNames = parse.acquireValue("fdMissiveMpersonNames",fdMissiveMpersonNames);
    request.setAttribute("defaultFdMissiveMpersonIds",defaultFdMissiveMpersonIds);
    request.setAttribute("defaultFdMissiveMpersonNames",defaultFdMissiveMpersonNames);
	parse.addStyle("width", "control_width", "95%");
%>	
<div id="_fdMissiveMperson" valField="fdMissiveMpersonIds" xform_type="address">
	<xform:address 
	            isLoadDataDict="false"
	            showStatus="edit"
	            mulSelect="true"
	            mobile="${param.mobile eq 'true'? 'true':'false'}"
	            required="<%=required%>" style="<%=parse.getStyle()%>"
				idValue="${defaultFdMissiveMpersonIds}"
				nameValue="${defaultFdMissiveMpersonNames}"
				subject="${lfn:message('km-imissive:kmMissiveMainMperson.fdId')}"
				propertyId="fdMissiveMpersonIds" propertyName="fdMissiveMpersonNames"
				orgType='ORG_TYPE_PERSON|ORG_TYPE_POST' className="input">
	</xform:address>	
</div>
