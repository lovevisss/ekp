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
      },
      {
    	  filterType: "FilterRadio",
          name: "docStatus",
          subject: msg['mobile.status'],
          options: [
        	  {name: msg['mobile.status.draft'], value: "10"},
        	  {name: msg['mobile.status.reject'], value: "11"},
        	  {name: msg['mobile.status.appravel'], value: "20"},
        	  {name: msg['mobile.status.publish'], value: "30"},
        	  {name: msg['mobile.status.discard'], value: "00"}
          ]
      }
    ]
  })
})
