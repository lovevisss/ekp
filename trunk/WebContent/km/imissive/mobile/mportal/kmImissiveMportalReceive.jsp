<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="sys/mportal/mobile/card/JsonStoreCardList"
	data-dojo-mixins="sys/mportal/mobile/card/SimpleItemListMixin"
	data-dojo-props="url:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMainPortlet.do?method=getlatest&mPortal=true&fdCategoryId=${param.cateid}&rowsize=${param.rowsize}&scope=${param.scope}',lazy:false">
</div>