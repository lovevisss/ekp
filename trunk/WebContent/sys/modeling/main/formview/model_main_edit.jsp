<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.sys.modeling.main.model.ModelingAppModelMain"></lbpm:lbpmApproveModel>
<c:choose>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<template:include ref="lbpm.right" showQrcode="true" isEdit="true" fdUseForm="true" formName="modelingAppModelMainForm" formUrl="${KMSS_Parameter_ContextPath}sys/modeling/main/modelingAppModelMain.do">
			<c:import url="/sys/modeling/main/formview/model_main_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/sys/modeling/main/formview/model_main_editTab.jsp" charEncoding="UTF-8">
 		 		<c:param name="approveModel" value="${lbpmApproveModel}"></c:param>
  			</c:import>
		</template:include>
	</c:when>
	
	<c:otherwise>
		<template:include ref="default.edit" sidebar="auto">
			<c:import url="/sys/modeling/main/formview/model_main_editHead.jsp" charEncoding="UTF-8">
 		 	</c:import>
 		 	<c:import url="/sys/modeling/main/formview/model_main_editTab.jsp" charEncoding="UTF-8">
  			</c:import>
		</template:include>
	</c:otherwise>
</c:choose>