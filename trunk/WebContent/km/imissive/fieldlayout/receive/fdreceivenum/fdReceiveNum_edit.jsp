<%-- 收文编号 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ include file="/resource/jsp/common.jsp"%>
<html:hidden property="fdReceiveNum" />
<html:hidden property="fdFlowNo" />
<html:hidden property="fdNoRule" />
<html:hidden property="fdNumberMainId" />
<html:hidden property="fdYearNo" />
<%
    SysFieldsParamsParse parse = new SysFieldsParamsParse(request).parse();
	parse.addStyle("width", "control_width", "auto");
%>
<c:choose>
	<c:when test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on' or kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">		
		<span id="docnum">
		  <c:if test="${not empty kmImissiveReceiveMainForm.fdReceiveNum}">
		   <c:out value="${kmImissiveReceiveMainForm.fdReceiveNum}"/>
		  </c:if>
		   <c:if test="${empty kmImissiveReceiveMainForm.fdReceiveNum}">
		     提交后自动生成（编号） 
		  </c:if>
		</span>
		<c:choose>
  			<c:when test="${param.mobile eq 'true'}">
  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="optGetNum();">
					文件编号
				</div>
  			</c:when>
  			<c:otherwise>
  				 <ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
					 onclick="generateFileNum();">
				 </ui:button>
  			</c:otherwise>
  		</c:choose>	
	</c:when>
	<c:otherwise>
	     <c:if test="${not empty kmImissiveReceiveMainForm.fdReceiveNum}">
		   <c:out value="${kmImissiveReceiveMainForm.fdReceiveNum}"/>
		</c:if>
		 <c:if test="${empty kmImissiveReceiveMainForm.fdReceiveNum}">
		          办结后自动生成(文号)
		</c:if>
	</c:otherwise>
</c:choose>

