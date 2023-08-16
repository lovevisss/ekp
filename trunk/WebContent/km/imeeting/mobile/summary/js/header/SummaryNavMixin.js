define(["dojo/_base/declare", "dojo/store/Memory","mui/util"], function(declare, Memory,util) {
	return declare("km.imissive.mobile.imissiveSend.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=listChildren&q.docType=allSummary&orderby=docCreateTime&ordertype=down'", 
	        		text : "会议纪要"
	        	},
	       ]
    })
  })
})
