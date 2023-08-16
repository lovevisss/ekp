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
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/summary.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imissive/mobile/resource/css/listview.css?s_cache=${MUI_Cache}"></link>
		<mui:cache-file name="mui-nav.js" cacheType="md5"/>
		<mui:cache-file name="mui-sysCate.js" cacheType="md5" />
        <mui:cache-file name="mui-kmImissive-imissiveSend.js" cacheType="md5"/>
	</template:replace>
	<template:replace name="content">
	
		<div class="summaryTitle">
			<h2>会议纪要</h2>
		</div>
		
		<!-- 全文搜索 -->
		<div data-dojo-type="mui/header/Header">
			<div data-dojo-type="mui/search/SearchBar"
				data-dojo-props="modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',height:'5rem'">
			</div>
		</div>
		
		<%-- 导航头部，通常放导航页签、搜索 --%>
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/imeeting/mobile/resource/js/header/SummaryListNavMixin">
			</div>
			
			<kmss:authShow roles="ROLE_KMIMEETING_SUMMARY_CREATE">
		        <div data-dojo-type="km/imeeting/mobile/resource/js/CreateSummaryButton"
					data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				  	data-dojo-props="key:'10',iconclass:'ekp-ledger-fast-nav-btn',createUrl:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&isRelationFile=1&fdTemplateId=!{curIds}',mainModelName:'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
				  	modelName:'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate'" style="bottom:11rem;right:0.5rem">
				  	新建
			  	</div>
			</kmss:authShow>
		</div>
		
		<%--  页签内容展示区域，可纵向上下滑动   --%>
		<div data-dojo-type="mui/list/NavView">
			<%--  默认列表模板   --%>
			<ul data-dojo-type="mui/list/HashJsonStoreList" 
				data-dojo-mixins="km/imissive/mobile/resource/js/MissiveItemListMixin">
			</ul>
		</div>
		
	</template:replace>
</template:include>
