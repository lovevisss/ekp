define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/imeeting/mobile/resource/js/MeetingItemMixin"
	], function(declare, _TemplateItemListMixin, MeetingItemMixin) {
	
	return declare("km.imeeting.mobile.resource.js.MeetingItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,

		itemRenderer : MeetingItemMixin
	});
});