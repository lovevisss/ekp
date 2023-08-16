/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-archives:mobile"], function(declare, msg) {
  return declare("km.archives.ArchivesBorrowPropertyMixin", null, {
	  modelName: 'com.landray.kmss.km.archives.model.KmArchivesCategory',
    filters: [
      		{
  	          filterType: "FilterRadio",
  	          name: "docStatus",
  	          subject: msg['mobile.status.doc'],
  	          options: [
  	             {name: msg['mobile.status.draft'], value: "10"},
  	             {name: msg['mobile.status.pending'], value: "20"},
  	             {name: msg['mobile.status.overrule'], value: "11"},
  	             {name: msg['mobile.status.abandoned'], value: "00"},
  	             {name: msg['mobile.status.publish'], value: "30"}
  	          ]
  		},
	    {
		    filterType: "FilterDatetime",
		    type: "date",
		    name: "fdBorrowDate",
		    subject: msg['mobile.borrow.date']
		}
    ]
  })
})
