/**
 * 2020-1-13
 */
define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	dojoConfig.baseUrl+ "km/imissive/mobile/resource/js/ImissiveNotClickItem.js"
	], function(declare, _TemplateItemListMixin, ProcessItemMixin) {
	
	return declare("mui.list.ProcessItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: ProcessItemMixin
	});
});