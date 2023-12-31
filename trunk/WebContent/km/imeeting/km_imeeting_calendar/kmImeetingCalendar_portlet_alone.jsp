<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import=" com.landray.kmss.util.ResourceUtil"%>
<%@ page import="com.landray.kmss.km.imeeting.util.ImeetingCateUtil"%>
<%
	request.setAttribute("dateFormatter", ResourceUtil.getString("date.format.date"));
	request.setAttribute("dateTimeFormatter",ResourceUtil.getString("date.format.datetime"));
	request.setAttribute("userId", UserUtil.getUser().getFdId());
	request.setAttribute("now", new Date().getTime());
	request.setAttribute("cateIds",ImeetingCateUtil.getDefCates());
%>
<template:include ref="default.simple">
	<template:replace name="title">Portlet</template:replace>
	<template:replace name="body">
<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/km_imeeting_calendar/calendar.css" />
<script>
	if(window.domain){
		window.domain.autoResize();
	}
	seajs.use([
		'lui/dialog',
		'lui/topic',
		'lui/jquery',
		'km/imeeting/resource/js/dateUtil',
		'lui/util/env'
		], function(dialog,topic,$,dateUtil,env) {
			
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				setTimeout(function(){
					LUI('____calendar____imeeting').refreshSchedules();
				}, 100);
			});  
		
			//新建会议
	 		window.addDoc = function() {
					dialog.categoryForNewFile(
							'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
							'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{id}',false,null,null,'${JsParam.categoryId}');
		 	};
		
			//当前会议状态
			var checkStatus=function(item){
				var startDate=Com_GetDate(item.start),endDate=Com_GetDate(item.end);
				var now=new Date(parseFloat('${now}'));
				if((item.type == 'meeting' && item.docStatus < 30) || (item.type == 'book' && item.fdHasExam == 'wait')){
					return -2;
				}else{
					//未召开
					if(now.getTime()<startDate.getTime()){
						return -1;
					}
					//进行中
					if(now.getTime()>=startDate.getTime() && now.getTime()<=endDate.getTime()){
						return 0;
					}
					//已召开
					if(now.getTime()>endDate.getTime()){
						return 1;
					}
				}
			};
	
			//数据初始化
			window.transformData=function(datas){
				var main=datas.main;
				for(var key in main){
	
					var t = main[key];
					
					t._renderResRow = function(row, data) {
						
						$(row).css('cursor', 'pointer');
						
						$(row).click(function(){
							window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=view&fdId=' + data.fdId);
						});
						
						if(data.fdNeedExam) {
							$('<span class="tag">需审批</span>').appendTo($(row).find('div'));	
						}
					}
					
					for(var i=0; i < t.list.length; i++){
						var item = t.list[i];
						if(checkStatus(item)==-2){
							item.color = '#F9905A';
						}
						if(checkStatus(item)==-1){
							item.color = '#51b749';
						}
						if(checkStatus(item)==0){
							item.color = '#5484ed';
						}
						if(checkStatus(item)==1){
							item.color = '#fbd75b';
						}
					}
				}
				datas.categoryName = '<bean:message key="kmImeetingRes.fdPlace" bundle="km-imeeting" />';
				return datas;
			};

			//定位
			var getPos=function(evt, obj){
				var sWidth = obj.width();
				var sHeight = obj.height();
				
				var x = 0, y = 0, el = evt.target
				while (el && el.className !== 'km_imeeting_calendar_portal') {
					x += el.offsetLeft
					y += el.offsetTop
					el = el.offsetParent
				}
				
				x += $(evt.target).width() / 2
				y += $(evt.target).height() / 2
				
				
				if((y + sHeight) > $(window).height()){
					y -= sHeight;
				}
				if(x + sWidth > $(el).outerWidth(true)){
					x -= sWidth;
				}
				
				//避免会议室列表过少导致遮挡情况
				if(y < 0) {
					y = 0;
				}
				
				return {"top":y,"left":x};
			};
			
			//新建
			topic.subscribe('calendar.select',function(arg){
				$('.meeting_calendar_dialog').hide();
				var addDialog=$('#meeting_calendar_add');
				//时间格式2014-7-11~2014-7-12
				var date=dateUtil.formatDate(dateUtil.parseDate(arg.start),'${dateFormatter}');
				if(arg.start!=arg.end){
					date+="~"+arg.end;
				}
				var start = dateUtil.formatDate( dateUtil.parseDate(arg.start,'YYYY-MM-hh'),'${dateFormatter}'),
					end = dateUtil.formatDate( dateUtil.parseDate(arg.end,'YYYY-MM-hh'),'${dateFormatter}');
				addDialog.find('.date').html(date);//时间字符串
				addDialog.find('.fdHoldDate').html(start);//召开时间
				addDialog.find('.fdFinishDate').html(end);//结束时间
				addDialog.find('.resId').html(arg.resId);//地点ID
				addDialog.find('.resName').html(env.fn.formatText(arg.resName) );//地点
				addDialog.css(getPos(arg.evt,addDialog)).fadeIn("fast");
				var nowdate = dateUtil.formatDate(new Date(),'${dateFormatter}');
				var startDate = dateUtil.formatDate(dateUtil.parseDate(arg.start),'${dateFormatter}');
				if(nowdate>startDate){
					$('#book_add_btn').hide();
					$('#meeting_add_btn').hide();
					$('#video_add_btn').hide();
				}else{
					$('#book_add_btn').show();
					$('#meeting_add_btn').show();
					$('#video_add_btn').show();
				}
			});

			//查看
			topic.subscribe('calendar.thing.click',function(arg){
				$('.meeting_calendar_dialog').hide();
				var viewDialog;//弹出框
				if(arg.data.type =="book"){
					viewDialog=$("#meeting_calendar_bookview");//会议室预约弹出框
					viewDialog.find(".fdRemark").html(env.fn.formatText( textEllipsis(arg.data.fdRemark) ));//备注
					var fdHasExam = arg.data.fdHasExam;
					if(typeof(fdHasExam) != 'undefined'){
						var fdHasExamDiv = viewDialog.find(".fdHasExam");
						if(fdHasExam == 'wait')
							fdHasExamDiv.addClass('wait').removeClass('refuse').html('<bean:message key="kmImeetingCalendar.res.wait" bundle="km-imeeting"/>');
						else if(fdHasExam == 'false')
							fdHasExamDiv.addClass('refuse').removeClass('wait').html('<bean:message key="kmImeetingCalendar.res.false" bundle="km-imeeting"/>');
						else
							fdHasExamDiv.removeClass('refuse').removeClass('wait').html('');
					}
				}else{
					viewDialog=$("#meeting_calendar_mainview");//会议安排弹出框
					viewDialog.find(".fdHost").html(arg.data.fdHost);//主持人
					var fdHasExamDiv = viewDialog.find(".fdHasExam");
					var docStatus = arg.data.docStatus;
					if(docStatus=='20')
						fdHasExamDiv.addClass('wait').html('<bean:message key="kmImeetingCalendar.res.wait" bundle="km-imeeting"/>');
					else
						fdHasExamDiv.removeClass('wait').html('');
				}
				//时间格式2014-7-11~2014-7-12
				var date=dateUtil.formatDate(arg.data.start,"${dateTimeFormatter}");
				if(arg.data.start!=arg.data.end){
					date+=" ~ "+dateUtil.formatDate(arg.data.end,"${dateTimeFormatter}");
				}
				viewDialog.find(".fdId").html(arg.data.fdId);//fdId
				viewDialog.find(".fdName").html( env.fn.formatText(arg.data.title) );//会议题目
				viewDialog.find(".fdPlace").html( env.fn.formatText(arg.data.fdPlaceName) );//地点
				viewDialog.find('._fdHoldDate').html(dateUtil.formatDate(arg.data.start,"${dateTimeFormatter}"));//召开时间
				viewDialog.find('._fdFinishDate').html(dateUtil.formatDate(arg.data.end,"${dateTimeFormatter}"));//结束时间
				viewDialog.find(".fdHoldDate").html(date);//会议时间
				viewDialog.find('.fdRecurrenceStr').html(arg.data.recurrenceStr || '');
				var cycleNode = viewDialog.find(".isCycle");
				var repeatInfoNode = viewDialog.find(".repeatInfo");
				var fdRepeatInfoNode = viewDialog.find(".fdRepeatInfo");
				if(arg.data.isCycle == 'true'){
					cycleNode.show();
					cycleNode.html("周期会议");
					repeatInfoNode.show();
					fdRepeatInfoNode.html(arg.data.fdRepeatInfo);
				}else{
					cycleNode.hide();
					repeatInfoNode.hide();
				}
				var creator=arg.data.creator;
				if(arg.data.dept){
					creator+="("+arg.data.dept+")";//（部门）
				}
				viewDialog.find(".docCreator").html(creator);//人员（部门）
				
				if(arg.data.type=="book"){//会议预约按钮权限检测
					$('#book_delete_btn,#book_edit_btn').hide();
					$.ajax({
						url: "${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=checkAuth",
						type: 'POST',
						dataType: 'json',
						data: {fdId: arg.data.fdId},
						success: function(data, textStatus, xhr) {//操作成功
							if(data.canEdit){
								$('#book_edit_btn').show();
							}
							if(data.canDelete){
								$('#book_delete_btn').show();
							}
						}
					});
				}else{//会议安排查看按钮权限检测
					$('#meeting_view_btn').hide();
					$.ajax({
						url: "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=checkViewAuth",
						type: 'POST',
						dataType: 'json',
						data: {fdId: arg.data.fdId},
						success: function(data, textStatus, xhr) {//操作成功
							if(data.canView){
								$('#meeting_view_btn').show();
							}
						}
					});
				}
				var today = new Date();
				if($('#book_change_btn').length > 0 ){
					if(today.getTime() > arg.data.start.getTime() || '${userId}' != arg.data.creatorId || arg.data.recurrenceStr){
						$('#book_change_btn').hide();
					}else if(arg.data.fdHasExam == 'wait' || arg.data.fdHasExam == 'false'){
						$('#book_change_btn').hide();
					}else{
						$('#book_change_btn').show();
					}
				}
				viewDialog.find(".type").html(arg.data.type);
				//是否显示重复日程标示
				/* var iconNode = viewDialog.find(".meeting_calendar_dialog_recurrenceIcon");
				if(arg.data.recurrenceStr){
					iconNode.show();
				}else{
					iconNode.hide();
				} */
				viewDialog.css(getPos(arg.evt,viewDialog)).fadeIn("fast");
			});
			
			
			//字符串截取
			function textEllipsis(text){
				text = text || '';
				if(text && text.length>200){
					text=text.substring(0,200)+"......";
				}
				return text;
			}
	});
</script>
<div class="km_imeeting_calendar_portal">
<ui:calendar id="____calendar____imeeting" showStatus="drag"  mode="week"  layout="km.imeeting.calendar.default" type="lui/rescalendar!ResCalendar">
	<%--数据--%>
	<ui:dataformat >
		<ui:var name="selectedCategories" value="${cateIds}"></ui:var>
		<ui:source type="AjaxJson">
			{url:'/km/imeeting/km_imeeting_calendar/kmImeetingCalendar.do?method=rescalendar'}
		</ui:source>
		<ui:transform type="ScriptTransform">
			return transformData(data);
		</ui:transform>
	</ui:dataformat>
</ui:calendar>
<%@ include file="/km/imeeting/km_imeeting_calendar/kmImeetingCalendar_edit.jsp"%>
<%@ include file="/km/imeeting/km_imeeting_calendar/kmImeetingCalendar_view.jsp"%>
</div>
</template:replace>
</template:include>