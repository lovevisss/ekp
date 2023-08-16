<%-- 来文文号 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%parse.addStyle("width", "control_width", "95%"); 
  required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));%>
<c:if test="${kmImissiveReceiveMainForm.fdDeliverType=='0'}">
	   <div id="_fdDocNum" xform_type="xtext">
	   <xform:xtext property="fdDocNum" mobile="${param.mobile eq 'true'? 'true':'false'}" validators="maxLength(200)" required="<%=required%>" showStatus="edit" style="<%=parse.getStyle()%>"/>	
	   </div>
</c:if>
<c:if test="${kmImissiveReceiveMainForm.fdDeliverType!='0'}">
	   <c:if test="${not empty kmImissiveReceiveMainForm.fdDocNum}">
	        <input type="hidden" name="fdDocNum" value="${kmImissiveReceiveMainForm.fdDocNum}"/>
	        <div id="_fdDocNum" xform_type="xtext">
			<xform:xtext property="fdDocNum" mobile="${param.mobile eq 'true'? 'true':'false'}" required="<%=required%>" showStatus="view" style="<%=parse.getStyle()%>"/>	
	   		</div>
	   </c:if>	
	   <c:if test="${empty kmImissiveReceiveMainForm.fdDocNum}">
	 	   ${lfn:message("km-imissive:kmImissiveReceiveMain.fdDocNum.title")}
	   </c:if>
</c:if>

