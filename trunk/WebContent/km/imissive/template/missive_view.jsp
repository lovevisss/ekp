<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@ page import="com.landray.kmss.sys.ui.util.PCJsCompressUtil" %>
<%@ page import="java.util.Arrays" %>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit" />
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
	<c:if test="${compressSwitch eq 'true'}">
		<%
			String[] imisive_view_JsArray = {"sys/ui/js/top.js" ,
					"sys/ui/js/menu.js" ,
					"sys/ui/js/spa/adapters/menuSourceAdapter.js" ,
					"sys/ui/js/popup.js" ,
					"sys/ui/js/spa/adapters/menuItemAdapter.js" ,
					"sys/ui/js/spa/adapters/menuAdapter.js" ,
					"sys/ui/js/data/source.js" ,
					"sys/ui/js/framework/adapters/topAdapter.js" ,
					"km/imissive/resource/js/slidePage.js" ,
					"sys/ui/js/listview/listview.js" ,
					"sys/ui/js/spa/adapters/listviewAdapter.js" ,
					"sys/ui/js/panel.js"};
		%>
		<script src="${LUI_ContextPath}<%= PCJsCompressUtil.getScriptSrc("resource/dynamic_compress/imissive_view_gkp_min.js", Arrays.asList(imisive_view_JsArray),false) %>?s_cache=${ LUI_Cache }"></script>
		<template:block name="preloadJs" />
	</c:if>
	<script type="text/javascript">
seajs.use(['theme!form']);
Com_IncludeFile("jquery.js|validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
</script>
<title>
	<template:block name="title" />
</title>
<template:block name="head" />
</head>
<body class="lui_form_body ${( not empty param.rightNavMode) ? 'right_model' :''}">
<!-- 错误信息返回页面 -->
<c:import url="/resource/jsp/error_import.jsp" charEncoding="UTF-8" ></c:import>
<c:set var="frameWidth" scope="page" value="${(empty param.width) ? '90%' : (param.width)}"/>
<c:set var="frameShowTop" scope="page" value="${(empty param.showTop) ? 'yes' : (param.showTop)}"/>
<c:set var="showPraise" scope="page" value="${(empty param.showPraise) ? 'no' : (param.showPraise)}"/>

<template:block name="toolbar" />
<c:if test="${param.pathFixed == 'yes'}">
	<div class="lui_form_path_frame_fixed" >
		<div class="lui_form_path_frame_fixed_outer" style="width:${ frameWidth }; min-width:980px; max-width:${fdPageMaxWidth };margin:0px auto;">
				<div class="lui_form_path_frame_fixed_inner">
					<template:block name="path" />
				</div>
		</div>
	</div>
</c:if>
<c:if test="${empty param.pathFixed or param.pathFixed == 'no'}">
	<div class="lui_form_path_frame" style="width:${ frameWidth }; min-width:980px; max-width:${fdPageMaxWidth };margin:0px auto;">
		<template:block name="path" />
	</div>
</c:if>

<div id="lui_validate_message" style="width:${ frameWidth }; min-width:980px;max-width:${fdPageMaxWidth}; margin:0px auto;"></div>

<div id="main" data-lui-mark-main="1"
	 class="main lui_form_imissive lui-slide-main ${param.rightShow != 'yes' &&  param.leftShow != 'yes' ? 'lui-slide-main-spread' : ''}" 
	 style="width:${ frameWidth }; min-width:980px;max-width:${fdPageMaxWidth}; margin:0px auto;">
		<c:if test="${not empty param.formUrl}">
			<form name="${param.formName}" method="post" action ="${param.formUrl}">
		</c:if>
				<c:if test="${param.rightBar == 'yes' }">
					<c:set var="rightWidth" 
						   value="${not empty param.rightWidth ? param.rightWidth : '445px' }"/>
					<div class="bar bar-right ${param.rightNavMode}" id="spreadRight"
						 data-lui-slide-bar="right" 
						 style="right:${param.rightShow == 'yes' ? 0 : lfn:concat('-' , rightWidth)}; width:${rightWidth}">
						<template:block name="barRight" />
					</div>
				</c:if>
				<div class="content ${param.rightNavMode}" data-lui-silde-content="1">
					<div>
						<template:block name="content"/>



						<div class="slide-btn-container">
							<c:if test="${param.rightBar == 'yes' }">
								<div class="slide-btn-right-container">
									<i class="slide-btn right"  data-lui-slide-btn="right"></i>
								</div>
							</c:if>
							<c:if test="${param.leftBar != 'no' }">
								<div class="slide-btn-left-container">
									<i class="slide-btn left"  data-lui-slide-btn="left"></i>
								</div>
							</c:if>
						</div>
					</div>
				</div>
		<c:if test="${not empty param.formUrl}">		
	 		 </form>
		</c:if>
</div>

<script type="text/javascript">

LUI.ready(function(){
	if("${param.rightShow}" == 'yes'){
		$('.content').css('margin-right',($('.bar-right').width()+20)+'px');
	}else{
		$("[data-lui-slide-btn='left']").hide();
		$('.content').css('margin-right','0px');
	}
	
	if("${param.rightNavMode}" == "vertical"){
		// 操作栏鼠标经过效果
	    function actionbarHover(){
	    	setTimeout(function(){
	    		var _itemAction = $('#spreadRight .lui_tabpanel_vertical_icon_navs_c .lui_tabpanel_vertical_icon_navs_item_l');
	    		_itemAction.hover(function(){
	             $('#spreadRight').css('z-index','2');
	           }, function(){
	             $('#spreadRight').css('z-index','1');
	           });
	    	},500);
	    };
	    actionbarHover();
	    
	    function resizeHeight(){
	   	 var h = $('#spreadRight').height();
	   	 if($('#spreadRight .lui_tabpanel_vertical_icon_content_c').length > 0){
	   		 $('#spreadRight .lui_tabpanel_vertical_icon_content_c').css('height',h+"px");
	   		 if(resizeH){
	   			 clearInterval(resizeH);
	   		 }
	   	 }
	   }
	    $(window).resize(function(){
	   		 resizeHeight();
	    });
	     
	    var resizeH = setInterval(function(){
	    	resizeHeight();
		},500);
	}
	 $(window).resize(function(){ 
		 $('.content').css('margin-right',($('.bar-right').width()+20)+'px');
		
		//金格自适应
		if($('#attachment_content')){
			$('#attachment_content').height( (contentH)+"px");
		}
		if($('#previewAttFrame')){
			$('#previewAttFrame').height( (contentH-135)+"px");
		}
		if($('#previewAttListFrame')){
			$('#previewAttListFrame').height( (contentH-135)+"px");
		}
		var contentH = $('.content').height();
		var obj1 = document.getElementById("JGWebOffice_editonline");
		var obj2 = document.getElementById("JGWebOffice_mainonline");
		if(obj1){
			obj1.setAttribute("height", (contentH-120)+"px");
		}
		if(obj2){
			obj2.setAttribute("height", (contentH-120)+"px");
		}
		 if($('#pdfFrame')){
			 var obj3 =document.getElementById("pdfFrame");
			 if(obj3){
				 obj3 =document.getElementById("pdfFrame").contentWindow.document.getElementById("JGWebPdf_mainonline");
				 obj3.setAttribute("height", (contentH-120)+"px");
			 }
		 }
    });
	
	 seajs.use(["km/imissive/resource/js/slidePage.js"], function(slidePage) {
 		setTimeout(function(){
	 		var rightNavMode = "horizontal";
			if("${param.rightNavMode}" == "vertical"){
				rightNavMode = "vertical";
			}
			slidePage({
				contentShow : ${param.contentShow == 'no' ? false : true },
				rightShow :  ${param.rightShow == 'yes' ? true : false },
				rightNavMode:rightNavMode  
			});
 		},100);
	});
	 <%
		/* 顶部页签模式 和 右侧审批模式 需要调整按钮显示方式 */
		if("tab".equals(KmImissiveConfigUtil.getDisplayMode()) || "singletab".equals(KmImissiveConfigUtil.getDisplayMode())) {
		%>
		seajs.use(['lui/jquery'], function($) {
			var isChrome = navigator.userAgent.indexOf("Chrome") > -1,
				isIE = !!window.ActiveXObject || "ActiveXObject" in window;
			// 顶部页签模式 和 右侧审批模式 需要调整按钮显示方式
			if(isChrome || isIE) {
				var _timeout1, _timeout2;
				var updateStyle1 = function() {
					var toolbar_popup = $("div.lui_toolbar_popup_float");
					if(toolbar_popup.length > 0) {
						toolbar_popup.addClass("lui_toolbar_popup_horizontal");
						if(_timeout1) {
							clearTimeout(_timeout1);
						}
					} else {
						_timeout1 = setTimeout(function() {updateStyle1();}, 200);
					}
				}
				var updateStyle2 = function() {
					var navs_list = $("ul.lui_tabpanel_collapse_navs_list");
					if(navs_list.length > 0) {
						navs_list.addClass("lui_tabpanel_collapse_navs_list_horizontal");
						if(_timeout2) {
							clearTimeout(_timeout2);
						}
					} else {
						_timeout2 = setTimeout(function() {updateStyle2();}, 200);
					}
				}
				updateStyle1();
				updateStyle2();
			}
		});
	<% } %>
});
	
	
<c:choose>
	<c:when test="${param['showQrcode'] == true}">
		LUI.ready(function(){
			seajs.use('lui/qrcode',function(qrcode){
				qrcode.QrcodeToTop();
			});
		});
	</c:when>
	<c:when test="${empty param['showQrcode'] && systemQrcode=='1' && (empty showq||showq=='1')}">
		LUI.ready(function(){
			seajs.use('lui/qrcode',function(qrcode){
				qrcode.QrcodeToTop();
			});
		});
	</c:when>
</c:choose>

	function TextArea_BindEvent(){
		LUI.$('textarea[data-actor-expand="true"]').each(function(index,element){
			var me = LUI.$(element);
			if(me.height()>200){
				return;
			}
			me.focus(function(){
				var _self = LUI.$(element);
				var _parent = LUI.$(element.parentNode);
				var height = _parent.attr('data-textarea-height');
				if(!height){
					height = _self.height();
					_parent.attr('data-textarea-height', height);
				}
				_parent.css({'height':height+'px', 'overflow-y':'visible'});
				_parent.attr('height',height);
				if(_parent.css('position')=='static' || _parent.css('position') == '' ){
					_parent.css('position','relative');
				}
				_self.css({'position':'absolute', 'z-index':'1000', 'height':'300px','top':_self[0].offsetTop});
			});
			me.blur(function(){
				var _self = LUI.$(element);
				var _parent = LUI.$(element.parentNode);
				var height = _parent.attr('data-textarea-height');
				_parent.css({'height':'', 'overflow-y':''});
				_self.css({'position':'', 'z-index':'', 'height':height,'top':''});
			});
		});
	}
	LUI.ready(function(){
		//Sidebar_Refresh();
		TextArea_BindEvent();
	});
</script>
<div style="height:20px;"></div>
<c:if test="${frameShowTop=='yes' }">
<ui:top id="top"></ui:top>
<c:if test="${showPraise eq 'yes' }">
<c:import url="/sys/praise/sysPraiseInfo_common_btn.jsp"></c:import>
</c:if>
</c:if>

<template:block name="bodyBottom" />
</body>
</html>