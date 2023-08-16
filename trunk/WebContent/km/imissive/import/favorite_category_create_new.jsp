<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>

<div>
	<div id="favouriteCateDiv">
		<ui:dataview id="favouriteCate_${JsParam.key}">
			<ui:source type="AjaxJson">
				{url: '/sys/person/sys_person_favorite_category/sysPersonFavoriteCategory.do?method=favoriteWithCate&modelName=${JsParam.modelName}&key=${JsParam.key }&getAddUrl=true'}
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
					 		 <li><a href="javascript:void(0);" onclick="javascript:openCreate('{%data[i].value%}','${JsParam.addUrl}');">{%env.fn.formatText(data[i].text)%}</a></li>
					 		$}
						}
					 {$
					 	</ul>
					 $}
				 }
				{$
						</div>
						<div class="gkp-cate-list-footer">
			          	
				            <span class="gkp-cate-btn" onclick="openCategory('${JsParam.modelName}','${JsParam.isSimpleCategory}','${JsParam.addUrl}');">全部模块</span>
				           
				            <a class="gkp-cate-setting-btn" href="javascript:void(0)" onclick="handleSettingFavorite('${JsParam.modelName}','${JsParam.key}','${JsParam.isSimpleCategory}');">设置</a>
				        </div>
				     </div>
				$}
			</ui:render>
			<ui:event event="load">
				$('#favouriteCate_${JsParam.key} .contentTitle').html(decodeURIComponent('${JsParam.contentTitle}'));
			</ui:event>
		</ui:dataview>
	</div>
</div>		



		


