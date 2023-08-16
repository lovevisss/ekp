define(["dojo/_base/declare", "dojo/store/Memory","mui/util"], function(declare, Memory,util) {
	return declare("km.imissive.mobile.imissiveSend.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&q.docType=sendAll&modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&hasDisCard=true", 
	        		text : "会议纪要"
	        	},
	       ]
    })
  })
})
