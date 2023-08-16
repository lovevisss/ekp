<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>

<c:choose>
<c:when test="${ kmImissiveSendMainForm.method_GET == 'view' }">
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
	<c:out value="${kmImissiveSendMainForm.fdSignatureName}"/>
</span>
</c:when>
<c:otherwise>
<%
    String fdSignatureId = parse.getParamValue("fdSignatureId");
    String fdSignatureName = parse.getParamValue("fdSignatureName");
    String defaultFdSignatureId = parse.acquireValue("fdSignatureId",fdSignatureId);
    String defaultFdSignatureName = parse.acquireValue("fdSignatureName",fdSignatureName);
    request.setAttribute("defaultFdSignatureId",defaultFdSignatureId);
    request.setAttribute("defaultFdSignatureName",defaultFdSignatureName);
%>	
  <xform:address 
            isLoadDataDict="false"
            showStatus="readOnly"
            mobile="${param.mobile eq 'true'? 'true':'false'}"
			idValue="${defaultFdSignatureId}"
			nameValue="${defaultFdSignatureName}"
			subject="${lfn:message('km-imissive:kmMissiveSignTemplate.fdSignatureId')}"
			propertyId="fdSignatureId" propertyName="fdSignatureName"
			orgType='ORG_TYPE_PERSON'>
  </xform:address>
</c:otherwise>
</c:choose>