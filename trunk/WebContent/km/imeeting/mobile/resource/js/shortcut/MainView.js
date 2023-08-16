define(["mui/createUtils", "mui/i18n/i18n!km-imeeting:mobile", "mui/util"], function(createUtils, msg, util) {
	
	var shortcuts = new Array();
	var arrTmpl = [{
			shortcutName: msg['mobile.topicApproval'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/approval_topic@1x.png"),
			href: "/km/imeeting/mobile/index_approval.jsp?swapIndex=0"
		},{
			shortcutName: msg['mobile.schemeApproval'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/approval_scheme@1x.png"),
			href: "/km/imeeting/mobile/index_approval.jsp?swapIndex=1"
		},{
			shortcutName: msg['mobile.mainApproval'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/approval_main@1x.png"),
			href: "/km/imeeting/mobile/index_approval.jsp?swapIndex=2"
		}, {
			shortcutName: msg['mobile.summaryApproval'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/approval_summary@1x.png"),
			href: "/km/imeeting/mobile/index_approval.jsp?swapIndex=3"
		}, {
			shortcutName: msg['mobile.topicLib'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/lib_topic@2x.png"),
			href: "/km/imeeting/mobile/topic/index.jsp?docType=all"
		},  {
			shortcutName: msg['mobile.schemeLib'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/lib_scheme@2x.png"),
			href: "/km/imeeting/mobile/scheme/index.jsp"
		}, {
			shortcutName: msg['mobile.mainLib'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/lib_main@2x.png"),
			href: "/km/imeeting/mobile/main/index.jsp?docType=all"
		}, {
			shortcutName: msg['mobile.meetingBook'],
			shortcutImg: util.formatUrl("/km/imeeting/mobile/resource/images/lib_main@2x.png"),
			href: "/km/imeeting/mobile/home/index_place_new.jsp"
		}
	];
	
	arrTmpl.forEach(function(item, index){
		if (item.href.indexOf('swapIndex=3') > -1) {
			if("true" == window.isImissiveRole ) {
				shortcuts.push(item);
			}
		} else {
			shortcuts.push(item);
		}
	})
	return shortcuts;
})
