<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<bean:message bundle="km-imeeting" key="mobile.schemeApproval"/>
	</template:replace>
	<template:replace name="head">	
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="content">
		
	  	<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	  		<%-- 搜索 --%>
			<div data-dojo-type="mui/search/SearchBar"
				data-dojo-props="placeHolder:'<bean:message key="button.search"/>',modelName:'com.landray.kmss.km.imeeting.model.KmImeetingScheme',needPrompt:false,height:'4rem',showLayer:false">
			</div>
			
			<kmss:authShow roles="ROLE_KMIMEETING_SCHEME_CREATE">
		    	<!-- 督办立项 -->
		        <div data-dojo-type="km/imeeting/mobile/resource/js/CreateSchemeButton"
					data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				  	data-dojo-props="key:'10',iconclass:'ekp-ledger-fast-nav-btn',createUrl:'/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=add&i.docTemplate=!{curIds}&fdTemplateId=!{curIds}',mainModelName:'com.landray.kmss.km.imeeting.model.KmImeetingScheme',
				  	modelName:'com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate'" style="bottom:11rem;right:0.5rem">
				  	新建
			  	</div>
			</kmss:authShow>
		</div>
		
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	  		<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-mixins="km/imeeting/mobile/resource/js/header/SchemeAuditNavMixin">
			</div>
		</div>
		
		<div class="mui_ekp_meeting_cardList" data-dojo-type="mui/list/NavView">
			<ul data-dojo-type="mui/list/HashJsonStoreList" 
			   	data-dojo-mixins="km/imeeting/mobile/resource/js/list/SchemeItemListMixin">
			</ul>
		</div>
		
	</template:replace>
</template:include>
