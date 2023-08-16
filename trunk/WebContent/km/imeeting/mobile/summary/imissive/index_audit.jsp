<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.sys.authentication.user.KMSSUser"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:out value="${lfn:message('km-imeeting:mobile.summaryApproval')}"></c:out>
	</template:replace>
	<template:replace name="head">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imissive/mobile/resource/css/listview.css?s_cache=${MUI_Cache}"></link>
		<mui:cache-file name="mui-nav.js" cacheType="md5"/>
		<mui:cache-file name="mui-sysCate.js" cacheType="md5" />
        <mui:cache-file name="mui-kmImissive-imissiveSend.js" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">

		<%-- 导航头部，通常放导航页签、搜索 --%>
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	  		<%-- 搜索 --%>
			<div data-dojo-type="mui/search/SearchBar"
				data-dojo-props="placeHolder:'<bean:message key="button.search"/>',modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',needPrompt:false,height:'4rem',showLayer:false">
			</div>
		</div>
		
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/imeeting/mobile/resource/js/header/SummaryAuditNavMixin">
			</div>
		</div>
		
		
		<%-- 筛选器头部，通常放排序、标签筛选器、重要筛选器、筛选器。  
			 	注1: 根据nav.json定义的headerTemplate进行渲染
			 	注2: 考虑到移动端大小问题，业务应该在排序、标签筛选器、重要筛选器三个组件中三选一
		--%>
		<div data-dojo-type="mui/header/NavHeader">
			<!-- <div data-dojo-type="mui/property/TagFilterItem"
				data-dojo-props="
					name: 'docType',
					isTagCount:true,
					options:[
						{name:'待审',value:'myApproval'},
						{name:'已审',value:'myApprovaled'}
					],
					values:{'docType':'myApproval'}">
			</div> -->
			
			<%-- 分类筛选  --%>
			<div class="muiHeaderItemRight" 
				 data-dojo-type="mui/catefilter/FilterItem"
				 data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				 data-dojo-props="modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',catekey: 'fdTemplate',prefix:'q'"></div>	
		</div>
		
		
		<%--  页签内容展示区域，可纵向上下滑动   --%>
		<div data-dojo-type="mui/list/NavView">
			<%--  默认列表模板   --%>
			<ul data-dojo-type="mui/list/HashJsonStoreList" 
				data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
			</ul>
		</div>
		 
	</template:replace>
</template:include>