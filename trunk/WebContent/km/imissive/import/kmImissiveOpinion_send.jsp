<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${requestScope[param.formName]}"/>
<ui:content title="${ lfn:message('km-imissive:kmImissive.opinionContent') }" titleicon="lui-tab-icon tab-icon-09">
	 <div>
		<table width=100% class="tb_normal">
			<kmss:auth requestURL="${param.authUrl}&fdId=${param.fdModelId}" requestMethod="GET">
				 <tr>
				   <td>
					   <div>
					     <div style="float:left">
							 <b>审批意见</b>
						 </div>
						  <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;</div>
					   </div>
					   <div style="height: 15px;"></div>
					   	<ui:event event="show">
						   	setTimeout(function() {
								document.getElementById('kmImissiveAuditNote0').src = '<c:url value="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote.do?method=listNote&fdModelId=${param.fdModelId}&fdModelName=${param.fdModelName}&formBeanName=${param.formBeanName}" />';
							},100);
					   	</ui:event>
					   	<iframe id="kmImissiveAuditNote0"  width="100%" style="border: none;" scrolling="no" FRAMEBORDER=0></iframe>
					</td>
				 </tr>
			 </kmss:auth>
			 <%--
			 <tr>
			   <td>
				   <div>
				     <div style="float:left">
						 <b>会签意见</b>
					 </div>
					  <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;</div>
				   </div>
				   <div style="height: 15px;"></div>
				   <list:listview id="signopinion">
						<ui:source type="AjaxJson">
							{"url":"/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=listOpinionByType&fdMainId=${mainForm.fdId}&fdDeliverType=3&fdRegType=1"}
						</ui:source>
						<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="default" onRowClick="window.viewOpinionDetail('!{fdId}')">
							<list:col-auto props="fdUnit.fdName;docCreateTime"></list:col-auto>
						</list:colTable>
					</list:listview>
				</td>
			 </tr>
			 --%>
		     <tr>
			   <td>
				   <div>
				     <div style="float:left;line-height: 42px;padding-left: 10px">
						 <b>传阅意见</b>
					 </div>
					 <div class="lui_list_operation">
						<div style="float:right;display:none" id="opinionBtn">
							<div style="display: inline-block;vertical-align: middle;">
								<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" channel="opinion">
									<list:sortgroup>
										<list:sort property="fdWriteTime" text="按时间" group="sort.list" value="down" channel="opinion"></list:sort>
										<list:sort property="fdBelongPerson.hbmParent" text="按部门" group="sort.list" channel="opinion"></list:sort>
								    </list:sortgroup>
								</ui:toolbar>
							</div>
						</div>
					</div>
				   </div>
				 	<div style="height: 15px;"></div>
				    <list:listview id="opinion" channel="opinion">
						<ui:source type="AjaxJson">
							{"url":"/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${param.fdModelId}&fdModelName=${param.fdModelName}&isOpinion=true"}
						</ui:source>
						<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="default">
							<list:col-auto props="sysCirculationMain.fdCirculationTime;fdBelongPerson.fdParent.fdName;fdBelongPerson.fdName;docCreateTime,fdWriteTime;docContent"></list:col-auto>
						</list:colTable>
						<ui:event topic="list.loaded">
						   if(LUI('opinion')._data.datas.length > 0){
						      $("#opinionBtn").show();
						   }
						</ui:event>	
					</list:listview>
					<list:paging  channel="opinion"></list:paging>
			   </td>
			 </tr>	
		</table>
	 </div>	
	 <script>
	 seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
		 window.viewOpinionDetail = function(fdId){
			var url = '/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=view&fdId='+fdId;
			dialog.iframe(url,'查看会签意见',function(rtn){},{width:1060,height:600});
		 };
		 
		 window.viewCirOpinionDetail = function(fdId){
			var url = '/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=view&fdId='+fdId;
			dialog.iframe(url,'查看传阅意见',function(rtn){},{width:650,height:450});
		 }
	 });
	 </script>
</ui:content>