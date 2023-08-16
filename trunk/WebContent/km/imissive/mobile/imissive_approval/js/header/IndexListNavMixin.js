define(["dojo/_base/declare", "dojo/store/Memory","mui/i18n/i18n!km-imissive:kmImissive.tree"], function(declare, Memory, Msg) {
  return declare("km.imissive.mobile.imissiveApproval.indexListNavMixin", null, {
    store: new Memory({
      data: [ 
	    		{ 
	    			url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.mydoc=approval", 
	    			text : Msg["kmImissive.tree.myapproval.send"],
	    			headerTemplate : "/km/imissive/mobile/imissive_approval/js/header/ImissiveSendTemplate.js"
	    		},
	    		{ 
	    			url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.mydoc=approval", 
	    			text : Msg["kmImissive.tree.myapproval.receive"],
	    			headerTemplate : "/km/imissive/mobile/imissive_approval/js/header/ImissiveReceiveTemplate.js"
	    		},
	    		{
	    			url : "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&q.mydoc=approval", 
	    			text : Msg["kmImissive.tree.myapproval.sign"],
	    			headerTemplate : "/km/imissive/mobile/imissive_approval/js/header/ImissiveSignTemplate.js"
	    		}
	   ]
    })
  })
})
