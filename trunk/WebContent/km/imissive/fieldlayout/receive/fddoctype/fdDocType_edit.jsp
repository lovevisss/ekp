<%-- 收文文种 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "auto");%>
<div id="_fdDocType" valField="fdDocTypeId" xform_type="select">
<xform:select property="fdDocTypeId" mobile="${param.mobile eq 'true'? 'true':'false'}"
              required="<%=required%>"
              style="<%=parse.getStyle()%>"
			  subject="${ lfn:message('km-imissive:kmIMissiveReceiveMain.fdDocType') }">
         	  <xform:beanDataSource serviceBean="kmImissiveTypeService"
								    orderBy="kmImissiveType.fdOrder"
								    whereBlock="kmImissiveType.fdIsAvailable=true">
		      </xform:beanDataSource>
</xform:select>
</div>
