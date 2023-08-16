<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=coming',
			text: '<bean:message bundle="km-imeeting" key="mobile.aboutToStart"/>',
		},
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=myJoined',
			text: '<bean:message bundle="km-imeeting" key="mobile.IJoined"/>',
		},
		{
			url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=myDraft',
			text: '<bean:message bundle="km-imeeting" key="mobile.myDrafted"/>',
		}
]