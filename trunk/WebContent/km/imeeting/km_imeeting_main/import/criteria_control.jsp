<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
{$
<div class="lui_supervise_criterions">
	<div class="lui_supervise_criterion_item">
        <div class="lui_supervise_criterion_title">相关监控：</div>
        <div class="lui_supervise_criterion_selectBox">
        	<ul>
				<li class="lui_supervise_criterion_selectItem" onclick="controlChange('1',this)">
	                <span><bean:message key="kmImeetingMain.control.online" bundle="km-imeeting"/></span>
	            </li>
	            <li class="lui_supervise_criterion_selectItem" onclick="controlChange('2',this)">
	                <span><bean:message key="kmImeetingMain.control.push.command" bundle="km-imeeting"/></span>
	            </li>
	            <li class="lui_supervise_criterion_selectItem" onclick="controlChange('3',this)">
	                <span><bean:message key="kmImeetingMain.control.file.download" bundle="km-imeeting"/></span>
	            </li>
	            <li class="lui_supervise_criterion_selectItem" onclick="controlChange('4',this)">
	                <span><bean:message key="kmImeetingMain.control.file.upload" bundle="km-imeeting"/></span>
	            </li>
			</ul>
		</div>
	</div>
</div>
$}
}

