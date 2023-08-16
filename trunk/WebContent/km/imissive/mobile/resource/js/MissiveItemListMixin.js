define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/imissive/mobile/resource/js/MissiveItemMixin"
	], function(declare, _TemplateItemListMixin, MissiveItemMixin) {
	
	return declare("mui.list.MissiveItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: MissiveItemMixin
	});
});