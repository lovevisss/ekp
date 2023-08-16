define(	["dojo/_base/declare",
		"mui/list/_TemplateItemListMixin",
		dojoConfig.baseUrl+ "km/imissive/mobile/resource/js/ImissiveOpinionItemOptMixin.js"],
						
		function(declare, _TemplateItemListMixin, ImissiveOpinionItemOptMixin) {

			return declare("km.imissive.ImissiveOpinionItemListOptMixin",
				[_TemplateItemListMixin], {

					itemRenderer : ImissiveOpinionItemOptMixin
				});
		});