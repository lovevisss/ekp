<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content"> 
			<br/>
			<p class="txttitle">
				待入职员工选择
			</p>
			<br/>
			<table class="tb_normal" width="98%">
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="hr-staff" key="hrStaffEntry.fdName"/>
					</td>
					<td>
						<xform:text property="fdName" showStatus="edit" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="hr-staff" key="hrStaffEntry.fdMobileNo"/>
					</td>
					<td>
						<xform:text property="fdMobileNo" showStatus="edit" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="hr-staff" key="hrStaffEntry.fdPlanEntryDept"/>
					</td>
					<td>
						<xform:address propertyName="fdPlanEntryDeptName" propertyId="fdPlanEntryDeptId" showStatus="edit" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="hr-staff" key="hrStaffEntry.fdOrgPosts"/>
					</td>
					<td>
						<xform:address propertyName="fdOrgPostNames" propertyId="fdOrgPostIds" showStatus="edit" orgType="ORG_TYPE_POST" />
					</td>
				</tr>
				<tr>
					<%--查询按钮--%>
					<td colspan="4" style="text-align: center;">
					  	<%--查询待入职员工--%>
						<ui:button id="staff_entry_all_btn" text="${lfn:message('button.list') }"   onclick="queryStaffEntry();"/>
					</td>
				</tr>
				<tr>
					<%--待入职员工列表--%>
					<td colspan="4">
						<list:listview id="listview" style="height:200px;overflow-y:scroll;">
							<ui:source type="AjaxJson" >
								{url:'/hr/staff/hr_staff_entry/hrStaffEntry.do?method=newList&q.fdStatus=1'}
							</ui:source>
							<list:colTable isDefault="false" layout="sys.ui.listview.listtable"  name="columntable" onRowClick="selectStaff('!{fdId}','!{fdName}');">
								<list:col-html title=" " style="text-align:left;width:10%;">
									{$ <input type="radio" value="{%row['fdId']%}" name="staffId" onclick="selectStaff('{%row['fdId']%}','{%row['entryName']%}');"> $}
								</list:col-html>
								<list:col-auto props="index" ></list:col-auto>
								<list:col-html title="${lfn:message('hr-staff:hrStaffEntry.fdName') }" headerClass="width140" styleClass="width140">	
									{$ <div>{%row['entryName']%}</div> $}									
								</list:col-html>
								<list:col-auto props="fdMobileNo;fdPlanEntryTime;fdPlanEntryDept;fdOrgPosts"></list:col-auto>
							</list:colTable>
							<ui:event topic="list.loaded">
								seajs.use(['lui/jquery'], function($) {
									$('[name="staffId"][value="${JsParam.staffId}"]').click();
								});
							</ui:event>
						</list:listview>
					</td>
				</tr>
				<tr>
					<%--查询按钮--%>
					<td colspan="4" style="text-align: center;">
					  	<%--选择--%>
						<ui:button id="select_resource_submit" text="${lfn:message('button.select')}"   onclick="selectSubmit();"/>
						<%--取消--%>
						<ui:button id="select_resource_cancel" text="${lfn:message('button.cancel') }"  onclick="selectCancel();"/>
						<%--取消选定--%>
						<ui:button id="select_resource_cancel" text="${lfn:message('button.cancelSelect') }"  onclick="selectCancelSubmit();"/>
					</td>
				</tr>
			</table>
	</template:replace>
</template:include>
<script>
	seajs.use([
 	      'lui/jquery',
 	      'lui/dialog',
 	      'lui/topic',
 	      'lui/util/str'
 	        ],function($,dialog,topic,str){

		//已选资源
		var selectedStaff={staffId:"${JsParam.staffId}",staffName:"${JsParam.staffName}"};
		
		//选择资源时触发
		window.selectStaff=function(staffId,staffName){
			//资源radio置为选中
			$('[name="staffId"][value="'+staffId+'"]').prop('checked',true);
			selectedStaff['staffId']=staffId;
			selectedStaff['staffName']=str.decodeHTML(staffName).replace(/&#039;/,'\'');
		};
		//查询资源
		window.queryStaffEntry=function(){
			var url=LUI('listview').source.url;
			LUI('listview').source.setUrl(replaceParameter(url,{
				"fdName":$('[name="fdName"]').val(),
				"fdMobileNo":$('[name="fdMobileNo"]').val(),
				"fdPlanEntryDeptId":$('[name="fdPlanEntryDeptId"]').val(),
				"fdOrgPostIds":$('[name="fdOrgPostIds"]').val()
			}));
			LUI('listview').source.get();
		};
		//提交
		window.selectSubmit=function(){
			$dialog.hide(selectedStaff);
		};
		//取消
		window.selectCancel=function(){
			$dialog.hide(null);
		};
		//取消选定
		window.selectCancelSubmit=function(){
			$dialog.hide({staffId:"",staffName:""});
		};
		//修改source的URL
		var replaceParameter=function(url,parameterObj){
			for(var key in parameterObj){
				url=Com_SetUrlParameter(url,key,parameterObj[key]);
			}
			return url;
		}
		
	});
</script>