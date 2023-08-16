/**
 * 筛选静态数据源（普通用户）
 */
define([ "dojo/_base/declare", "mui/i18n/i18n!km-imeeting:mobile" ], function(
		declare, msg) {
	return declare("km.imeeting.mobile.main.js.header.MainPropertyMixin", null, {
		modelName : "com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory",
		filters : [
			{
				  filterType: "FilterSearch",
				  name: "fdMeetingNum",
				  subject: "会议编号"
			}, {
				filterType: "FilterAddress",
				type:"ORG_TYPE_PERSON",
				name: "fdHost",
				subject: "主持人"
			}, {
			    filterType: "FilterDatetime",
			    type: "date",
			    name: "fdHoldDate",
			    subject: "召开时间"
			}
		]
	})
})
