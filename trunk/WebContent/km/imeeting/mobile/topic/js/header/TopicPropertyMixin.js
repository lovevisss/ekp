/**
 * 筛选静态数据源（普通用户）
 */
define([ "dojo/_base/declare", "mui/i18n/i18n!km-imeeting:mobile" ], function(
		declare, msg) {
	return declare("km.imeeting.mobile.topic.js.header.TopicPropertyMixin", null, {
		modelName : "com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory",
		filters : [ {
		    filterType: "FilterDatetime",
		    type: "date",
		    name: "docCreateTime",
		    subject: msg['mobile.docCreateTime']
		}]
	})
})
