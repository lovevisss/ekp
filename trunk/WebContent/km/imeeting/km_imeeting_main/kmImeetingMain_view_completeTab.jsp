<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@page import="com.landray.kmss.sys.authorization.util.TripartiteAdminUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.BoenUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingMainUtil"%>

<%
	pageContext.setAttribute("_isBoenEnable", new Boolean(BoenUtil.isBoenEnable()));
	String fdId = (String)request.getParameter("fdId");
	request.setAttribute("isCanLookFeedback", KmImeetingMainUtil.isCanLookFeedback(fdId));
%>
<%
	request.setAttribute("boenUrl", KmImeetingConfigUtil.getBoenUrl());
	request.setAttribute("unitAdmin", KmImeetingConfigUtil.getUnitAdmin());
%>

<%--内容区--%>
<template:replace name="content">
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmImeetingMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main/kmImeetingMain.do">
	</c:if>
	
	<input type="hidden" name="fdId" value="${kmImeetingMainForm.fdId}" />
	<input type="hidden" name="fdPlaceId" value="${kmImeetingMainForm.fdPlaceId}" />
	<input type="hidden" name="fdHoldDate" value="${kmImeetingMainForm.fdHoldDate}" />
	<input type="hidden" name="fdFinishDate" value="${kmImeetingMainForm.fdFinishDate}" />
	
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="10" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
				<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeContent.jsp" charEncoding="UTF-8">
					<c:param name="isCanLookFeedback" value="${isCanLookFeedback}" />
				</c:import>
				
				<c:if test="${_isBoenEnable eq true}">
					<!-- 会中设置 -->
					<c:if test="${canViewBoen eq true}">
						<%@include file="/km/imeeting/km_imeeting_main/kmImeetingMain_inMeetingConfigV.jsp"%>
					</c:if>
					
					<c:if test="${kmImeetingMainForm.docStatus eq '30'}">
						<c:if test="${canViewBoen eq true}">
							<c:import url="/km/imeeting/km_imeeting_main/import/kmImeeting_control.jsp" charEncoding="UTF-8">
					       		<c:param name="order" value="10"/>
					       	</c:import>
					    </c:if>
				       	<c:import url="/km/imeeting/km_imeeting_main/import/kmImeeting_stat.jsp" charEncoding="UTF-8">
				       		<c:param name="order" value="10"/>
				       	</c:import>
					</c:if>
				</c:if>
					
				<%-- 流程 --%>
				<c:choose>
					<c:when test="${kmImeetingMainForm.docStatus>='30' || kmImeetingMainForm.docStatus=='00' || kmImeetingMainForm.docStatus=='10'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingMainForm" />
							<c:param name="fdKey" value="ImeetingMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="needInitLbpm" value="true" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingMainForm" />
							<c:param name="fdKey" value="ImeetingMain" />
							<c:param name="showHistoryOpers" value="true" /> 
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
					</c:otherwise>
				</c:choose>
				<%-- 权限 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingMainForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
				</c:import>
				<!-- 签到 -->
				<c:if test="${kmImeetingMainForm.docStatus!='10'}">
					<% if(!TripartiteAdminUtil.IS_ENABLED_TRIPARTITE_ADMIN && !KmImeetingConfigUtil.isBoenEnable()) { // 开启三员后不能使用 %>
						<kmss:ifModuleExist path="/sys/attend/">
							<c:set var="isHasAttendAuth" value="false"></c:set>
							<kmss:authShow roles="ROLE_SYSATTEND_DEFAULT">
								<c:set var="isHasAttendAuth" value="true"></c:set>
							</kmss:authShow>
							<c:if test="${isHasAttendAuth eq 'true' }">
								<c:set var="isShowBtn" value="false"></c:set>
								<c:set var="isExpandTab" value="false"></c:set>
								
								<kmss:auth
									requestURL="/sys/attend/sys_attend_category/sysAttendCategory.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&fdModelId=${kmImeetingMainForm.fdId}" requestMethod="GET">
									<c:if test="${kmImeetingMainForm.docStatus=='30' && isEnd==false }">
										<c:set var="isShowBtn" value="true"></c:set>
									</c:if>
								</kmss:auth>
								<c:if test="${HtmlParam.showtab=='attend'}">
									<c:set var="isExpandTab" value="true"></c:set>
								</c:if>
								<c:if test="${kmImeetingMainForm.docStatusFirstDigit=='3'}">
									<c:import url="/sys/attend/import/view.jsp" charEncoding="UTF-8">
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"></c:param>
										<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}"></c:param>
										<c:param name="isShowBtn" value="${isShowBtn}"></c:param>
										<c:param name="isExpandTab" value="${isExpandTab}"></c:param>
										<c:param name="expandCateId" value="${HtmlParam.expandCateId}"></c:param>
										<c:param name="order" value="15"></c:param>
									</c:import>
								</c:if>
							</c:if>
							<c:if test="${isHasAttendAuth ne 'true' }">
								<ui:content title="${ lfn:message('sys-attend:sysAttendCategory.importView.signDetail') }" expand="true" id="${kmImeetingMainForm.fdId}" cfg-order="12" cfg-disable="false">
									${ lfn:message('global.accessDenied') }
								</ui:content>
							</c:if>
						</kmss:ifModuleExist>
					<% } %>
				</c:if>
				
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit == '3' && type eq 'admin'}">
			    	<%--日程机制--%>
					<c:if test="${kmImeetingMainForm.syncDataToCalendarTime eq 'feedbackEnd'||kmImeetingMainForm.syncDataToCalendarTime eq 'personAttend'}">
						<ui:content title="${ lfn:message('km-imeeting:kmImeetingMain.agenda.syn') }" cfg-order="13">
							<table class="tb_normal" width=100%>
								<%--同步时机--%>
								<tr>
									<td class="td_normal_title" width="15%">
								 		<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
								 	</td>
								 	<td colspan="3">
								 		<xform:radio property="syncDataToCalendarTime">
							       			<xform:enumsDataSource enumsType="kmImeetingMain_syncDataToCalendarTime" />
										</xform:radio>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 0px;">
									 	<c:import url="/sys/agenda/import/sysAgendaMain_general_view.jsp"	charEncoding="UTF-8">
									    	<c:param name="formName" value="kmImeetingMainForm" />
									    	<c:param name="fdKey" value="ImeetingMain" />
									    	<c:param name="fdPrefix" value="sysAgendaMain_formula_view" />
									 	</c:import>
							 		</td>
							 	</tr>
							</table>
						</ui:content>
					</c:if>
				</c:if>
					
		
				<%--发布机制--%>
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingMainForm" />
						<c:param name="fdKey" value="ImeetingMain" />
						<c:param name="order" value="11"/>
					</c:import>
				</c:if>
				<%--传阅记录--%>
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingMainForm" />
						<c:param name="order" value="10"/>
					</c:import>
				</c:if>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false">
				<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_view_completeContent.jsp" charEncoding="UTF-8">
					<c:param name="isCanLookFeedback" value="${isCanLookFeedback}" />
				</c:import>
				<!-- 会中设置 -->
				<c:if test="${_isBoenEnable}">
					<c:if test="${canViewBoen eq true}">
						<!-- 会中设置 -->
						<%@include file="/km/imeeting/km_imeeting_main/kmImeetingMain_inMeetingConfigV.jsp"%>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatus eq '30'}">
						<c:if test="${canViewBoen eq true}">
							<c:import url="/km/imeeting/km_imeeting_main/import/kmImeeting_control.jsp" charEncoding="UTF-8">
					       		<c:param name="order" value="10"/>
					       	</c:import>
					    </c:if>
				       	<c:import url="/km/imeeting/km_imeeting_main/import/kmImeeting_stat.jsp" charEncoding="UTF-8">
				       		<c:param name="order" value="10"/>
				       	</c:import>
					</c:if>
				</c:if>
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingMainForm" />
					<c:param name="fdKey" value="ImeetingMain" />
					<c:param name="onClickSubmitButton" value="gun();" />
				</c:import>
				<%-- 权限 --%>
				<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingMainForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
				</c:import>
				
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit eq '3' && type eq 'admin'}">
			    	<%--日程机制--%>
					<c:if test="${kmImeetingMainForm.syncDataToCalendarTime eq 'feedbackEnd'||kmImeetingMainForm.syncDataToCalendarTime eq 'personAttend'}">
						<ui:content title="${ lfn:message('km-imeeting:kmImeetingMain.agenda.syn') }" cfg-order="13">
							<table class="tb_normal" width=100%>
								<%--同步时机--%>
								<tr>
									<td class="td_normal_title" width="15%">
								 		<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
								 	</td>
								 	<td colspan="3">
								 		<xform:radio property="syncDataToCalendarTime">
							       			<xform:enumsDataSource enumsType="kmImeetingMain_syncDataToCalendarTime" />
										</xform:radio>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 0px;">
									 	<c:import url="/sys/agenda/import/sysAgendaMain_general_view.jsp"	charEncoding="UTF-8">
									    	<c:param name="formName" value="kmImeetingMainForm" />
									    	<c:param name="fdKey" value="ImeetingMain" />
									    	<c:param name="fdPrefix" value="sysAgendaMain_formula_view" />
									 	</c:import>
							 		</td>
							 	</tr>
							</table>
						</ui:content>
					</c:if>
				</c:if>
				
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit == '3' && fdIsNewCriPerson eq 'true'}">
					<%--发布机制--%>
					<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingMainForm" />
						<c:param name="fdKey" value="ImeetingMain" />
						<c:param name="order" value="11"/>
					</c:import>
				</c:if>
				
				<%--传阅记录--%>
				<c:if test="${kmImeetingMainForm.docStatusFirstDigit == '3'  && fdIsNewCriPerson eq 'true'}">
					<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImeetingMainForm" />
						<c:param name="order" value="10"/>
					</c:import>
				</c:if>
				<c:if test="${kmImeetingMainForm.docStatus!='10'}">
				<% if(!TripartiteAdminUtil.IS_ENABLED_TRIPARTITE_ADMIN && !KmImeetingConfigUtil.isBoenEnable()) { // 开启三员后不能使用 %>
				<kmss:ifModuleExist path="/sys/attend/">
					<c:set var="isHasAttendAuth" value="false"></c:set>
					<kmss:authShow roles="ROLE_SYSATTEND_DEFAULT">
						<c:set var="isHasAttendAuth" value="true"></c:set>
					</kmss:authShow>
					<c:if test="${isHasAttendAuth eq 'true' }">
						<c:set var="isShowBtn" value="false"></c:set>
						<c:set var="isExpandTab" value="false"></c:set>
						
						<kmss:auth
							requestURL="/sys/attend/sys_attend_category/sysAttendCategory.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&fdModelId=${kmImeetingMainForm.fdId}" requestMethod="GET">
							<c:if test="${kmImeetingMainForm.docStatus=='30' && isEnd==false }">
								<c:set var="isShowBtn" value="true"></c:set>
							</c:if>
						</kmss:auth>
						<c:if test="${HtmlParam.showtab=='attend'}">
							<c:set var="isExpandTab" value="true"></c:set>
						</c:if>
						<c:if test="${kmImeetingMainForm.docStatusFirstDigit=='3'}">
							<c:import url="/sys/attend/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"></c:param>
								<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}"></c:param>
								<c:param name="isShowBtn" value="${isShowBtn}"></c:param>
								<c:param name="isExpandTab" value="${isExpandTab}"></c:param>
								<c:param name="expandCateId" value="${HtmlParam.expandCateId}"></c:param>
								<c:param name="order" value="255"></c:param>
							</c:import>
						</c:if>
					</c:if>
					<c:if test="${isHasAttendAuth ne 'true' }">
						<ui:content title="${ lfn:message('sys-attend:sysAttendCategory.importView.signDetail') }" expand="true" id="${kmImeetingMainForm.fdId}" cfg-order="12" cfg-disable="false">
							${ lfn:message('global.accessDenied') }
						</ui:content>
					</c:if>
				</kmss:ifModuleExist>
				<%} %>
				</c:if>
			</ui:tabpage>
		</c:otherwise>
	</c:choose>
	
		<input type="hidden" name="fdId" value="${kmImeetingMainForm.fdId}" />
		
	<c:if test="${param.approveModel ne 'right'}">
	 </form>
	</c:if>
<%-- <jsp:include page="/km/imeeting/km_imeeting_main/kmImeetingMain_viewKkVideo_include.jsp" /> --%>
<script type="text/javascript">
seajs.use([ 'km/imeeting/resource/js/dateUtil', 'sys/ui/js/dialog','lui/topic', 'lui/jquery', 'lui/imageP/preview'], function(dateUtil,dialog,topic, $, preview) {
	
	topic.subscribe('successReloadPage', function() {
		window.location.reload();
	});
	
	window.feedBack= function(){
		var url = '/km/imeeting/km_imeeting_main_feedback/index.jsp?meetingId=${JsParam.fdId}';
		dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingFeedback.feedbackList" />',function(value){},{width:900,height:400});
	};
	
	window.beginMeeting=function(){
		var url = '<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=updateBeginMeeting"/>';
		window.del_load = dialog.loading();
		$.ajax({
			url: url,
			type: 'post',
			dataType: 'json',
			data:{fdMeetingId:'${kmImeetingMainForm.fdId}'},
			error: function(data){
				if(window.del_load!=null){
					window.del_load.hide(); 
				}
				dialog.result(data.responseJSON);
			},
			success: function(data){
				if(data.flag=="success"){
					dialog.success('开启成功');
					location.reload();
				}
			}
	   });
	};
	
	window.getMeetingAtt=function(){
		var url = '<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=updateMeetingAtt"/>';
		window.del_load = dialog.loading();
		$.ajax({
			url: url,
			type: 'post',
			dataType: 'json',
			data:{fdMeetingId:'${kmImeetingMainForm.fdId}'},
			error: function(data){
				if(window.del_load!=null){
					window.del_load.hide(); 
				}
				dialog.result(data.responseJSON);
			},
			success: function(data){
				if(data.flag=="success"){
					dialog.success('批注获取成功');
					location.reload();
				} else {
					window.del_load.hide(); 
					dialog.failure(data.flag);
				}
			}
	   });
	};
	
	
	window.getMeetingAttTest=function(){
		 path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imeeting/km_imeeting_main/kmImeetingAttTest.jsp';
	    dialog.iframe(path,'33333',function(rtn){
		  if(rtn!="undefined"&&rtn!=null){
			  var url = '<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=addAttFromBoenTest"/>';
				window.del_load = dialog.loading();
				$.ajax({
					url: url,
					type: 'post',
					dataType: 'json',
					data:{fdId:'${kmImeetingMainForm.fdId}',attachmentName:rtn.attachmentName,attachmentUrl:rtn.attachmentUrl,fdKey:rtn.fdKey},
					error: function(data){
						if(window.del_load!=null){
							window.del_load.hide(); 
						}
						dialog.result(data.responseJSON);
					},
					success: function(){
						var results =  eval("("+data+")");
						if(results['flag']=="success"){
							dialog.success('批注获取成功');
							 location.reload();
						}
					}
			   });
		  }
	   },{width:800,height:400});
	};
	
	
	
	window.gun = function(){
		//驳回时进行资源冲突校验
		if("${kmImeetingMainForm.docStatus}" ==  "11"){
			//资源冲突检测
			_checkResConflict().done(function(){
				//设备冲突检测
				_checkEquipmentConflict().done(function(){
					Com_Submit(document.kmImeetingMainForm, 'approveDraft');
					//__validateFinish(commitType, saveDraft,isChange);
				});
			});
		}else{
			Com_Submit(document.kmImeetingMainForm, 'approveDraft');
		}
	};
	window.updateChange = function(){
		var recurrenceStr = $("input[name='fdRecurrenceStr']").val();
		//非周期性会议变更前提示是否变更
		if(!recurrenceStr) {
			dialog.confirm('${lfn:message("km-imeeting:kmImeetingMain.opt.change.tip")}',function(value){
				if(value){
					Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeMeeting&fdId=${JsParam.fdId}','_self');
				}
			});
		}else {
			window._updateChange();
		}
		
	};
	
	window._updateChange = function(){
		var recurrenceStr = $("input[name='fdRecurrenceStr']").val(),
			url = "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?";
		if(recurrenceStr){
				var _dialog = dialog.build({
				config : {
					width : 536,
					title : '${lfn:message("km-imeeting:kmImeeting.btn.change")}',
					lock : true,
					cahce : false,
					close : true,
					content : {
						type : "common",
						html : '${lfn:message("km-imeeting:tips.changeType")}',
						iconType : 'question',
						buttons : [{
							name : '${lfn:message("km-imeeting:tips.changeCurrent")}',
							styleClass : 'lui_toolbar_btn_gray',
							fn : function(value, dialog) {
								url += 'method=changeMeeting&fdId=${JsParam.fdId}&changeType=cur';
								Com_OpenWindow(url,'_self');
								_dialog.hide(value);
							}
						},{
							name : '${lfn:message("km-imeeting:tips.changeFollow-up")}',
							styleClass : 'lui_toolbar_btn_gray',
							fn : function(value, dialog) {
								url =  url + 'method=add&fdOriginalId=${JsParam.fdId}&changeType=after&fdTemplateId=${kmImeetingMainForm.fdTemplateId}&isCycle=true';
								Com_OpenWindow(url,'_self');
								_dialog.hide(value);
							}
						}]
					}
				},
				callback : function(){}
			}).show();
		}
	}
	
	window.addSeatPlan = function(){
		Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_seat_plan/kmImeetingSeatPlan.do?method=add&fdImeetingMainId=${JsParam.fdId}','_self');
	}
	
	window.addSummary = function() {
		var fdModelName = "com.landray.kmss.km.imeeting.model.KmImeetingMain";
		dialog.categoryForNewFile(
	              'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
	              '/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}&fdMeetingId=${kmImeetingMainForm.fdId}&fdModelName=' + fdModelName,false,null,null,"",null,null,true); 
	};
	
	window.viewSeatPlan = function(){
		Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_seat_plan/kmImeetingSeatPlan.do?method=view&fdId=${kmImeetingMainForm.fdSeatPlanId}','_blank');
	}
	
	
	window.earlyEndMeeting = function(){
		var url = '/km/imeeting/km_imeeting_main/kmImeetingMain_earlyEnd_edit.jsp?fdId=${JsParam.fdId}';
		url = Com_SetUrlParameter(url,"fdHoldDate","${kmImeetingMainForm.fdHoldDate}");
		url = Com_SetUrlParameter(url,"fdFinishDate","${kmImeetingMainForm.fdFinishDate}");
		url = Com_SetUrlParameter(url,"fdEarlyFinishDate","${kmImeetingMainForm.fdEarlyFinishDate}");
		
		dialog.iframe(url,'${lfn:message("km-imeeting:kmImeetingMain.earlyEndMeeting")}',function(value){
			if(typeof value =="undefined"){
				location.reload();
			}
		},{width:600,height:400});
	};
	
	window.Delete=function(){
    	dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
	    	if(flag==true){
	    		Com_OpenWindow('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=delete&fdId=${JsParam.fdId}','_self');
	    	}else{
	    		return false;
		    }
	    },"warn");
    };
	
	//发送会议通知
	window.sendNotify=function(){
		var names=(function(){
			var hostName="${kmImeetingMainForm.fdHostName }",
				attendName="${kmImeetingMainForm.fdAttendPersonNames }",
				participantName="${kmImeetingMainForm.fdParticipantPersonNames }";
			return convertToArray(hostName,attendName,participantName);
		})();
		//#9196 提示语：给人1，人2...发送会议通知，邀请您参加会议：XX会议主题，召开时间：XX，会议地点：XX 
		var confirmTip="${lfn:message('km-imeeting:kmImeetingMain.attend.notify.confirm.tip')}"
						.replace('%km-imeeting:kmImeetingMain.attend%',names)
						.replace('%km-imeeting:kmImeetingMain.fdName%','<c:out value="${kmImeetingMainForm.fdName}" />')
						.replace('%km-imeeting:kmImeetingMain.fdDate%','${kmImeetingMainForm.fdHoldDate}')
						.replace('%km-imeeting:kmImeetingMain.fdPlace%','<c:out value="${kmImeetingMainForm.fdPlaceName}" />'+'<c:out value="${kmImeetingMainForm.fdOtherPlace}" />');
		
		dialog.confirm(confirmTip,function(flag){
			if(flag==true){
				window._load = dialog.loading();
				$.post('<c:url value="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=sendNotify&fdId=${JsParam.fdId}"/>',
						function(data){
							if(window._load!=null)
								window._load.hide();
							if(data!=null && data.status==true){
								dialog.success('会议通知已发送');
								 LUI('toolbar').removeButton(LUI('sendNotify'));
							}else{
								dialog.failure('<bean:message key="return.optFailure" />');
							}
						},'json');
			}else{
				return false;
			}
			
		});
	};

	//会议催办
	window.showHastenMeeting=function(){
		dialog.iframe('/km/imeeting/km_imeeting_main_hasten/kmImeetingMainHasten.do?method=showHastenMeeting&meetingId=${JsParam.fdId}',
			'催办会议',null,{width:600,height:360});
	};

	//会议取消
	window.showCancelMeeting=function(){
		
		dialog.iframe('/km/imeeting/km_imeeting_main_cancel/kmImeetingMainCancel.do?method=showCancelMeeting&meetingId=${JsParam.fdId}',
				'${lfn:message("km-imeeting:kmImeetingMain.cancelMeeting")}',function(value){
			if(typeof value =="undefined"){
				location.reload();
			}
		},{width:600,height:380});
		
	};
	
	window._showCancelMeeting = function(){
		var recurrenceStr = $("input[name='fdRecurrenceStr']").val(),
		url = "${LUI_ContextPath}/km/imeeting/km_imeeting_main_cancel/kmImeetingMainCancel.do?method=showCancelMeeting&meetingId=${JsParam.fdId}";
		if(recurrenceStr){
				var _dialog = dialog.build({
				config : {
					width : 536,
					title : '${lfn:message("km-imeeting:kmImeetingMain.cancelMeeting")}',
					lock : true,
					cahce : false,
					close : true,
					content : {
						type : "common",
						html : '${lfn:message("km-imeeting:tips.cancelType")}',
						iconType : 'question',
						buttons : [{
							name : '${lfn:message("km-imeeting:tips.cancelCurrent")}',
							styleClass : 'lui_toolbar_btn_gray',
							fn : function(value, dialog) {
								url += '&cancelType=cur';
								Com_OpenWindow(url,'_self');
								_dialog.hide(value);
							}
						},{
							name : '${lfn:message("km-imeeting:tips.cancelFollow-up")}',
							styleClass : 'lui_toolbar_btn_gray',
							fn : function(value, dialog) {
								url =  url + '&cancelType=after';
								Com_OpenWindow(url,'_self');
								_dialog.hide(value);
							}
						}]
					}
				},
				callback : function(){}
			}).show();
		}
	}

	//初始化会议历时
	if( "${kmImeetingMainForm.fdHoldDuration}" ){
		//将小时分解成时分
		var timeObj=dateUtil.splitTime({"ms":"${kmImeetingMainForm.fdHoldDuration}"});
		$('#fdHoldDurationHour').html(timeObj.hour);
		$('#fdHoldDurationMin').html(timeObj.minute);
		if(timeObj.minute){
			$('#fdHoldDurationMinSpan').show();
		}else{
			$('#fdHoldDurationMinSpan').hide();
		}		
	}
	
	//转换成数组
	function convertToArray(){
		var slice=Array.prototype.slice,
			args=slice.call(arguments,0),
			arr=[];
		for(var i=0;i<args.length;i++){
			if(args[i]){
				var ids=args[i].split(';');
				for(var j=0;j<ids.length;j++){
					if(ids[j])
						arr.push(ids[j]);
				}
			}
		}
		return arr;
	}
	
	//提交前校验资源是否被占用
	function _checkResConflict(){
		var deferred=$.Deferred();
		if($('[name="fdPlaceId"]').val()){
			$.ajax({
				url: "${LUI_ContextPath}/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=checkConflict",
				type: 'POST',
				dataType: 'json',
				data: {meetingId : $('[name="fdId"]').val() , fdPlaceId: $('[name="fdPlaceId"]').val(), "fdHoldDate":$('[name="fdHoldDate"]').val() , "fdFinishDate":$('[name="fdFinishDate"]').val() },
				success: function(data, textStatus, xhr) {//操作成功
					if(data && !data.result ){
						//不冲突
						deferred.resolve();
					}else{
						//冲突
						var fdPlaceName = $('[name="fdPlaceName"]').val();
						if(!fdPlaceName || $.trim(fdPlaceName).length == 0){
							fdPlaceName = _getConflictImmeetingPlaceName(data.conflictArr);
						}
						dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.conflict.tip')}".replace('%Place%',fdPlaceName));
						deferred.reject();
					}
				}
			});
		}else{
			setTimeout(function(){
				deferred.resolve();
			},1);
		}
		return deferred.promise();
	}
	
	function _getConflictImmeetingPlaceName(conflictArr) {
		if(!conflictArr || conflictArr.length == 0){
			return  '';
		}
		if(conflictArr.length == 1) {
			return conflictArr[0].conflictName;
		}
		var places = '';
		for(var i = 0;i < conflictArr.length; i++){
			places += conflictArr[i].conflictName;
			if(i != conflictArr.length - 1) {
				places += ', ';
			}
		}
	}
	
	//提交前校验有设备是否被占用
	function _checkEquipmentConflict(){
		var deferred=$.Deferred();
		if($('[name="kmImeetingEquipmentIds"]').val()){
			//设备冲突检测
			$.ajax({
				url: "${LUI_ContextPath}/km/imeeting/km_imeeting_equipment/kmImeetingEquipment.do?method=checkConflict",
				type: 'POST',
				dataType: 'json',
				data: { meetingId : $('[name="fdId"]').val() ,equipmentIds: $('[name="kmImeetingEquipmentIds"]').val(), "fdHoldDate":$('[name="fdHoldDate"]').val() , "fdFinishDate":$('[name="fdFinishDate"]').val() },
				success: function(data, textStatus, xhr) {//操作成功
					if(data && !data.conflict ){
						deferred.resolve();
					}else{
						//冲突
						var conflictNames = '';
						for(var i = 0 ;i < data.conflictArray.length;i++){
							conflictNames += data.conflictArray[i].name + ';';
						}
						dialog.alert('资源：'+ conflictNames + '当前时间段存在冲突,请重新选择');
						deferred.reject();
					}
				}
			});
		}else{
			setTimeout(function(){
				deferred.resolve();
			}, 1);
		}
		return deferred.promise();
	}
	
	window.viewFeedbackAtt = function(fdAttId, method) {
		var fdAttViewUrl = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=" + method + "&fdId=" + fdAttId;
		if ("readDownload" == method) {
			fdAttViewUrl += "&open=1";
		}
		window.open(fdAttViewUrl, "_blank");
	}
	
	window.onload = function() {
		
		var isShowFeedback = "${kmImeetingMainForm.docStatus >= '30' && isCanLookFeedback eq 'true'}";
		if ("true" == isShowFeedback) {
			var doneContent = $("div#doneContent");
			var todoContent = $("div#todoContent");
			
			$("#doneBtn").click(function() {
				var todoBtn = $("a#todoBtn");
				var doneBtn = $("a#doneBtn");
				var clazzName = doneBtn.attr("class");
				if (clazzName.indexOf("feedbackSelected") > -1) {
					return;
				} else {
					doneBtn.addClass("feedbackSelected");
					todoBtn.removeClass("feedbackSelected");
					/* doneContent.removeClass("contentNotShow");
					todoContent.addClass("contentNotShow"); */
					getFeedbackInfo("06");
				}
			});
			
			$("#todoBtn").click(function() {
				var todoBtn = $("a#todoBtn");
				var doneBtn = $("a#doneBtn");
				var clazzName = todoBtn.attr("class");
				if (clazzName.indexOf("feedbackSelected") > -1) {
					return;
				} else {
					todoBtn.addClass("feedbackSelected");
					doneBtn.removeClass("feedbackSelected");
					/* todoContent.removeClass("contentNotShow");
					doneContent.addClass("contentNotShow"); */
					getFeedbackInfo("04");
				}
			});
			
			$(".exportFeedbacks").click(function() {
				var fdMeetingId = "${kmImeetingMainForm.fdId}";
				var url = '${LUI_ContextPath}/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=exportFeedbacks&fdMeetingId=' + fdMeetingId;
				Com_OpenWindow(url);
			});
		};
		
		var isVoteEnable = "${kmImeetingMainForm.fdVoteEnable}";
		if ("true" == isVoteEnable) {
			$("span#voteConfig").show();
		}
	};
	
	window.voteConfig = function(){
		 var url = "/km/imeeting/km_imeeting_vote/kmImeetingVote_view_list.jsp?fdMeetingId=${kmImeetingMainForm.fdId}";
		dialog.iframe(url,"投票配置",null,{width:1200, height:600, topWin : window, close: true});
	}
	
	// 预览时的图片基础路径
	var imgBaseUrl = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=download&open=1&fdId=";
	
	window.openFeedbackImg = function(imgId) {
		
		// 预览时的图片路径数组
		var httpUrls = []; 
		
		// 图片查看URL
		var previewUrl = imgBaseUrl + imgId;
		
		httpUrls.push({value:previewUrl});
		
		// 图片下载URL（ open:1 表示查看、open:null 表示下载） 
		var downloadUrl = previewUrl.replace("&open=1",""); 
		
		var datas = { data:httpUrls, value:previewUrl, valueType:'url', downloadUrl:downloadUrl, imageBgColor:'#fff' };
		var _previewImage = null;
		if(window.parent.previewImage){
			 _previewImage = window.parent.previewImage;
		}else if(window.previewImage){
			 _previewImage = window.previewImage;
		}
		_previewImage({
			data:datas
		});
	}
	
	/**
	* 获取回执信息
	*/
	function getFeedbackInfo(feedbackStatus) {
		var listShowUrl = "/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=listShow&meetingId=${kmImeetingMainForm.fdId}"
						+ "&feedbackStatus=" + feedbackStatus + "&type=docCreateTime&sort=desc";
		LUI("listViewFeedback").source.setUrl(listShowUrl);
		LUI("listViewFeedback").source.get();
	}
	
});
</script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<c:choose>
			<c:when test="${kmImeetingMainForm.docStatus>='30' || kmImeetingMainForm.docStatus=='00'}">
				<ui:accordionpanel>
					<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_viewBaseInfo.jsp" charEncoding="UTF-8"></c:import>
				</ui:accordionpanel>
			</c:when>
			<c:otherwise>
				<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
				<%-- 流程 --%>
				<c:if test="${kmImeetingMainForm.docStatus != '10'}">
				<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingMainForm" />
					<c:param name="fdKey" value="ImeetingMain" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="onClickSubmitButton" value="gun();" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				</c:if>
				<!-- 审批记录 -->
				<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingMainForm" />
					<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
				</c:import>
				<c:import url="/km/imeeting/km_imeeting_main/kmImeetingMain_viewBaseInfo.jsp" charEncoding="UTF-8">
				</c:import>
			</ui:tabpanel>
			</c:otherwise>
		</c:choose>		
	</template:replace>
</c:if>
	