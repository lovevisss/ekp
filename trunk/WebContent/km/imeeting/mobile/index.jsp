<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<template:include ref="mobile.list" bodyClass="lui_imeeting_body"> 
	<template:replace name="title">
		<c:if test="${JsParam.moduleName!=null && JsParam.moduleName!=''}">
			${HtmlParam.moduleName}
		</c:if>
		<c:if test="${JsParam.moduleName==null or JsParam.moduleName==''}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<mui:cache-file name="mui-module.css" cacheType="md5" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/calendar.css?s_cache=${MUI_Cache}"></link>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/index.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/listItem.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-imeeting.js"/>
	</template:replace>
	<template:replace name="content">
	
		<c:set var="canCreateMeeting" value="false"></c:set>
		
		<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
			<c:set var="canCreateMeeting" value="true"></c:set>
		</kmss:authShow>
		
		<script type="text/javascript">
			window.isImissiveRole = "false";
			<c:choose>
				<c:when test="${imissiveSummaryEnable == 'true'}">
					<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
						window.isImissiveRole = "true";
					</kmss:authShow>
				</c:when>
				<c:otherwise>
					window.isImissiveRole = "true";
				</c:otherwise>
			</c:choose>
		</script>
		<%@ include file="/km/imeeting/mobile/home/index_mine.jsp"%>
		
		<ul id="tabs" fixed="bottom"
			data-dojo-type="mui/tabbar/TabBar"
			data-dojo-props='fill:"always",syncWithViews:true'>
		  	<li id="tab2Calendar"
			  		data-dojo-type="mui/tabbar/TabBarButton" 
			  		data-dojo-props="selected: true,href:'/km/imeeting/mobile/index.jsp',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyi_normal@1x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyi_press@1x.png'">
		  		<bean:message bundle="km-imeeting" key="mobile.myMeeting" />
		  	</li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton" class="kmImeetingIndexTabLi"
		  			data-dojo-props="href:'/km/imeeting/mobile/index_approval.jsp?showBottomTabBar=true',transition: 'none',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_shenpi_normal@1x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_shenpi_press@1x.png'">
			  	<bean:message bundle="km-imeeting" key="mobile.myApproval" />
			</li>
			<c:choose>
				<c:when test="${imissiveSummaryEnable == 'true'}">
					<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  			data-dojo-props="href:'/km/imeeting/mobile/summary/imissive/index.jsp',transition: 'none',
					  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
					  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
					  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
					  	</li>
					</kmss:authShow>
				</c:when>
				<c:otherwise>
					<li data-dojo-type="mui/tabbar/TabBarButton"
				  			data-dojo-props="href:'/km/imeeting/mobile/summary/index.jsp',transition: 'none',
				  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
				  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
				  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
				  	</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</template:replace>
</template:include>
