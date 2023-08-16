<%-- 发文文号 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
<html:hidden property="fdDocNum" />
<html:hidden property="fdFlowNo" />
<html:hidden property="fdNoRule" />
<html:hidden property="fdYearNo" />
<html:hidden property="fdNumberMainId" />
<c:choose>
	<c:when
		test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on' or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
		<span id="docnum">
		  <c:if test="${not empty kmImissiveSignMainForm.fdDocNum}">
		   <c:out value="${kmImissiveSignMainForm.fdDocNum}"/>
		  </c:if>
		   <c:if test="${empty kmImissiveSignMainForm.fdDocNum}">
		    提交后自动生成（字号） 
		  </c:if>
		</span>
		<c:choose>
  			<c:when test="${param.mobile eq 'true'}">
  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="generateNum('${kmImissiveSignMainForm.fdId}','${fdNoId}');">
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
	     <c:if test="${not empty kmImissiveSignMainForm.fdDocNum}">
		   <c:out value="${kmImissiveSignMainForm.fdDocNum}"/>
		</c:if>
		 <c:if test="${empty kmImissiveSignMainForm.fdDocNum}">
		     <bean:message  bundle="km-imissive" key="kmImissiveSignMain.docNum.info"/>
		</c:if>
	</c:otherwise>
</c:choose>
</span>
