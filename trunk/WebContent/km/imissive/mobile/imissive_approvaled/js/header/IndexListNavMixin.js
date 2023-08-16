define(["dojo/_base/declare", "dojo/store/Memory","mui/i18n/i18n!km-imissive:mobile"], function(declare, Memory, Msg) {
  return declare("km.imissive.mobile.imissiveApprovaled.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.mydoc=approved&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["mobile.kmImissive.postsReviewed"],
	        		headerTemplate : "/km/imissive/mobile/imissive_approvaled/js/header/ImissiveSendTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.mydoc=approved&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["mobile.kmImissive.reviewedReceipts"],
	        		headerTemplate : "/km/imissive/mobile/imissive_approvaled/js/header/ImissiveReceiveTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&q.mydoc=approved&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["mobile.kmImissive.signedReport"],
	        		headerTemplate : "/km/imissive/mobile/imissive_approvaled/js/header/ImissiveSignTemplate.js"
	        	}
        ]
    })
  })
})
