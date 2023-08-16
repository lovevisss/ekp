<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	String staticFilterType = "km/imeeting/mobile/main/js/header/MainPropertyMixin";
	String headerJs = "km/imeeting/mobile/main/js/header/IndexListNavMixin_all";
	if (UserUtil.getKMSSUser().isAdmin()) {
		staticFilterType = "km/imeeting/mobile/main/js/header/MainPropertyMixin_admin";
		headerJs = "km/imeeting/mobile/main/js/header/IndexListNavMixin_admin";
	}
	request.setAttribute("staticFilterType", staticFilterType);
	request.setAttribute("headerJs", headerJs);
%>

<div class="kmImeeting_header_box">
	<!-- 全文搜索 -->
	<div id="kmImeeting_header" data-dojo-type="mui/header/Header">
		<div data-dojo-type="mui/search/SearchBar"
			data-dojo-props="modelName:'com.landray.kmss.km.imeeting.model.KmImeetingMain',height:'5rem'">
		</div>
	</div>
	<!-- 属性筛选 -->
	<div  id="kmImeeting_nav" data-dojo-type="mui/header/NavHeader">
		<div class="muiHeaderItemRight" 
			data-dojo-type="mui/property/FilterItem"
			data-dojo-mixins="${staticFilterType}">
		</div>
		<!--  分类筛选-->
		<div class="muiHeaderItemRight" 
			data-dojo-type="mui/catefilter/FilterItem"
			data-dojo-mixins="mui/syscategory/SysCategoryMixin"
			data-dojo-props="modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',catekey: 'fdTemplate'">
		</div>
	</div>

	<!-- 会议状态 -->
	<div class="kmImeetingFilter kmImeetingCri" 
		data-dojo-type="mui/header/NavHeader">
		<div data-dojo-type="mui/property/TagFilterItem" class="imeetingMainStatusText"
			data-dojo-props="
				isTagCount:true,
				name: 'meetingStatus',
				isTagCount:true,
				options:[
					{name:'<bean:message key="mobile.my.status.all" bundle="km-imeeting" />', value:''},
					{name:'<bean:message key="kmImeeting.status.publish.unHold" bundle="km-imeeting" />', value:'unHold'},
				 	{name:'<bean:message key="kmImeeting.status.publish.holding" bundle="km-imeeting" />', value:'holding'},
					{name:'<bean:message key="kmImeeting.status.publish.hold" bundle="km-imeeting" />', value:'hold'},
					{name:'<bean:message key="kmImeeting.status.cancel" bundle="km-imeeting" />', value:'41'},
				],
				values:{'meetingStatus':''}">
		</div>
	</div>
</div>

<div data-dojo-type="mui/header/Header" data-dojo-props="height:'0rem'">
	<div  style="display: none;" data-dojo-type="mui/nav/MobileCfgNavBar"
		 data-dojo-mixins="${headerJs}">
	</div>
	
	<!-- 新建摁钮 -->
	<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
        <div class="ekp-ledger-fast-nav-btn" onclick="createMain();">
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
	require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
		window.createMain = function() {
			SysCategoryUtil.create({
				key: 'createMeeting',
                createUrl: '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',
                modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
                mainModelName: 'com.landray.kmss.km.imeeting.model.KmImeetingMain',
                showFavoriteCate:'true',
       		  	authType: '02'
           });
		}
	});
</script>
