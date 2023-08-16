<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSendMainService"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/cate.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="body">
		
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<div class="createPanelContainer">
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
				<div class="createPanelItem">
					<c:import url="/km/imissive/import/favorite_category_create_new.jsp" charEncoding="utf-8">
						<c:param name="mainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"></c:param>
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"></c:param>
						<c:param name="isSimpleCategory" value="false"></c:param>
						<c:param name="contentTitle" value="发文拟稿"></c:param>
						<c:param name="key" value="send"></c:param>
						<c:param name="addUrl" value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}"></c:param>
					</c:import>
				</div>
			</kmss:authShow>
			<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
				<div class="createPanelItem">
					<c:import url="/km/imissive/import/favorite_category_create_new.jsp" charEncoding="utf-8">
						<c:param name="mainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"></c:param>
						<c:param name="isSimpleCategory" value="false"></c:param>
						<c:param name="contentTitle" value="收文登记"></c:param>
						<c:param name="key" value="receive"></c:param>
						<c:param name="addUrl" value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}"></c:param>
					</c:import>
				</div>
			</kmss:authShow>
			<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">	 
				<div class="createPanelItem">
					<c:import url="/km/imissive/import/favorite_category_create_new.jsp" charEncoding="utf-8">
						<c:param name="mainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
						<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"></c:param>
						<c:param name="isSimpleCategory" value="false"></c:param>
						<c:param name="contentTitle" value="签报拟稿"></c:param>
						<c:param name="key" value="sign"></c:param>
						<c:param name="addUrl" value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}"></c:param>
					</c:import>
				</div>
			</kmss:authShow>
			<input type="hidden" name="fdCategoryIds" value="">
			<input type="hidden" name="fdCategoryNames" value="">
		</div>
 <script>
	seajs.use(['lui/jquery','lui/util/str','lui/dialog'], function($,str,dialog) {
		
		
		window.favoriteUrlVariableResolver = str.variableResolver;
		
		window.openCreate = function(id,addUrl){
			var params = {
				id: id
			};
			var url = "${LUI_ContextPath}"+addUrl;
			url = favoriteUrlVariableResolver(url, params);
			
			window.open(url,"_blank");
		};
		
		window.openCategory = function(modelName,isSimpleCategory,addUrl){
			if(isSimpleCategory == 'false'){
				dialog.categoryForNewFile(modelName,addUrl,false,null,null,null,null,null,true,null,null,'${JsParam.key}');
			}else{
				dialog.simpleCategoryForNewFile(modelName,addUrl,false,null,null,null);
			}
		};
		
		
		window.refreshFavourite = function(key){
			if(LUI('favouriteCate_'+key).source){
				LUI('favouriteCate_'+key).source.get();
			}
		};
	});

</script>
 <script>
	var favoriteTmp = {};
	function doSettingFavorite(modelName,key,isSimpleCategory) {
		var authType = 2;
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
				refreshFavourite(key);
				
			}
		};
		
		
		if(isSimpleCategory == 'false' ) {
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
	
	function getFavorite(modelName) {
		$.ajax({
			url: Com_Parameter.ContextPath + 'sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=favorite&modelName='+modelName,
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
	
	window.handleSettingFavorite = function(modelName,key,isSimpleCategory) {
		// 重新获取常用分类数据
		getFavorite(modelName);
		doSettingFavorite(modelName,key,isSimpleCategory);
	}
</script>
	</template:replace>
</template:include>