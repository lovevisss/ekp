<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
[ 
	{
		url : '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=list&q.docType=myApproval&orderby=docCreateTime&ordertype=down',
		text: '<bean:message bundle="km-imeeting" key="table.kmImeetingTopic"/>',
		headerTemplate:'/km/imeeting/mobile/topic/js/header/ShortcutListNavMixin.js'
	},
	{
		url : '/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=data&q.docType=myApproval',
		text: '<bean:message bundle="km-imeeting" key="table.kmImeetingScheme"/>',
		headerTemplate:'/km/imeeting/mobile/scheme/js/header/ShortcutListNavMixin.js'
	},
	{
		url : '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=listChildren&q.docType=myApproval&orderby=docCreateTime&ordertype=down',
		text: '<bean:message bundle="km-imeeting" key="table.kmImeetingMain"/>',
		headerTemplate:'/km/imeeting/mobile/main/js/header/ShortcutListNavMixin.js'
	},
	<c:choose>
		<c:when test="${imissiveSummaryEnable == 'true'}">
			<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
				{
					url : '/km/imissive/km_imissive_send_main/kmImissiveSendMainDataOther.do?method=listChildren&modelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&q.docType=myApproval&hasDisCard=true',
					text: '<bean:message bundle="km-imeeting" key="table.kmImeetingSummary"/>',
					headerTemplate:'/km/imeeting/mobile/summary/imissive/js/header/ShortcutListNavMixin.js'
				}
			</kmss:authShow>
		</c:when>
		<c:otherwise>
			{
				url : '/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=listChildren&q.mysummary=myApproval',
				text: '<bean:message bundle="km-imeeting" key="table.kmImeetingSummary"/>',
				headerTemplate:'/km/imeeting/mobile/summary/js/header/ShortcutListNavMixin.js'
			}
		</c:otherwise>
	</c:choose>
	
]