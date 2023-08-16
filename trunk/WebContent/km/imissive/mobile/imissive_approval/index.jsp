<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-imissive:kmImissive.tree.myapproval')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imissive/mobile/resource/css/listview.css?s_cache=${MUI_Cache}"></link>
	    <mui:cache-file name="mui-nav.js" cacheType="md5"/>
		<mui:cache-file name="mui-sysCate.js" cacheType="md5" />
        <mui:cache-file name="mui-kmImissive-imissiveApproval.js" cacheType="md5"/>
        <mui:cache-file name="mui-module.css" cacheType="md5" />
	</template:replace>
	<template:replace name="content">

		 <c:import url="/km/imissive/mobile/imissive_approval/listview.jsp" charEncoding="UTF-8"></c:import>
		  <%@ include file="/km/imissive/mobile/createBtn.jsp"%>
	</template:replace>
</template:include>