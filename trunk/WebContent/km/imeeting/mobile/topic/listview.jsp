<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	String staticFilterType = "km/imeeting/mobile/topic/js/header/TopicPropertyMixin";
	String headerJs = "km/imeeting/mobile/topic/js/header/IndexListNavMixin_all";
	if (UserUtil.getKMSSUser().isAdmin()) {
		staticFilterType = "km/imeeting/mobile/topic/js/header/TopicPropertyMixin_admin";
		headerJs = "km/imeeting/mobile/topic/js/header/IndexListNavMixin_admin";
	}
	request.setAttribute("staticFilterType", staticFilterType);
	request.setAttribute("headerJs", headerJs);
%>

<div class="kmImeeting_header_box">
	<!-- 全文搜索 -->
	<div id="kmImeeting_header" data-dojo-type="mui/header/Header">
		<div data-dojo-type="mui/search/SearchBar"
			data-dojo-props="modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTopic',height:'5rem'">
		</div>
	</div>
	
	<!-- 属性筛选 -->
	<div  id="kmImeeting_nav" data-dojo-type="mui/header/NavHeader">
		<!-- 静态属性筛选 -->
		<div class="muiHeaderItemRight" 
			data-dojo-type="mui/property/FilterItem"
			data-dojo-mixins="${staticFilterType}">
		</div>
		
		<!--  分类筛选-->
		<div class="muiHeaderItemRight" 
			data-dojo-type="mui/catefilter/FilterItem"
			data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
			data-dojo-props="modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',catekey: 'fdTopicCategory'">
		</div>
	</div>
	<div class="kmImeetingFilter kmImeetingCri" 
		data-dojo-type="mui/header/NavHeader">
		<div data-dojo-type="mui/property/TagFilterItem"
			data-dojo-props="
				isTagCount:true,
				name: 'isAccept',
				isTagCount:true,
				options:[
					{name:'全部',value:'all'},
					{name:'已上会',value:'1'},
					{name:'未上会',value:'0'}
				],
				values:{'isAccept':'all'}">
		</div>
	</div>
</div>


<!-- data-dojo-props="defaultUrl:'/km/imeeting/mobile/nav_approval.jsp'">  -->
<div data-dojo-type="mui/header/Header" data-dojo-props="height:'0rem'">
	<div  style="display: none;" data-dojo-type="mui/nav/MobileCfgNavBar"
		data-dojo-mixins="${headerJs}">
	</div>
	
	<!-- 新建摁钮 -->
	<kmss:authShow roles="ROLE_KMIMEETING_TOPIC_CREATE">
		<div class="ekp-ledger-fast-nav-btn" onclick="createTopic();">
			<img alt="" src="${LUI_ContextPath}/km/imeeting/mobile/resource/images/add_btn@2x.png" class="muiImeetingAddIcon">
			<p class="muiImeetingAddText"><bean:message key="mobile.create" bundle="km-imeeting" /></p>
		</div>
	</kmss:authShow>
</div>

<%--  页签内容展示区域，可纵向上下滑动   --%>
<div data-dojo-type="mui/list/NavView">
	<ul data-dojo-type="mui/list/HashJsonStoreList"
		data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
	</ul>
</div>

<script type="text/javascript">
	require(['mui/simplecategory/SimpleCategoryUtil'], function(SimpleCategoryUtil){
		window.createTopic = function() {
			SimpleCategoryUtil.create({
				key: 'createTopic',
                createUrl: '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&i.docTemplate=!{curIds}&fdTemplateId=!{curIds}&mobile=true',
                modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',
                mainModelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTopic',
                showFavoriteCate:false,
        		authType: '02'
           });
		}
	});
</script>

