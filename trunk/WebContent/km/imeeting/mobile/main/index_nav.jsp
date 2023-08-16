<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=coming&orderby=fdHoldDate&ordertype=up',
			text: '<bean:message bundle="km-imeeting" key="mobile.aboutToStart"/>',
			isNavCount: true
		},
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=myJoined',
			text: '<bean:message bundle="km-imeeting" key="mobile.IJoined"/>',
			isNavCount: true
		},
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=myDraft',
			text: '<bean:message bundle="km-imeeting" key="mobile.myDrafted"/>',
			isNavCount: true
		}
]