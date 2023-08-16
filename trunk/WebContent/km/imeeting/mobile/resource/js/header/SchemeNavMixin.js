define(["dojo/_base/declare", 
        "dojo/store/Memory",
        "mui/util"]
		, function(declare, Memory, util) {
  return declare("km.imeeting.mobile.SchemeNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=data&q.docType=allScheme&orderby=docCreateTime&ordertype=down",
	        		text : "方案库"
	        	}
     	   ]
    })
  })
})