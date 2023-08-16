<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<div id="_readlog_container">
	<ui:tabpanel id="statAccess" layout="sys.ui.tabpanel.light">
		<ui:content title="签到情况">
			<ui:iframe src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/import/kmImeeting_sign.jsp?fdId=${JsParam.fdId}"></ui:iframe>
		</ui:content>
		
		<ui:content title="投票统计">
			<ui:iframe src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/import/kmImeeting_vote.jsp?fdId=${JsParam.fdId}"></ui:iframe>
		</ui:content>
		
		<ui:content title="表决统计">
			<ui:iframe src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/import/kmImeeting_ballot.jsp?fdId=${JsParam.fdId}"></ui:iframe>
		</ui:content>
	</ui:tabpanel>
</div>