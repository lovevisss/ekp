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
			test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
			<input type="hidden" name="fdDocNum" value="${kmImissiveSendMainForm.fdDocNum}" />
			<input type="hidden" name="fdFlowNo" value="${kmImissiveSendMainForm.fdFlowNo}" />
			<input type="hidden" name="fdNoRule" value="${kmImissiveSendMainForm.fdNoRule}" />
			<input type="hidden" name="fdYearNo" value="${kmImissiveSendMainForm.fdYearNo}" />
			<input type="hidden" name="fdNumberMainId" value="${kmImissiveSendMainForm.fdNumberMainId}" />
			<span id="docnum">
				<c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
				   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
				</c:if>
			</span>
			<c:choose>
	  			<c:when test="${param.mobile eq 'true'}">
	  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="optGetNum();">
						文件编号
					</div>
	  			</c:when>
	  			<c:otherwise>
	  			 <c:if test="${kmImissiveSendMainForm.method_GET !='print'}">
	  			     <ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
						 onclick="generateFileNum();">
					</ui:button>
	  			 </c:if>
	  				
	  			</c:otherwise>
	  		</c:choose>	
		</c:when>
		<c:otherwise>
		     <c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
			   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
			</c:if>
			 <c:if test="${empty kmImissiveSendMainForm.fdDocNum}">
			   <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info"/>
			     <c:if test="${not empty kmImissiveSendMainForm.fdNumberMainId}">
				   (编号规则:
				   <c:import url="/sys/number/include/sysNumberMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
					</c:import> )
				 </c:if>
			</c:if>
		</c:otherwise>
	</c:choose>
</span>