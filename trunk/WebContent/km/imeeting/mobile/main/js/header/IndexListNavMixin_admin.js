define([ "dojo/_base/declare", "dojo/store/Memory", "mui/i18n/i18n!km-imeeting:mobile" ],
	function(declare, Memory, Msg) {
		return declare("km.imeeting.mobile.main.js.header.IndexListNavMixin", null, {
			store : new Memory({
				data : [{
					url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&orderby=docCreateTime&ordertype=down',
					text : Msg["mobile.main.lib"]
				}]
		})
	})
})