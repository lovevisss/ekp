<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true"> 
	<template:replace name="title">
		<c:if test="${JsParam.moduleName!=null && JsParam.moduleName!=''}">
			${HtmlParam.moduleName}
		</c:if>
		<c:if test="${JsParam.moduleName==null or JsParam.moduleName==''}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
	
		<div data-dojo-type="mui/tabbar/TabBarView">
			<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
			    <%-- Tab页签（注：当使用MobileCfgNavBar构建页签栏时，如果有模块有配置扩展点，则优先通过modelName从“移动办公--移动应用管理--应用页签配置”）读取数据 ，若无相关配置数据则读取defaultUrl配置的静态数据 --%>
				<div data-dojo-type="mui/nav/MobileCfgNavBar" 
					 data-dojo-props="defaultUrl:'/km/imeeting/mobile/nav_summary.jsp',modelName:'com.landray.kmss.km.imeeting.model.KmImeetingSummary'"> 
				</div>
				
				<%-- 搜索 --%>
				<div data-dojo-type="mui/search/SearchButtonBar"
					 data-dojo-props="modelName:'com.landray.kmss.km.imeeting.model.KmImeetingSummary'">
				</div>
			</div>
			
			<div data-dojo-type="mui/header/NavHeader">
			</div>
			
			<div class="mui_ekp_meeting_cardList" data-dojo-type="mui/list/NavView">
			    <ul data-dojo-type="mui/list/HashJsonStoreList" 
			    	data-dojo-mixins="km/imeeting/mobile/resource/js/list/SummaryCardItemListMixin">
				</ul>
			</div>
		</div>
		
		<ul id="tabs"
			data-dojo-type="mui/tabbar/TabBar" fixed="bottom"
			data-dojo-props='
				fill:"always",
				syncWithViews:true
			'>
		  	<c:choose>
				<c:when test="${JsParam.showList == true }">
				  	<li id="tab2Calendar"
				  		data-dojo-type="mui/tabbar/TabBarButton" 
				  		data-dojo-props="
				  			transition: 'none',
				  			href:'/km/imeeting/mobile/index_list_my.jsp?showList=${JsParam.showList}',
				  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my@2x.png',
				  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my_select@2x.png'
			  			"><bean:message bundle="km-imeeting" key="mobile.myMeeting" /> </li>
	  			</c:when>
	  			<c:otherwise>
	  				<li id="tab2Calendar"
			  		data-dojo-type="mui/tabbar/TabBarButton" 
			  		data-dojo-props="
			  			transition: 'none',
			  			href:'/km/imeeting/mobile/index.jsp',
			  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my@2x.png',
			  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my_select@2x.png'
		  			"><bean:message bundle="km-imeeting" key="mobile.myMeeting" /> </li>
	  			</c:otherwise>
			</c:choose>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			transition: 'none',
		  			href:'/km/imeeting/mobile/index_place_new.jsp?showList=${JsParam.showList}',
		  			callback: function(){ window.navigate2View('place') },
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place_select@2x.png'
		  		"><bean:message bundle="km-imeeting" key="mobile.meetingRoom" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			selected: true,
		  			href:'/km/imeeting/mobile/index_summary.jsp?showList=${JsParam.showList}',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.meetingSummary" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			href:'/km/imeeting/mobile/index_other.jsp?showList=${JsParam.showList}',
		  			transition: 'none',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.other" /></li>
		</ul>
		
	</template:replace>
</template:include>