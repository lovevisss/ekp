define([ "dojo/_base/declare", "mui/i18n/i18n!km-imissive:mobile"], function(declare, msg) {
	return declare("km.imissive.module.main.TabsChart", [], {

		datas :[
		        {
		        	text: msg['mobile.kmImissive.week'],
		        	url:"/km/imissive/km_imissive_main/kmImissiveMain.do?method=approvedImissiveChart&dateType=week",
		        	selected:true
		        },
		        {
		        	text: msg['mobile.kmImissive.month'],
		        	url:"/km/imissive/km_imissive_main/kmImissiveMain.do?method=approvedImissiveChart&dateType=month"
		        },
		        {
		        	text: msg['mobile.kmImissive.year'],
		        	url:"/km/imissive/km_imissive_main/kmImissiveMain.do?method=approvedImissiveChart&dateType=year"
		        }
        ]

	})
})
