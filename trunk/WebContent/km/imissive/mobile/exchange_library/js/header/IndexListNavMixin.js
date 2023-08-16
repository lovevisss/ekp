define(["dojo/_base/declare", "dojo/store/Memory","mui/i18n/i18n!km-imissive:kmImissive.tree"], function(declare, Memory, Msg) {
  return declare("km.imissive.mobile.exchangeLibrary.indexListNavMixin", null, {
    store: new Memory({
      data: [ 
	         	{ 
	        		url : "/km/imissive/km_imissive_reg/kmImissiveReg.do?method=list&q.fdDeliverType=1", 
	        		text : Msg["kmImissive.tree.mydistribute"],
	        		headerTemplate : "/km/imissive/mobile/exchange_library/js/header/MyDistributeTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_reg/kmImissiveReg.do?method=list&q.fdDeliverType=2", 
	        		text : Msg["kmImissive.tree.myreport"],
	        		headerTemplate : "/km/imissive/mobile/exchange_library/js/header/MyReportTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true&mySign=true", 
	        		text : Msg["kmImissive.tree.mysign"],
	        		headerTemplate : "/km/imissive/mobile/exchange_library/js/header/MySignTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true", 
	        		text : Msg["kmImissive.tree.myreceivein"],
	        		headerTemplate : "/km/imissive/mobile/exchange_library/js/header/MyReceiveInTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=list&owner=true", 
	        		text : Msg["kmImissive.tree.myreceiveout"],
	        		headerTemplate : "/km/imissive/mobile/exchange_library/js/header/MyReceiveOutTemplate.js"
	        	}
        ]
    })
  })
})
