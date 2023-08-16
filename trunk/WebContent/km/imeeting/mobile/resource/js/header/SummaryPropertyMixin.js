/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare"], function(declare) {
  return declare("km.imeeting.SummaryPropertyMixin", null, {
	modelName: "com.landray.kmss.km.imissive.model.KmImissiveSendMain",
    filters: [
		{
			  filterType: "FilterSearch",
			  name: "SendtoUnit",
			  subject: "发文单位"
		},
		{
			  filterType: "FilterSearch",
			  name: "fdDocNum",
			  subject: "发文字号"
		},
		{
			filterType: "FilterAddress",
			type:"ORG_TYPE_PERSON",
			name: "fdDrafter",
			subject: "拟稿人"
		},
		{
			filterType: "FilterDatetime",
			type: "date",
			name: "fdDraftTime",
			subject: "拟稿日期"
		},
		{
			filterType: "FilterDatetime",
			type: "date",
			name: "docPublishTime",
			subject: "签发日期"
		},
		{
			filterType: "FilterDatetime",
			type: "date",
			name: "docCreateTime",
			subject: "创建时间"
		}
    ]
  })
})
