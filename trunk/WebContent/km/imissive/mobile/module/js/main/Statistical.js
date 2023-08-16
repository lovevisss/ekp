define([ "dojo/_base/declare",
		"sys/mportal/module/mobile/containers/header/CardMixin",
		"mui/i18n/i18n!km-imissive:kmImissive.tree" ], function(declare, CardMixin, Msg) {
	return declare("km.imissive.module.main.Statistical", [ CardMixin ], {

		datas : {
			menus : [ 
			          [ 
			           {
							countUrl: "/km/imissive/km_imissive_main/kmImissiveMain.do?method=getImissiveLibraryCount",
							text : Msg["kmImissive.tree.all"], // 公文库
							href : "/km/imissive/mobile/imissive_library/index.jsp"
						}, 
						{
							countUrl: "/km/imissive/km_imissive_main/kmImissiveMain.do?method=getImissiveApprovalCount",
							text : Msg["kmImissive.tree.myapproval"], // 待我审的
							href : "/km/imissive/mobile/imissive_approval/index.jsp"
						}, 
						{
							countUrl: "/km/imissive/km_imissive_main/kmImissiveMain.do?method=getImissiveApprovaledCount",
							text : Msg["kmImissive.tree.myapproved"], // 我已审的
							href : "/km/imissive/mobile/imissive_approvaled/index.jsp"
						}			           
			          ] 
			]
		}

	})
})
