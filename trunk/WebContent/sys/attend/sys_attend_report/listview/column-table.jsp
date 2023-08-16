var lv = layout.parent;
var datas = lv.getData().datas;
var columns = lv.getData().columns;

{$
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="lui_listview_body">
	<div class="lui_listview_centerL">
		<div class="lui_listview_centerR">
			<div class="lui_listview_centerC">
				<table width="100%" class="lui_listview_columntable_table">
					<thead data-lui-mark="column.table.header">$}
						{$<tr>$}
						var isContain = function(values, col){
							if(values && col) {
								var arr = values.split(";");
								for(var i = 0 ;i < arr.length;i++){
									if(arr[i] && col == $.trim(arr[i])){
										return true;
									}
								}
							}
							return false;
						};
						var overTimeCols = "fdWorkOverTime;fdOffOverTime;fdHolidayOverTime;fdOverTime";
						var offDayCols = document.getElementsByName('fdoffTypeNames')[0].value + "fdOffDays";
						var overTimeMergeNum = 0, OffDaysMergeNum = 0;
						var isOverTimeMerge = false, isOffDaysMerge = false;
						
						for (var i = 0; i < columns.length; i ++) {
							var col = columns[i];
							if('true' != col.hide){
								var prop = col.property || col.sort;
								if(isContain(overTimeCols, prop)){
									overTimeMergeNum++;
								} else if(isContain(offDayCols, prop)){
									OffDaysMergeNum++;
								}
							}
						}
						
						for (var i = 0; i < columns.length; i ++) {
							var col = columns[i];
							if('true' != col.hide){
								var prop = col.property || col.sort;
								if(overTimeMergeNum > 0 || OffDaysMergeNum > 0){
									if(isContain(overTimeCols, prop)){
										if(!isOverTimeMerge){
											isOverTimeMerge = true;
											{$<th colspan='{%overTimeMergeNum%}'><bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.overtime"/></th>$}
										}
									} else if(isContain(offDayCols, prop)){
										if(!isOffDaysMerge){
											isOffDaysMerge = true;
											{$<th colspan='{%OffDaysMergeNum%}'><bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.askforleave"/></th>$}
										}
									} else {
										{$<th rowspan="2" style='{%col.headerStyle%}' class='{%col.headerClass%}' data-lui-mark-row-id='{%col.rowId%}' data-lui-mark-sort='{%col.sort%}' data-lui-mark-toggle-index='{%col.index%}'>{%col.title%}</th>$}
									}
								} else {
									{$<th style='{%col.headerStyle%}' class='{%col.headerClass%}' data-lui-mark-row-id='{%col.rowId%}' data-lui-mark-sort='{%col.sort%}' data-lui-mark-toggle-index='{%col.index%}'>{%col.title%}</th>$}
								}
							}
						}
						{$</tr>$}
						if(overTimeMergeNum > 0 || OffDaysMergeNum > 0) {
							{$<tr>$}
							for (var i = 0; i < columns.length; i ++) {
								var col = columns[i];
								if('true' != col.hide){
									var prop = col.property || col.sort;
									if(isContain(overTimeCols, prop) || isContain(offDayCols, prop)){
										{$<th style='{%col.headerStyle%}' class='{%col.headerClass%}' data-lui-mark-row-id='{%col.rowId%}' data-lui-mark-sort='{%col.sort%}' data-lui-mark-toggle-index='{%col.index%}'>{%col.title%}</th>$}
									}
								}
									
							}
							{$</tr>$}
						}
					{$</thead>
					<tbody>$}
						for (var i = 0; i < datas.length; i ++) {
							{$<tr data-lui-mark-id='{%lv.kvData[i]['rowId']%}' kmss_fdId='{%lv.kvData[i]['fdId']%}'>$}
							var row = datas[i];
							for (var j = 0; j < row.length; j ++) {
								var cell = row[j];
								if('true' != cell.hide)
									{$<td style='{%cell.style%}' class='{%cell.styleClass%}'>{%cell.value%}</td>$}
							}
							{$</tr>$}
						}
					{$</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="lui_listview_footL">
		<div class="lui_listview_footR">
			<div class="lui_listview_footC">
			</div>
		</div>
	</div>
</div>
$}