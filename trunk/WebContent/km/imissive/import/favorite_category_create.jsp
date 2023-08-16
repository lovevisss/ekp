<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/cate.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	<%
		String mainModelName = request.getParameter("mainModelName");
		mainModelName = org.apache.commons.lang.StringEscapeUtils.escapeHtml(mainModelName);
		
		SysDictModel dict = SysDataDict.getInstance().getModel(mainModelName);
		String url = dict.getUrl();
		String addUrl = url.substring(0, url.indexOf(".do"))
				+ ".do";
		addUrl += "?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}";
		if (!addUrl.startsWith("/")) {
			addUrl += "/";
		}
		request.setAttribute("addUrl", addUrl);
	%>
<script>
seajs.use(['lui/jquery','lui/util/str','lui/dialog'], function($,str,dialog) {
	
	window.favoriteUrlVariableResolver = str.variableResolver;
	
	window.openCreate = function(id){
		var params = {
			id: id
		};
		var url = "${LUI_ContextPath}${addUrl}";
		url = favoriteUrlVariableResolver(url, params);
		
		window.open(url,"_blank");
	};
	
	window.openCategory = function(){
		if("${JsParam.isSimpleCategory}" == 'false' || '${JsParam.cateType}' == 'globalCategory'){
			dialog.categoryForNewFile('${JsParam.modelName}','${addUrl}',false,null,null,null,null,null,true,null,null,'${JsParam.key}');
		}else{
			dialog.simpleCategoryForNewFile('${JsParam.modelName}','${addUrl}',false,null,null,null);
		}
	};
	
	window.setFavouriteCategory = function(){
		//window.open("${LUI_ContextPath}/sys/person/setting.do?setting=sys_person_favorite_category","_blank");
		handleSettingFavorite();
	};
	
	window.refreshFavourite = function(){
		if(LUI('favouriteCate').source){
			LUI('favouriteCate').source.get();
		}
	};
});

</script>
<div>
	<div id="favouriteCateDiv">
		<ui:dataview id="favouriteCate">
			<ui:source type="AjaxJson">
				{url: '/sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=favoriteWithCate&modelName=${JsParam.modelName}&key=${JsParam.key }'}
			</ui:source>
			<ui:render type="Template">
				{$
					<div class="gkp-cate-list-wrap">
						<div class="gkp-cate-list-head">
				            <span class="contentTitle"></span>
				            <span class="gkp-cate-list-head-decorate"></span>
				        </div>
				        <div class="gkp-cate-list-content">
				$}
				 if( data.length > 0){
					 {$
						 <ul class="gkp-cate-list">
					 $}
					 	for(var i=0;i < data.length;i++){
					 		{$
					 		 <li><a href="javascript:;" target="_blank" onclick="javascript:openCreate('{%data[i].value%}'+ '&fdModelName=${param.fdModelName}' + '&isRelationFile=1');">{%env.fn.formatText(data[i].text)%}</a></li>
					 		$}
						}
					 {$
					 	</ul>
					 $}
				 }
				{$
						</div>
						<div class="gkp-cate-list-footer">
			          	
				            <span class="gkp-cate-btn" onclick="openCategory();">全部模块</span>
				           
				            <a class="gkp-cate-setting-btn" href="javascript:void(0)" onclick="handleSettingFavorite();">设置</a>
				        </div>
				     </div>
				$}
			</ui:render>
			<ui:event event="load">
				$('.contentTitle').html(decodeURIComponent('${JsParam.contentTitle}'));
			</ui:event>
		</ui:dataview>
	</div>
</div>		

<input type="hidden" name="fdCategoryIds" value="">
<input type="hidden" name="fdCategoryNames" value="">

<script>

	var favoriteTmp = {};
	
	function doSettingFavorite(modelName) {
				
		var authType = 0;
		
		switch(modelName) {
			case 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate': 
			case 'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate':
			case 'com.landray.kmss.km.imissive.model.KmImissiveSignTemplate':
			case 'com.landray.kmss.km.review.model.KmReviewTemplate':
				authType = 2;
				break;
			default: 
				authType = 0; 
				break;	
		}
		
		var opt = {
			modelName: modelName,
			idField: 'fdCategoryIds',
			nameField: 'fdCategoryNames',
			mulSelect: true,
			authType: authType,
			noFavorite: true,
			notNull: false,
			action: function(params) {

				if(!params) {
					return;
				}

				var ids = (params.id || '').split(';');
				var names = (params.name || '').split(';');
				var _favoriteTmp = {};
				
				$.each(ids, function(i, id){
					
					if(!id || !names[i]){
						return;
					}
					
					_favoriteTmp[id] = names[i];								
				});
				
				var addIds = [];
				var addNames = [];
				$.each(_favoriteTmp, function(key, value){
					if(!favoriteTmp[key]){
						addIds.push(key);
						addNames.push(value);
					}
				});
				
				if(addIds.length > 0) {
					quickAddOrRemoveFavorite('add', modelName, addIds, addNames);
				}
				
				var removeIds = [];
				var removeNames = [];
				$.each(favoriteTmp, function(key, value){
					if(!_favoriteTmp[key]){
						removeIds.push(key);
						removeNames.push(value);
					}
				});
				
				if(removeIds.length > 0) {
					quickAddOrRemoveFavorite('remove', modelName, removeIds, removeNames);
				}
				
				favoriteTmp = _favoriteTmp;
				refreshFavourite();
				
			}
		};
		
		if('${JsParam.isSimpleCategory}' == 'false' || '${JsParam.cateType}' == 'globalCategory') {
			seajs.use(['lui/dialog'], function(dialog) {
				dialog.category(opt);
			});
		} else {
			seajs.use(['lui/dialog'], function(dialog) {
				dialog.simpleCategory(opt);
			});
			
		}
		
	}
	
	function quickAddOrRemoveFavorite(action, modelName, ids, names) {
		
		var url = null;
		
		if(action == 'add') {
			url = 'sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=quickAdd';
		} else if(action == 'remove') {
			url = 'sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=quickRemove';
		}
		
		if(!url) {
			return;
		}
		
		var data = {
			modelName: modelName,
			ids: ids,
			names: names
		};
		
		$.ajax({
			type : "POST",
			url : Com_Parameter.ContextPath + url,
			data : $.param(data, true),
			dataType : 'json',
			async: false,
			success : function(result) {
			},
			error : function(result) {
				console.error(result);
			}
		});
	}
	
	function getFavorite() {
		$.ajax({
			url: Com_Parameter.ContextPath + 'sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=favorite&modelName=${JsParam.modelName}',
			async: false,
			success: function(data) {
				var ids = [];
				var names = [];
				favoriteTmp = {};
				$.each(data, function(i, d){
					
					favoriteTmp[d.value] = d.text;
					
					ids.push(d.value);
					names.push(d.text);
				});
				
				$('input[name="fdCategoryIds"]').val(ids.join(';'));
				$('input[name="fdCategoryNames"]').val(names.join(';'));
			},
			error: function(err) {
				console.error(err);
			}
		});
		
		
	}
	
	window.handleSettingFavorite = function() {
		// 重新获取常用分类数据
		getFavorite();
		doSettingFavorite('${JsParam.modelName}');
	}
</script>
	</template:replace>
</template:include>		


