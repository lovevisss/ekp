define("km/imeeting/mobile/resource/js/list/PlaceBarStore", [
				"dojo/_base/declare",
                "km/imeeting/mobile/resource/js/list/PlaceNavBar",
				"./_PlaceStoreNavBarMixin"
                ], function(declare,PlaceNavBar,StoreNavBarMixin) {
	return declare("km.imeeting.PlaceBarStore", [PlaceNavBar, StoreNavBarMixin], {
		height:'4.0rem'
	});
});
