define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/imissive/mobile/list/item/RegDetailListItemMixin"
	], function(declare, _TemplateItemMixin, RegDetailListItemMixin) {
	
	return declare("mui.list.RegDetailListItemMixin", [_TemplateItemMixin], {
		
		itemRenderer : RegDetailListItemMixin
		
	});
});