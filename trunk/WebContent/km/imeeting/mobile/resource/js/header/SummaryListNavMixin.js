define([ "dojo/_base/declare", "dojo/store/Memory", "mui/i18n/i18n!km-imissive:mobile" ],
	function(declare, Memory, Msg) {
		return declare("km.imissive.mobile.include.resource.js.IndexListNavMixin", null, {
			store : new Memory({
				data : [{
					url : '/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&q.docType=myApproval&orderby=docCreateTime&ordertype=down&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain',
					text : Msg["mobile.approval"]
				}, {
					url : '/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&q.docType=myApprovaled&orderby=docCreateTime&ordertype=down&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain',
					text : Msg["mobile.approved"]
			}]
		})
	})
})