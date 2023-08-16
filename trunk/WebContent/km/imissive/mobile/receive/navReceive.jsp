<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.mydoc=create&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:mui.kmImissive.nav.mycreate')}",
		selected : true 
	},
	{ 
		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.mydoc=approval&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:mui.kmImissive.nav.myapproval')}"
	},
	{ 
		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&q.mydoc=approved&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:mui.kmImissive.nav.myapproved')}"
	}
]
