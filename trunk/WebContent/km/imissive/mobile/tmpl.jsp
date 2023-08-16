<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

	<div class="muiCateHeader" style="height: 4rem; line-height: 4rem;">
		<div class="muiCateHeaderContent">
			<div class="muiCateHeaderTitle" style="position: relative;">交换配置</div>
		</div>
	</div>
	<div data-dojo-type="dojox/mobile/ScrollableView">
		<ul data-dojo-type="mui/list/JsonStoreList"
			data-dojo-mixins="km/imissive/mobile/list/RegDetailListItemListMixin"
			data-dojo-props="key:'${param.key}',url:'/km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do?method=getTemplateCfg&type=${param.type}&fdSendId=${param.fdSendId}&fdReceiveId=${param.fdReceiveId }',lazy:false">
		</ul>
	</div>
	
	