define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util"]
		, function(declare, Memory, util) {
  return declare("km.imeeting.mobile.SchemeAuditNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&q.docType=myApproval",
	        		text : "待审",
	        		isNavCount:true
	        	},
	        	{ 
	        		url : "/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&q.docType=myApprovaled",
	        		text : "已审",
	        		isNavCount:true
	        	},
	        	{ 
	        		url : "/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&q.docType=myDraft",
	        		text : "我发起的",
	        		isNavCount:true
	        	}
     	   ]
    })
  })
})