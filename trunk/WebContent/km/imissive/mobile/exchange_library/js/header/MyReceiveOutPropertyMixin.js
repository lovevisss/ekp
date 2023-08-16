/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-imissive:mobile"], function(declare, msg) {
  return declare("km.review.ReviewPropertyMixin", null, {
    filters: [
      {
        filterType: "FilterRadio",
        name: "fdStatus",
        subject: msg['mobile.kmImissive.status'],
        options: [
          {name: msg['mobile.kmImissive.status.noOpen'], value: "0"},
          {name: msg['mobile.kmImissive.status.waitSign'], value: "1"},
          {name: msg['mobile.kmImissive.status.signed'], value: "2"},
          {name: msg['mobile.kmImissive.status.return'], value: "3"},
          {name: msg['mobile.kmImissive.status.returnDoc'], value: "4"}
        ]
      }
    ]
  })
})
