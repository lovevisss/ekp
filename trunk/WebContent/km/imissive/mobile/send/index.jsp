<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.list">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-imissive:kmImissive.tree.title')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="content">
		<c:choose>
			<c:when test="${ param.filter == '1' }">
				<c:import url="/km/imissive/mobile/send/filterSend.jsp" charEncoding="UTF-8">
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/km/imissive/mobile/send/listviewSend.jsp" charEncoding="UTF-8">
				</c:import>
			</c:otherwise>
		</c:choose>
		<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
	  		<li data-dojo-type="mui/tabbar/CreateButton" 
		  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
		  		data-dojo-props="icon1:'',key:'sendAdd',createUrl:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',mainModelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
		  		modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate'">
		  		${lfn:message('km-imissive:kmImissiveSendMain.create.title') }
		  	</li>
		  	</kmss:authShow>
		</ul>
	</template:replace>
</template:include>
