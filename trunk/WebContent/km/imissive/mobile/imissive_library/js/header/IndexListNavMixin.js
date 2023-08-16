define(["dojo/_base/declare", "dojo/store/Memory","mui/i18n/i18n!km-imissive:kmMissive.tree"], function(declare, Memory, Msg) {
  return declare("km.imissive.mobile.imissiveLibrary.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmMissive.tree.sendMissive"],
	        		headerTemplate : "/km/imissive/mobile/imissive_library/js/header/ImissiveSendTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmMissive.tree.receiveMissive"],
	        		headerTemplate : "/km/imissive/mobile/imissive_library/js/header/ImissiveReceiveTemplate.js"
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmMissive.tree.signMissive"],
	        		headerTemplate : "/km/imissive/mobile/imissive_library/js/header/ImissiveSignTemplate.js"
	        	}
        ]
    })
  })
})
