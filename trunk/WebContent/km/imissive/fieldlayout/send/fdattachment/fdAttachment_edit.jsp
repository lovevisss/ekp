<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment" />
			<c:param name="fdModelId" value="${param.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			<c:param name="formName" value="kmImissiveSendMainForm"></c:param>
		</c:import> 
    </c:when>
    <c:otherwise>
    	<%if(!"singletab".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
    		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment" />
				<c:param name="fdModelId" value="${param.fdId}" />
				<c:param name="uploadAfterSelect" value="true" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				<c:param name="fdLabel" value="文档附件" />
				<c:param name="fdGroup" value="documentAtt" />
			</c:import>
    	<%}else{%>
	    	<div style="padding-left:9px;padding-top: 5px;padding-bottom: 15px;">
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="attachment" />
					<c:param name="fdModelId" value="${param.fdId}" />
					<c:param name="uploadAfterSelect" value="true" />  
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				</c:import>
			</div>
    	<%}%>
    </c:otherwise>
</c:choose> 
