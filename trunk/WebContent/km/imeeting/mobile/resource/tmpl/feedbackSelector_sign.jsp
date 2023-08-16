<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div class="topicSelector_toolbar">
	<div class="topicSelector_toolbar_btn" style="left: 1rem; display: none;" id="topicSelectorPreBtn">
		<i class="mui mui-back"></i>
		<span><bean:message key="list.lever.up"/></span>
	</div>
	<div class="topicSelector_toolbar_btn" style="left: 1rem; display: none;" id="topicSelectorBackBtn">
		<i class="mui mui-back"></i>
		<span><bean:message key="button.back"/></span>
	</div>
	<div class="topicSelector_toolbar_btn" style="right: 1rem;" id="topicSelectorCalBtn">
		<span><bean:message key="button.cancel"/></span>
	</div>
	<span id="topicSelectorTitle"><bean:message key="mobile.imeeting.select" bundle="km-imeeting"/></span>
	<span id="topicSearchTitle" style="display: none;"><bean:message key="mobile.imeeting.select" bundle="km-imeeting"/></span>
</div>

<div data-dojo-type="mui/view/DocScrollableView" 
		data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
	<div class="muiFlowInfoW muiFormContent">
		<table class="muiSimple" cellpadding="0" cellspacing="0">
			<tr>
				<td class=class="muiTitle">
					参会单位
				</td>
				<td>
					
				</td>
			</tr>
		</table>
	</div>
</div>
					
					

<div data-dojo-type="km/imeeting/mobile/resource/js/TopicSelection" 
	data-dojo-props="key:'{categroy.key}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}'" fixed="bottom">
</div>