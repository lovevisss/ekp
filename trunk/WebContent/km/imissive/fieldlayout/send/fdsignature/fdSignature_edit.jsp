<%-- 签发人 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%
    String fdSignatureId = parse.getParamValue("fdSignatureId");
    String fdSignatureName = parse.getParamValue("fdSignatureName");
    String defaultFdSignatureId = parse.acquireValue("fdSignatureId",fdSignatureId);
    String defaultFdSignatureName = parse.acquireValue("fdSignatureName",fdSignatureName);
    request.setAttribute("defaultFdSignatureId",defaultFdSignatureId);
    request.setAttribute("defaultFdSignatureName",defaultFdSignatureName);
    
	parse.addStyle("width", "control_width", "45%");
%>	
<div id="_fdSignature" valField="fdSignatureId" xform_type="address">
  <xform:address 
            isLoadDataDict="false"
            showStatus="edit"
            mobile="${param.mobile eq 'true'? 'true':'false'}"
			required="<%=required%>" style="<%=parse.getStyle()%>"
			idValue="${defaultFdSignatureId}"
			nameValue="${defaultFdSignatureName}"
			subject="${lfn:message('km-imissive:kmMissiveSignTemplate.fdSignatureId')}"
			propertyId="fdSignatureId" propertyName="fdSignatureName"
			orgType='ORG_TYPE_PERSON' className="input">
   </xform:address>
   <br>
   ${lfn:message("km-imissive:kmImissiveSendMain.fdSignatureId.info")}
</div>