<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:set var="tiny" value="true" scope="request" />
<%
	String staticFilterType = "km/imeeting/mobile/resource/js/header/SchemePropertyMixin";
	String headerJs = "km/imeeting/mobile/resource/js/header/SchemeNavMixin";
	if (UserUtil.getKMSSUser().isAdmin()) {
		staticFilterType = "km/imeeting/mobile/resource/js/header/SchemePropertyMixin_admin";
		headerJs = "km/imeeting/mobile/resource/js/header/SchemeNavMixin_admin";
	}
	request.setAttribute("staticFilterType", staticFilterType);
	request.setAttribute("headerJs", headerJs);
%>
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<bean:message bundle="km-imeeting" key="kmImeeting.scheme.all"/>
	</template:replace>
	<template:replace name="head">	
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/header.css?s_cache=${MUI_Cache}"></link>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="content">
	
		<div style="height: 5rem;">
			<!-- 全文搜索 -->
			<div id="kmImeeting_header" data-dojo-type="mui/header/Header">
				<div data-dojo-type="mui/search/SearchBar"
					data-dojo-props="placeHolder:'<bean:message key="button.search"/>',modelName:'com.landray.kmss.km.imeeting.model.KmImeetingBook',needPrompt:false,height:'5 rem',showLayer:false">
				</div>
			</div>
			
			<!-- 属性筛选 -->
			<div id="kmImeeting_nav" data-dojo-type="mui/header/NavHeader">
				<div class="muiHeaderItemRight" 
					data-dojo-type="mui/property/FilterItem"
					data-dojo-mixins="${staticFilterType}">
				</div>
			
				<!-- 分类筛选 -->
				<!-- <div class="muiHeaderItemRight" 
					data-dojo-type="mui/catefilter/FilterItem"
					data-dojo-mixins="mui/syscategory/SysCategoryMixin"
					data-dojo-props="modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate',catekey: 'fdSchemeTemplate'">
				</div> -->
			</div>
		</div>
		
	  	<div data-dojo-type="mui/header/Header" data-dojo-props="height:'0rem'" >
	  	
	  		<div style="display:none" data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/imeeting/mobile/resource/js/header/BookNavMixin">
			</div>
			
			<!-- 新建摁钮 -->
			<kmss:authShow roles="ROLE_KMIMEETING_SCHEME_CREATE">
				<div class="ekp-ledger-fast-nav-btn" onclick="createBook();">
					<img alt="" src="${LUI_ContextPath}/km/imeeting/mobile/resource/images/add_btn@2x.png" class="muiImeetingAddIcon">
					<p class="muiImeetingAddText"><bean:message key="mobile.create" bundle="km-imeeting" /></p>
				</div>
			</kmss:authShow>
		</div>
	
		<!-- 页签内容展示区域，可纵向上下滑动 -->
		<div data-dojo-type="mui/list/NavView">
			<ul data-dojo-type="mui/list/HashJsonStoreList"
				data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
			</ul>
		</div>
		
		<script type="text/javascript">
			
			window.createBook = function() {
				window.open("${LUI_ContextPath}" + "/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=add", "_self");
			}
		
		</script>
		
	</template:replace>
</template:include>
