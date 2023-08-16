define(["dojo/_base/declare", "dojo/store/Memory","mui/i18n/i18n!km-imissive:kmImissive","mui/i18n/i18n!:status"], function(declare, Memory, Msg , statusMsg) {
  return declare("km.imissive.mobile.imissiveSend.indexListNavMixin", null, {
    store: new Memory({
      data:[ 
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmImissive.tree.status.all"]
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.docStatus=10&orderby=docCreateTime&ordertype=down", 
	        		text : statusMsg["status.draft"]
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.docStatus=20&orderby=docCreateTime&ordertype=down", 
	        		text : statusMsg["status.examine"]
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.docStatus=11&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmImissive.status.refuse"]
	        	},
	        	{ 
	        		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&q.docStatus=30&orderby=docCreateTime&ordertype=down", 
	        		text : Msg["kmImissive.status.publish"]
	        	}
        ]
    })
  })
})
