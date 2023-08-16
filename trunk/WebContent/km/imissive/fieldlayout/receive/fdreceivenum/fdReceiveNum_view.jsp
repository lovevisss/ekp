<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
			test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
			<input type="hidden" name="fdReceiveNum" value="${kmImissiveReceiveMainForm.fdReceiveNum}" />
			<input type="hidden" name="fdFlowNo" value="${kmImissiveReceiveMainForm.fdFlowNo}"/>
			<input type="hidden" name="fdNoRule" value="${kmImissiveReceiveMainForm.fdNoRule}"/>
			<input type="hidden" name="fdYearNo" value="${kmImissiveReceiveMainForm.fdYearNo}" />
			<input type="hidden" name="fdNumberMainId" value="${kmImissiveReceiveMainForm.fdNumberMainId}" />
			<span id="docnum">
				<c:if test="${not empty kmImissiveReceiveMainForm.fdReceiveNum}">
				   <c:out value="${kmImissiveReceiveMainForm.fdReceiveNum}"/>
				</c:if>
	        </span>
        		<c:choose>
	  			<c:when test="${param.mobile eq 'true'}">
	  				<div data-dojo-type="mui/tabbar/TabBarButton" class="docNumBtn" data-dojo-props='moveTo:"_modifyDocNumView",transition:"slide"' onclick="optGetNum();">
						文件编号
					</div>
	  			</c:when>
	  			<c:otherwise>
	  			 <c:if test="${kmImissiveReceiveMainForm.method_GET !='print'}">
	  				 <ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
						 onclick="generateFileNum();">
					</ui:button>
				 </c:if>	
	  			</c:otherwise>
	  		</c:choose>
		</c:when>
		<c:otherwise>
		     <c:if test="${not empty kmImissiveReceiveMainForm.fdReceiveNum}">
			   <c:out value="${kmImissiveReceiveMainForm.fdReceiveNum}"/>
			</c:if>
			 <c:if test="${empty kmImissiveReceiveMainForm.fdReceiveNum}">
			         办结后自动生成(文号)
			    <c:if test="${not empty kmImissiveReceiveMainForm.fdNumberMainId}">
				   (编号规则:
				   <c:import url="/sys/number/include/sysNumberMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
					</c:import> )
				</c:if>
			</c:if>
		</c:otherwise>
	</c:choose>
</span>