<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:kmMissive.tree.sendMissive')}",
		selected : true 
	},
	{ 
		url : "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:kmMissive.tree.receiveMissive')}"
	},
	{ 
		url : "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=listChildren&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-imissive:kmMissive.tree.signMissive')}"
	}
]
