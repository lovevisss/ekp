/**
 * 筛选静态数据源（普通用户）
 */
define([ "dojo/_base/declare", "mui/i18n/i18n!km-imeeting:mobile" ], function(
		declare, msg) {
	return declare("km.imeeting.mobile.summary.js.header.SummaryPropertyMixin_admin", null, {
		modelName : "com.landray.kmss.km.imeeting.model.KmImeetingTemplate",
		filters : [
			{
				filterType: "FilterRadio",
		        name: "docStatus",
		        subject: msg['mobile.status'],
		        options: [
		            {name: msg['mobile.status.draft'], value: "10"},
		            {name: msg['mobile.status.approval'], value: "20"},
		            {name: msg['mobile.status.overrule'], value: "11"},
		            {name: msg['mobile.status.publish'], value: "30"},
		            {name: msg['mobile.status.discard'], value: "00"}
		        ]
			}, {
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
