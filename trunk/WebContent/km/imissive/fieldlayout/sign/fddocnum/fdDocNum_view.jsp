<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
%>
<span class="xform_fieldlayout" style="<%=parse.getStyle()%>">
	<c:choose>
		<c:when
			test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
			<input type="hidden" name="fdDocNum" value="${kmImissiveSignMainForm.fdDocNum}" />
			<input type="hidden" name="fdFlowNo" value="${kmImissiveSignMainForm.fdFlowNo}"/>
			<input type="hidden" name="fdNoRule" value="${kmImissiveSignMainForm.fdNoRule}"/>
			<input type="hidden" name="fdYearNo" value="${kmImissiveSignMainForm.fdYearNo}"/>
			<input type="hidden" name="fdNumberMainId" value="${kmImissiveSignMainForm.fdNumberMainId}" />
			<span id="docnum">
				<c:if test="${not empty kmImissiveSignMainForm.fdDocNum}">
				   <c:out value="${kmImissiveSignMainForm.fdDocNum}"/>
				</c:if>
	        </span>
        		<c:choose>
	  			<c:when test="${param.mobile eq 'true'}">
	  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="generateNum('${kmImissiveSignMainForm.fdId}','${fdNoId}');">
						文件编号
					</div>
	  			</c:when>
	  			<c:otherwise>
	  				<c:if test="${kmImissiveSignMainForm.method_GET !='print'}">
		  				 <ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
							 onclick="generateFileNum();">
						</ui:button>
					</c:if>
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