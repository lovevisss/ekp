<%--公文性质 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
	String fdMissiveType = parse.getParamValue("fdMissiveType");
	String defaultFdMissiveType = parse.acquireValue("fdMissiveType",fdMissiveType);
	request.setAttribute("defaultFdMissiveType",defaultFdMissiveType);
%>	
<div id="_fdMissiveType" xform_type="radio">
    <xform:radio property="fdMissiveType" mobile="${param.mobile eq 'true'? 'true':'false'}" style="<%=parse.getStyle()%>" value="<%=defaultFdMissiveType%>" onValueChange="changeMissiveType(this.value);">
	   <xform:enumsDataSource  enumsType="missive_type"></xform:enumsDataSource>
	</xform:radio>
</div>
<script type="text/javascript">
function changeMissiveType(value){
	if(typeof changeMissiveTypeMain === 'function'){
		changeMissiveTypeMain(value);
	}
	if(typeof changeMissiveTypeCopy === 'function'){
		changeMissiveTypeCopy(value);
	}
	if(typeof changeMissiveTypeReport === 'function'){
		changeMissiveTypeReport(value);
	}
}
</script>