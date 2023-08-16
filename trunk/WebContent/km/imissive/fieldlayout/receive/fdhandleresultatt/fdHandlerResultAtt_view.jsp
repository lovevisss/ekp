<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>	

<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="fdHandleResultAtt"/>
			<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
			<c:param name="fdModelId" value="${param.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		</c:import>
    </c:when>
    <c:otherwise>
    	<c:choose>
			<c:when test="${kmImissiveReceiveMainForm.method_GET eq 'viewXformInfo'}">
				<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="fdHandleResultAtt"/>
					<c:param  name="fdMulti" value="true" />
					<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
					<c:param name="uploadAfterSelect" value="true" /> 
					<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="fdHandleResultAtt"/>
					<c:param  name="fdMulti" value="true" />
					<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
					<c:param name="uploadAfterSelect" value="true" /> 
					<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
				</c:import>
			</c:otherwise>
		</c:choose>	
    </c:otherwise>
</c:choose> 

