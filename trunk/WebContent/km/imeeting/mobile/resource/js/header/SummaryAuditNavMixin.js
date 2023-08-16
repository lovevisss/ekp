define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util"]
		, function(declare, Memory, util) {
  return declare("km.imeeting.mobile.SchemeAuditNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&q.docType=myApproval",
	        		text : "待审",
	        		isNavCount:true
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&q.docType=myApprovaled",
	        		text : "已审",
	        		isNavCount:true
	        	}
     	   ]
    })
  })
})