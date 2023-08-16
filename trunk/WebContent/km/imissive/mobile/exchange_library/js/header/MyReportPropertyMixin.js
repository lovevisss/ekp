/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", 'mui/i18n/i18n!km-imissive:mobile'], function(declare, msg) {
  return declare("km.review.ReviewPropertyMixin", null, {
    filters: [
      {
        filterType: "FilterRadio",
        name: "fdRegType",
        subject: msg['mobile.kmImissive.type'],
        options: [
          {name: msg['mobile.kmImissive.send'], value: "1"},
          {name: msg['mobile.kmImissive.receive'], value: "2"}
        ]
      }
    ]
  })
})
