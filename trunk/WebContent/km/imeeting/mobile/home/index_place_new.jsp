<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imeeting.util.ImeetingCateUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<% 
	request.setAttribute("userId", UserUtil.getUser().getFdId());
	request.setAttribute("defaultCateId", ImeetingCateUtil.getfirstCate()); 
	request.setAttribute("nowDate", DateUtil.convertDateToString(new Date(), ResourceUtil.getString("date.format.date")));
%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" > 
	<template:replace name="title">
		<c:if test="${JsParam.moduleName!=null && JsParam.moduleName!=''}">
			${HtmlParam.moduleName}
		</c:if>
		<c:if test="${JsParam.moduleName==null or JsParam.moduleName==''}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/index.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-imeeting.js"/>
		<style>
			.muiMeetingBookInformation {
				bottom:0;
			}
			
			.muiSelInputRight.muiSelInputRightShow {
				margin-top: 1.35rem;
			}
		</style>
	</template:replace>
	<template:replace name="content">
		
		<c:set var="canCreateMeeting" value="false"></c:set>
		<c:set var="canCreateBook" value="false"></c:set>
		
		<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
			<c:set var="canCreateMeeting" value="true"></c:set>
		</kmss:authShow>
		<kmss:authShow roles="ROLE_KMIMEETING_BOOK_CREATE">
			<c:set var="canCreateBook" value="true"></c:set>
		</kmss:authShow>
		
		<div id="place" data-dojo-type="mui/tabbar/TabBarView">

			<div data-dojo-type="mui/header/Header" class="meetingHeader" data-dojo-props="height:'4rem'"  style="border-bottom: none">
				 
				 <div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceCateSelect" class="placeCateSelect" style="height:100%"
				 	  data-dojo-props="url:'/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=getAllCate',name:'fdPeriodId',mul:false,showStatus:'edit',value:'${defaultCateId}'">
				 </div>
				 
		 		 <div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceDatePicker" class="placeCateSelect" style="height:100%"
		 		 		data-dojo-mixins="mui/datetime/_DateMixin"
						data-dojo-props="canClear: false, value:'${nowDate }'">
				 </div>
				 
			</div> 
			
			<div class="muiMeetingBookContainer">
				<div id="timeBar" data-dojo-type="km/imeeting/mobile/resource/js/list/TimeBar" ></div>
				<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceBar"  data-dojo-props="curCateId:'${defaultCateId}'">
				</div>
				<div id="placeContent" data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceContentScrollView">
					<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceContent" class="placeContentContainer"></div>
				</div>
			</div>
			
			<%-- 底部按钮和颜色信息 --%>
			<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceBottom"
				data-dojo-mixins="km/imeeting/mobile/resource/js/PlaceBottomMixin"
				data-dojo-props="height:'27.5rem'">
			</div>
			
			<div id="ImeetingCreateFrame">
			
				<c:if test="${canCreateBook == true }">
					<div onclick="createBook()">
						<div class="create_title">会议预约</div>
						<div class="create_desc">直接占用会议室,可用于非会议场景</div>
					</div>
				</c:if>
			
				<c:if test="${canCreateMeeting == true }">
					<div onclick="createNormalMeeting()">
						<div class="create_title">会议通知</div>
						<div class="create_desc">内置会议通知模版,提前统筹各项工作</div>
					</div>
				</c:if>
				
			</div>
			
			<script>
		        require(['dijit/registry', 'dojo/dom', 'dojo/on', 'dojo/dom-attr', 'dojo/topic', 'mui/util', 'dojo/_base/lang',
		                 'mui/dialog/Tip', 'dojo/domReady','mui/syscategory/SysCategoryUtil'],
		        		function(registry, dom, on, domAttr, topic, util, lang, Tip, ready,SysCategoryUtil){
		    		
					var placeNode = dom.byId('place');
					
					window.__MEETING_CREATE_PAYLOAD__ = {};
					
					on(dom.byId('ImeetingCreateFrame'), 'click', function(e) {
						var target = e.target;
						if(target && target.id == 'ImeetingCreateFrame') {
							domAttr.set(placeNode, 'data-create-active', 'false');
						}
					});
		        	
		        	topic.subscribe('/km/imeeting/create', function(ctx, payload) {
		        		if('${canCreateCloud}' == 'true' || '${canCreateMeeting}' == 'true' || '${canCreateBook}' == 'true') {
			        		domAttr.set(placeNode, 'data-create-active', 'true');
			        		window.__MEETING_CREATE_PAYLOAD__ = payload;
		        		} else {
		        			Tip.tip({icon:'mui mui-warn', text:'很抱歉，您没有预约会议权限！',width:'260',height:'60'});
		        		}
		        		
		        	});
		        	
		        	topic.subscribe('/km/imeeting/changeview', function(view) {
		        		if(view != 'place') {
		        			return;
		        		}
		        		
		        		topic.publish('/km/imeeting/place/resize');
		    			topic.publish('/km/imeeting/timeNavBar/resetTransform');
		    			topic.publish('/km/imeeting/placeNavBar/resetTransform');
		        	});
		        	
					window.createBook = function() {
						
						var url = lang.replace('${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=add&' + 
								'fdTime={fdTime}&fdStratTime={fdStartTime}&fdFinishTime={fdFinishTime}&resId={resId}', window.__MEETING_CREATE_PAYLOAD__ || {});
						
						window.open(url, '_self');
					}
					
					window.createNormalMeeting = function(){
						var url = lang.replace('/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&' + 
								'fdTime={fdTime}&fdStratTime={fdStartTime}&fdFinishTime={fdFinishTime}&resId={resId}', window.__MEETING_CREATE_PAYLOAD__ || {});
						var createUrl = url + '&fdTemplateId=!{curIds}';
						SysCategoryUtil.create({
							  key: "normalMeeting",
			                  createUrl: createUrl,
			                  modelName: "com.landray.kmss.km.imeeting.model.KmImeetingTemplate",
			                  mainModelName: "com.landray.kmss.km.imeeting.model.KmImeetingMain",
			                  showFavoriteCate:'true',
			         		  authType: '02'
			            });
					}
		
					window.onresize = function(){
		    	        	
						var timeBar = registry.byId('timeBar');
						var placeContent = registry.byId('placeContent');
		    			 
						timeBar.setTransformMaxHeight();
						placeContent.resize();
		    			 
		    	    };
		    	    
		    	    // 解决首次进入会议室列表错位情况
		    	    ready(function() {
		    	    	topic.publish('/km/imeeting/changeview', 'place');
		    	    });
		    	    
		    	});
			</script>
			<%-- <ul id="tabs" fixed="bottom"
			data-dojo-type="mui/tabbar/TabBar"
			data-dojo-props='fill:"always",syncWithViews:true'>
		  	<li id="tab2Calendar"
			  		data-dojo-type="mui/tabbar/TabBarButton" 
			  		data-dojo-props="selected: true,href:'/km/imeeting/mobile/index.jsp',
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
			<c:choose>
				<c:when test="${imissiveSummaryEnable == 'true'}">
					<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  			data-dojo-props="href:'/km/imeeting/mobile/summary/imissive/index.jsp',transition: 'none',
					  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
					  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
					  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
					  	</li>
					</kmss:authShow>
				</c:when>
				<c:otherwise>
					<li data-dojo-type="mui/tabbar/TabBarButton"
				  			data-dojo-props="href:'/km/imeeting/mobile/summary/index.jsp',transition: 'none',
				  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
				  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
				  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
				  	</li>
				</c:otherwise>
			</c:choose>
		</ul> --%>
			<%-- <div class="lui_db_footer">
			    <div class="lui_db_footer_item" onclick="navigate2View(0,'${JsParam.showList}')">
			      <div class="lui_db_footer_item_img my"></div>
			      <p><bean:message bundle="km-imeeting" key="mobile.myMeeting" /></p>
			    </div>
			    <div class="lui_db_footer_item active" onclick="navigate2View(1,'${JsParam.showList}')">
			      <div class="lui_db_footer_item_img place"></div>
			      <p><bean:message bundle="km-imeeting" key="mobile.meetingRoom" /></p>
			    </div>
			    <div class="lui_db_footer_item" onclick="navigate2View(2,'${JsParam.showList}')">
			        <div class="lui_db_footer_item_img summary"></div>
			        <p><bean:message bundle="km-imeeting" key="mobile.meetingSummary" /></p>
			    </div>
			    <div class="lui_db_footer_item" onclick="navigate2View(3,'${JsParam.showList}')">
			        <div class="lui_db_footer_item_img more"></div>
			        <p><bean:message bundle="km-imeeting" key="mobile.other" /></p>
			    </div>
			</div> --%>
			<script>
				window.navigate2View = function(view,showList) {
					var url ="${LUI_ContextPath}/km/imeeting/mobile/";
					if(0 == view){
						if(showList == 'true'){
							url += "index_list_my.jsp"
						}else{
							url += "index.jsp"
						}
					}else if(1 == view){
						url += "index_place_new.jsp"
					}else if(2 == view){
						url += "index_summary.jsp"
					}else if(3 == view){
						url += "index_other.jsp"
					}
					if(showList == 'true'){
						url += "?showList="+showList;
					}
					window.open(url, '_self');
				}
			</script>
		</div>
		
	</template:replace>
</template:include>