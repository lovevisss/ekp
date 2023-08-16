/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-imeeting:mobile"], function(declare, msg) {
  return declare("km.imeeting.SchemePropertyMixin", null, {
	modelName: "com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate",
    filters: [
      {
          filterType: "FilterAddress",
          type:"ORG_TYPE_PERSON",
          name: "fdHost",
          subject: "主持人"
      }
    ]
  })
})
