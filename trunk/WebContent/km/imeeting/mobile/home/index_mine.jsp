<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<!-- 全文搜索 -->
<div data-dojo-type="mui/header/Header">
	<div data-dojo-type="mui/search/SearchBar"
		data-dojo-props="modelName:'com.landray.kmss.km.imeeting.model.KmImeetingMain',height:'5rem'">
	</div>
</div>

<!-- 快捷方式豆腐块 -->
<div class="imeetingShortcut"
	data-dojo-type="km/imeeting/mobile/resource/js/shortcut/Shortcut"
	data-dojo-mixins="km/imeeting/mobile/resource/js/shortcut/ShortcutMixin">
</div>

<!-- 页眉：即将开始、我已参见、我发起的-->
<div data-dojo-type="mui/header/Header"
	data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	<div data-dojo-type="mui/nav/MobileCfgNavBar"
		data-dojo-props="defaultUrl:'/km/imeeting/mobile/main/index_nav.jsp'">
	</div>
</div>

<%--  页签内容展示区域，可纵向上下滑动   --%>
<div data-dojo-type="mui/list/NavView">
	<%--  默认列表模板   --%>
	<ul data-dojo-type="mui/list/HashJsonStoreList" class="muiList"
		data-dojo-mixins="km/imeeting/mobile/resource/js/MeetingItemListMixin">
	</ul>
</div>