define([ "dojo/_base/declare", "dojo/store/Memory", "mui/i18n/i18n!km-imeeting:mobile" ],
	function(declare, Memory, Msg) {
		return declare("km.imeeting.mobile.topic.js.header.IndexListNavMixin", null, {
			store : new Memory({
				data : [{
					url : '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=list&q.docStatus=30&orderby=docCreateTime&ordertype=down',
					text : Msg["mobile.topic.lib"]
				}]
		})
	})
})