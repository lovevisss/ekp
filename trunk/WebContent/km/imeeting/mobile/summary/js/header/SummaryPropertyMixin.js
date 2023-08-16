/**
 * 筛选静态数据源（普通用户）
 */
define([ "dojo/_base/declare", "mui/i18n/i18n!km-imeeting:mobile" ], function(
		declare, msg) {
	return declare("km.imeeting.mobile.summary.js.header.SummaryPropertyMixin_admin", null, {
		modelName : "com.landray.kmss.km.imeeting.model.KmImeetingTemplate",
		filters : [
			{
				filterType: "FilterAddress",
				type:"ORG_TYPE_PERSON",
				name: "docCreator",
				subject: "纪要人员"
			}, {
				filterType: "FilterAddress",
				type:"ORG_TYPE_PERSON",
				name: "fdHost",
				subject: "主持人"
			}, {
			    filterType: "FilterDatetime",
			    type: "date",
			    name: "docCreateTime",
			    subject: "录入时间"
			}
		]
	})
})
