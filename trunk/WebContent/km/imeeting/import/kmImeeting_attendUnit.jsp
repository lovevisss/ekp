<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>Com_IncludeFile("doclist.js");</script>
<!-- 打印引入的话会多一个类名 -->
<c:if test="${param.isPrint eq 'true'}">
	<c:set var="printClassName" value=" print-frame" scope="request"></c:set>
	<c:set var="mainIndex" value=" attendUnitPrintTable_${param.forIndex}" scope="request"></c:set>
</c:if>

<div class="lui_form_content_frame attendUnitTable${printClassName}${mainIndex}">
	<table class="tb_normal" width=100% id="Table_Main"> 
		<tr>
			<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
				<c:out value="出席单位"></c:out>
			</td>
		</tr>
		<tr id="attendUnitFirstTr">
			<td class="td_normal_title" width="25%">
				参会单位
			</td>
			<td class="td_normal_title" width="25%">
				接收通知人
			</td>
			<td class="td_normal_title" width="50%">
				参加议题
			</td>
	</table>
</div>
