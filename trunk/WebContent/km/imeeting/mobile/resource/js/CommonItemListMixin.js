define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/imeeting/mobile/resource/js/CommonItemMixin"
	], function(declare, _TemplateItemListMixin, CommonItemMixin) {
	
	return declare("km.imeeting.mobile.resource.js.CommonItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer : CommonItemMixin
	});
});