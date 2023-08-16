<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<%
	String staticFilterType = "km/imeeting/mobile/resource/js/header/SummaryPropertyMixin";
	String headerJs = "km/imeeting/mobile/resource/js/header/SummaryNavMixin";
	if (UserUtil.getKMSSUser().isAdmin()) {
		staticFilterType = "km/imeeting/mobile/resource/js/header/SummaryPropertyMixin_admin";
		headerJs = "km/imeeting/mobile/resource/js/header/SummaryNavMixin_admin";
	}
	request.setAttribute("staticFilterType", staticFilterType);
	request.setAttribute("headerJs", headerJs);
%>

<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:out value="${lfn:message('km-imeeting:table.kmImeetingSummary')}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/index.css?s_cache=${MUI_Cache}" />
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imissive/mobile/resource/css/listview.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/header.css?s_cache=${MUI_Cache}"></link>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />
		<mui:cache-file name="mui-nav.js" cacheType="md5"/>
		<mui:cache-file name="mui-sysCate.js" cacheType="md5" />
        <mui:cache-file name="mui-kmImissive-imissiveSend.js" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">

		<div style="height: 5rem;">
			<%-- 搜索 --%>
			<div id="kmImeeting_header" data-dojo-type="mui/header/Header">
				<div data-dojo-type="mui/search/SearchBar"
					data-dojo-props="placeHolder:'<bean:message key="button.search"/>',modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',needPrompt:false,height:'4rem',showLayer:false">
				</div>
			</div>
			
			<div  id="kmImeeting_nav" data-dojo-type="mui/header/NavHeader">
				
				<div class="muiHeaderItemRight" 
					data-dojo-type="mui/property/FilterItem"
					data-dojo-mixins="km/imeeting/mobile/resource/js/header/SummaryPropertyMixin">
				</div>
				
				<div class="muiHeaderItemRight" 
					 data-dojo-type="mui/catefilter/FilterItem"
					 data-dojo-mixins="mui/syscategory/SysCategoryMixin"
					 data-dojo-props="modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',catekey: 'fdTemplate',prefix:'q'">
				</div>	
			</div>
	  	</div>
		
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'0rem'">
			
			<div style="display:none" data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/imeeting/mobile/resource/js/header/SummaryNavMixin">
			</div>
			
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
		        <div class="ekp-ledger-fast-nav-btn" onclick="createSummary();">
					<img alt="" src="${LUI_ContextPath}/km/imeeting/mobile/resource/images/add_btn@2x.png" class="muiImeetingAddIcon">
					<p class="muiImeetingAddText"><bean:message key="mobile.create" bundle="km-imeeting" /></p>
				</div>
			</kmss:authShow>
		</div>
		
		<%--  页签内容展示区域，可纵向上下滑动   --%>
		<div data-dojo-type="mui/list/NavView">
			<%--  默认列表模板   --%>
			<ul data-dojo-type="mui/list/HashJsonStoreList" 
				data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
			</ul>
		</div>
		
		
		<ul id="tabs" fixed="bottom"
			data-dojo-type="mui/tabbar/TabBar"
			data-dojo-props='fill:"always",syncWithViews:true'>
		  	<li id="tab2Calendar"
			  		data-dojo-type="mui/tabbar/TabBarButton" 
			  		data-dojo-props="href:'/km/imeeting/mobile/index.jsp',transition: 'none',
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
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  			data-dojo-props="selected: true,href:'/km/imeeting/mobile/summary/imissive/index.jsp',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
				  	icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
		  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
		  	</li>
		</ul>
		 
		 <script type="text/javascript">
			require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
				window.createSummary = function() {
					SysCategoryUtil.create({
						key: 'createSummary',
		                createUrl: '/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&isRelationFile=1&fdTemplateId=!{curIds}&mobile=true',
		                modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
		                mainModelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
		                showFavoriteCate:'true',
		         		authType: '02'
		           });
				}
			});
		</script>
		 
	</template:replace>
</template:include>