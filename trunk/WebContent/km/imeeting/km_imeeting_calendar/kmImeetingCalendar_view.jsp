<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%--查看会议安排--%>

<div id="meeting_calendar_mainview" class="meeting_calendar_dialog"  style="position: absolute; display: none">
	<span class="fdId" style="display: none;"></span>
	<span class="type" style="display: none;"></span>
	<%--顶部--%>
	<div class="meeting_calendar_dialog_top">
		<div class="meeting_calendar_dialog_title">
			<span class="meeting-calaendar-dialog-title">
				${lfn:message('km-imeeting:table.kmImeetingMain')}
			</span>
			<span class="isCycle"></span>
		</div>
		<div class="meeting_calendar_dialog_close" onclick="meetingCalendarDialogClose()"></div>
	</div>
	<%--内容区--%>
	<div class="lui_imeeting_order_list">
		<ul>	
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingMain.fdName" /></em>
				<span class="fdName calendar-text"  title=""></span>
			</li>
		    <li>
				<em><bean:message key="time.label" /></em>
				<span class="fdHoldDate calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdPlace" /></em>
				<span class="fdPlace calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingMain.fdPlaceDetail" /></em>
				<span class="fdPlaceDetail calendar-text"></span>
			</li>
			<li class="fdRepeatLi" style="display:none">
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdRepeatInfo" /></em>
				<span class="fdRepeatInfo calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingMain.fdHost" /></em>
				<span class="fdHost calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingMain.docCreator" /></em>
				<span class="docCreator calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdRemark" /></em>
				<span class="fdRemark calendar-text"></span>
			</li>
		</ul>
		<div class="fdHasExam"></div>
	</div>
	<%--底部--%>
	<div class="meeting_calendar_dialog_buttom">
		<%-- 查看会议安排 --%>
		<ui:button id="meeting_view_btn" text="${lfn:message('button.view') }"  styleClass="lui_toolbar_btn_gray" onclick="meetingView()"/>
	</div>
</div>

<%--查看会议室预约--%>
<div id="meeting_calendar_bookview" class="meeting_calendar_dialog"  style="position: absolute; display: none">
	<span class="fdId" style="display: none;"></span>
	<span class="_fdHoldDate" style="display: none;"></span>
	<span class="_fdFinishDate" style="display: none;"></span>
	<span class="type" style="display: none;"></span>
	<span class="fdRecurrenceStr" style="display: none;"></span>
	<%--顶部--%>
	<div class="meeting_calendar_dialog_top">
		<div class="meeting_calendar_dialog_title">
			${lfn:message('km-imeeting:table.kmImeetingBook')}
			<span class="isCycle"></span>
		</div>
		<%-- <div class="meeting_calendar_dialog_recurrenceIcon">
			<img src="${LUI_ContextPath}/km/imeeting/resource/images/recurrenceTip.png" />
		</div> --%>
		<div class="meeting_calendar_dialog_close" onclick="meetingCalendarDialogClose()"></div>
	</div>
	<%--内容区--%>
	<div class="lui_imeeting_order_list">
		<ul>	
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdName" /></em>
				<span class="fdName calendar-text" title=""></span>
			</li>
		    <li>
				<em><bean:message key="time.label" /></em>
				<span class="fdHoldDate calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdPlace" /></em>
				<span class="fdPlace calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdPlaceDetail" /></em>
				<span class="fdPlaceDetail calendar-text"></span>
			</li>
			<li class="fdRepeatLi" style="display: none">
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdRepeatInfo" /></em>
				<span class="fdRepeatInfo calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.docCreator" /></em>
				<span class="docCreator calendar-text"></span>
			</li>
			<li>
				<em><bean:message bundle="km-imeeting" key="kmImeetingBook.fdRemark" /></em>
				<span class="fdRemark calendar-text"></span>
			</li>
		</ul>
		<div class="fdHasExam"></div>
	</div>
	<%--底部--%>
	<div class="meeting_calendar_dialog_buttom">
		<%--删除预约--%>
		<ui:button id="book_delete_btn" text="${lfn:message('button.delete') }"  styleClass="lui_toolbar_btn_gray"  onclick="bookDelete()"/>
		<%--编辑预约--%>
		<ui:button id="book_edit_btn" text="${lfn:message('button.edit')}"  styleClass="lui_toolbar_btn_gray" onclick="bookEdit()"/>
		<%--提前结束--%>
		<ui:button id="book_early_end_btn" text="${lfn:message('km-imeeting:kmImeeting.btn.earlyEnd')}"  styleClass="lui_toolbar_btn_gray" onclick="earlyEndBook()"/>
		
		<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
			<%--生成会议安排--%>
			<ui:button id="book_change_btn" text="${lfn:message('km-imeeting:kmImeetingBook.changeToImeeting') }"  styleClass="lui_toolbar_btn_gray"  onclick="bookChange()"/>
		</kmss:authShow>
	</div>
</div>
<script>
	seajs.use(['lui/jquery','lui/dialog'], function($,dialog) {
		window.meetingView=function(){
			$('.meeting_calendar_dialog').hide();
			var fdId=$("#meeting_calendar_mainview").find(".fdId").html();
			var type=$("#meeting_calendar_mainview").find(".type").html();
			if(type == "meeting"){
				window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=view&fdId='+fdId,'_blank');
			}
			if(type == "book"){
				window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=view&fdId='+fdId,'_blank');
			}
		}
		window._bookDelete = function() {
			var fdId = $("#meeting_calendar_bookview").find(".fdId").html(),
				recurrenceStr = $("#meeting_calendar_bookview").find(".fdRecurrenceStr").html(),
				url = "${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=delete&fdId=" + fdId,
				defer = $.Deferred();	
			if(recurrenceStr){
				var deleteDate = $("#meeting_calendar_bookview").find("._fdHoldDate").html(),
					url = url +  '&deleteDate=' + deleteDate;
				var _dialog = dialog.build({
					config : {
						width : 436,
						title : '删除预约',
						lock : true,
						cahce : false,
						close : true,
						content : {
							type : "common",
							html : '当前预约为周期性会议，请选择删除方式',
							iconType : 'question',
							buttons : [{
								name : '删除当前',
								styleClass : 'lui_toolbar_btn_gray',
								fn : function(value, dialog) {
									url += '&deleteType=cur';
									defer.resolve();
									_dialog.hide(value);
								}
							},{
								name : '删除当前及后续',
								styleClass : 'lui_toolbar_btn_gray',
								fn : function(value, dialog) {
									url =  url + '&deleteType=after';
									defer.resolve();
									_dialog.hide(value);
								}
							}]
						}
					},
					callback : function(){}
				}).show();
			}else{
				defer.resolve();
			}
			defer.then(function(){
				$.get(url,function(data){
					if(data!=null && data.status==true){
						LUI('____calendar____imeeting').refreshSchedules();
					}
					else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				},'json');
			});
			
			$('.meeting_calendar_dialog').hide();//隐藏对话框
		}
		
		window.bookDelete = function() {
			
			var recurrenceStr = $("#meeting_calendar_bookview").find(".fdRecurrenceStr").html();
			
			//非周期性会议预约删除前提示是否删除
			if(!recurrenceStr) {				
				dialog.confirm('<bean:message bundle="km-imeeting" key="tips.plan.isDelete" />', function(res) {
					if(res) {
						window._bookDelete();
					}
				});
			} else {
				window._bookDelete();
			}
			$('.meeting_calendar_dialog').hide();//隐藏对话框
		}
		
		window.bookEdit = function() {
			var fdId = $("#meeting_calendar_bookview").find(".fdId").html(),
				recurrenceStr = $("#meeting_calendar_bookview").find(".fdRecurrenceStr").html(),
				url = "/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=edit&fdId=" + fdId;
			if (recurrenceStr) {
				var updateDate = $("#meeting_calendar_bookview").find("._fdHoldDate").html(),
					url = url + '&updateDate=' + updateDate;
				var _dialog = dialog.build({
					config: {
						width: 436,
						title: '编辑预约',
						lock: true,
						cahce: false,
						close: true,
						content: {
							type: "common",
							html: '当前预约为周期性会议，请选择编辑方式',
							iconType: 'question',
							buttons: [{
								name: '编辑当前',
								styleClass: 'lui_toolbar_btn_gray',
								fn: function(value, dialog) {
									url += '&updateType=cur';
									console.log(url);
									execUpdateBook(url);
									_dialog.hide(value);
									console.log(url);
								}
							}, {
								name: '编辑当前及后续',
								styleClass: 'lui_toolbar_btn_gray',
								fn: function(value, dialog) {
									url = url + '&updateType=after';
									console.log(url);
									execUpdateBook(url);
									_dialog.hide(value);
								}
							}]
						}
					},
					callback: function() {}
				}).show();
			} else {
				execUpdateBook(url);
			}
			$('.meeting_calendar_dialog').hide(); //隐藏对话框
		};
		
		function execUpdateBook(url) {
			dialog.iframe(url, "${lfn:message('km-imeeting:kmImeetingBook.opt.edit')}", function(result) {
				if (result && result == "success") {
					LUI('____calendar____imeeting').refreshSchedules();
				}
			}, {
				width: 700,
				height: 500
			});
		};
		
		window.bookChange=function(){
			$('.meeting_calendar_dialog').hide();//隐藏对话框
			var fdId=$("#meeting_calendar_bookview").find(".fdId").html();
			dialog.categoryForNewFile(
					'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
					'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{id}'+'&bookId='+fdId,false,null,null);
		}
		
		window.earlyEndBook = function(){
			var fdId=$("#meeting_calendar_bookview").find(".fdId").html();
			var url="${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=earlyEndBook&fdId="+fdId;
			$.get(url,function(data){
				if(data!=null && data.status==true){
					LUI('____calendar____imeeting').refreshSchedules();
				}
				else{
					dialog.failure('<bean:message key="return.optFailure" />');
				}
			},'json');
			$('.meeting_calendar_dialog').hide();//隐藏对话框
		}
		window.meetingCalendarDialogClose=function(){
			$('.meeting_calendar_dialog').fadeOut("fast");
		}
	});
</script>