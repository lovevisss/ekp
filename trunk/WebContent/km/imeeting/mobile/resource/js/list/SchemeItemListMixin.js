define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"./item/SchemeItemMixin"
	], function(declare, _TemplateItemListMixin, SchemeItemMixin) {
	
	return declare("km.imeeting.list.SchemeItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: SchemeItemMixin
	});
});