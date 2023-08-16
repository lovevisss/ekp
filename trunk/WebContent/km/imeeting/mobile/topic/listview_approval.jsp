<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<!-- 全文搜索 -->
<div data-dojo-type="mui/header/Header">
	<div data-dojo-type="mui/search/SearchBar"
		data-dojo-props="modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTopic',height:'5rem'">
	</div>
</div>

<!-- 页眉：即将开始、我已参见、我发起的-->
<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	<div data-dojo-type="mui/nav/MobileCfgNavBar"
		 data-dojo-mixins="km/imeeting/mobile/topic/js/header/IndexListNavMixin">
	</div>
	<kmss:authShow roles="ROLE_KMIMEETING_TOPIC_CREATE">
        <div data-dojo-type="km/imeeting/mobile/resource/js/CreateSchemeButton"
			data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
		  	data-dojo-props="key:'10',iconclass:'ekp-ledger-fast-nav-btn',createUrl:'/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&i.docTemplate=!{curIds}&fdTemplateId=!{curIds}',mainModelName:'com.landray.kmss.km.imeeting.model.KmImeetingTopic',
		  	modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory'" style="bottom:11rem;display:flex">
		  	<bean:message key="mobile.create" bundle="km-imeeting" />
	  	</div>
	</kmss:authShow>
</div>

<%--  页签内容展示区域，可纵向上下滑动   --%>
<div data-dojo-type="mui/list/NavView">
	<%--  默认列表模板   --%>
	<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList"
		data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
	</ul>
</div>