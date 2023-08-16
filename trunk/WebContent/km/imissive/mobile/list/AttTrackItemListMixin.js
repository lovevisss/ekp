define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/imissive/mobile/list/item/AttTrackItemMixin"
	], function(declare, _TemplateItemListMixin, ProcessItemMixin) {
	
	return declare("km.imissive.list.AttTrackItemMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: ProcessItemMixin
	});
});