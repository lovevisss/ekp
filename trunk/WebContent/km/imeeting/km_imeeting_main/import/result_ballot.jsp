<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.pass){
	{$
	<table style="width:100%;margin-top: 10px;" class="lui_result_tb">
		<tr>
			<th>
				总人数
			</th>
			<th>
				赞成人数
			</th>
			<th>
				反对人数
			</th>
			<th>
				弃权人数
			</th>
			<th>
				表决时间
			</th>
		</tr>
		<tr align="center">
			<td>{%data.total%}</td>
			<td>{%data.pass%}</td>
			<td>{%data.refuse%}</td>
			<td>{%data.quit%}</td>
			<td>{%data.startTimeStr%}</td>
		</tr>
	</table>
	$}
} else if (data.status=="7008") {
	{$
		<span>表决未开始</span>
	$}
}