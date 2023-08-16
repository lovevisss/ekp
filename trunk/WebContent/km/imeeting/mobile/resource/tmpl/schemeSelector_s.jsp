<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div class="topicSelector_toolbar">
	<div class="topicSelector_toolbar_btn" style="left: 1rem; display: none;" id="schemeSelectorPreBtn">
		<i class="mui mui-back"></i>
		<span><bean:message key="list.lever.up"/></span>
	</div>
	<div class="topicSelector_toolbar_btn" style="left: 1rem; display: none;" id="schemeSelectorBackBtn">
		<i class="mui mui-back"></i>
		<span><bean:message key="button.back"/></span>
	</div>
	<div class="topicSelector_toolbar_btn" style="right: 1rem;" id="schemeSelectorCalBtn">
		<span><bean:message key="button.cancel"/></span>
	</div>
	<span id="schemeSelectorTitle"><bean:message key="mobile.imeeting.select" bundle="km-imeeting"/></span>
	<span id="schemeSearchTitle" style="display: none;"><bean:message key="mobile.imeeting.select" bundle="km-imeeting"/></span>
</div>

<div class="muiSearchParent">
	
	<div
		data-dojo-type="mui/commondialog/template/DialogSearchBar" 
		data-dojo-props="needPrompt:false,height:'3.8rem',searchUrl:'/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&isDialog=0&q.docStatus=30&mainDialog=1',
		key:'{categroy.key}'" class="schemeSearchContent">
	</div>
</div>

<div id="schemeSelectorView_{categroy.key}" 
	data-dojo-type="dojox/mobile/ScrollableView"
	data-dojo-mixins="mui/category/_ViewScrollResizeMixin"
	data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}'">
	
	<ul data-dojo-type="km/imeeting/mobile/resource/js/SchemeSelector" 
		data-dojo-props="isMul:false,key:'{categroy.key}'"
		style="outline: none;" id="schemeSelectorUl">
	</ul>
	
	<ul data-dojo-type="mui/commondialog/template/DialogList"
		data-dojo-mixins="mui/commondialog/template/DialogItemListMixin"
		data-dojo-props="isMul:{categroy.isMul},key:'{categroy.key}',dataUrl:'/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=list&isDialog=0&q.docStatus=30&mainDialog=1',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',
			displayProp:'docSubject'" style="display: none;" id="schemeSearchUl">
	</ul>
	
</div>

<div data-dojo-type="km/imeeting/mobile/resource/js/SchemeSelection" 
	data-dojo-props="key:'{categroy.key}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}'" fixed="bottom">
</div>