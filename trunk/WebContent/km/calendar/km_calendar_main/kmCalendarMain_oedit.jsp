<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/km/calendar/import/calendarMinuteStep.jsp"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%
	request.setAttribute("formatter", ResourceUtil.getString("date.format.date"));
%>
<script>
	seajs.use(['theme!form']);//form样式
	Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js|calendar.js|form.js",null,"js");
	seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
		var control = true;
		var label_html_all = null;
		var label_html_myEvent = "<option value=\"\" >${lfn:message('km-calendar:module.km.calendar.tree.my.calendar')}</option>";		
	
		window.eventValidation=null;//日程校验框架
		window.noteValidation=null;//笔记校验框架
		//初始化校验框架
		LUI.ready(function(){
			eventValidation=$KMSSValidation($("#simple_event")[0],{
				afterElementValidate : function(result, element) {
					if(!result){
						if(element.id == 'docStartTime'||element.id == 'docFinishTime'){
							$("#"+element.id).parents(".inputselectsgl").css("border-color","#fb6e57");
						}else if(element.id == 'docSubject'){
							$("#"+element.id).css("border-color","#fb6e57");
						}
					}else{
						if(element.id == 'docStartTime'||element.id == 'docFinishTime'){
							$("#"+element.id).parents(".inputselectsgl").css("border-color","#ccc");
						}else if(element.id == 'docSubject'){
							$("#"+element.id).css("border-color","#ccc");
						}
					}
					return true;
				}
			});
			noteValidation=$KMSSValidation($("#simple_note")[0],{
				afterElementValidate : function(result, element) {
					if(!result){
						if(element.id == 'docSubject_note'||element.id == 'docContent_note'){
							$("#"+element.id).css("border-color","#fb6e57");
						}
					}else{
						if(element.id == 'docSubject_note'||element.id == 'docContent_note'){
							$("#"+element.id).css("border-color","#ccc");
						}
					}
					return true;
				}
			});
			//提示：以下人员授权您为他/她创建日程
			$("#docOwnerId").click(function(){
				if($("#docOwnerId option").length>1){
					$("#ownerTip").toggle();
				}
			});
		});
		  
		//新增
		window.save=function(formId){
			var result=true;
			var url="";
			//提交前校验
			if(formId=="simple_event"){
				result=eventValidation.validate();
				url+="${LUI_ContextPath}/km/calendar/km_calendar_main/kmCalendarMain.do?method=saveEvent&simple=true";
				//校验时间
				var _startTime=$("[name='docStartTime']").val();
				var _finishTime=$("[name='docFinishTime']").val();
				//非全天.加上时、分
				if(!$("#fdIsAlldayevent").prop('checked')){
					_startTime+=" "+$("#startHour option:selected").val()+":"+$("#startMinute option:selected").val()+":00";
					_finishTime+=" "+$("#endHour option:selected").val()+":"+$("#endMinute option:selected").val()+":00";
				}
				 if(Date.parse(Com_GetDate(_finishTime))<Date.parse(Com_GetDate(_startTime))){
					 dialog.alert("${lfn:message('km-calendar:kmCalendarMain.tip.validateDate.errorDate')}");
			    	return false;
				}
			}else{
				result=noteValidation.validate();
				url+="${LUI_ContextPath}/km/calendar/km_calendar_main/kmCalendarMain.do?method=saveNote";
			}
	    	if(result==false){
		    	return;
		    }
			LUI.$.ajax({
				url: url,
				type: 'POST',
				dataType: 'json',
				async: false,
				data: $("#"+formId).serialize(),
				beforeSend:function(){
					//window.loading = dialog.loading();
				},
				success: function(data, textStatus, xhr) {//操作成功
					if (data && data['status'] === true) {
						//window.loading.hide();
						if(data.isSelf){
							if(typeof setColor!="undefined"){
								setColor(data['schedule']);//设置标签颜色
							}
							LUI('calendar').addSchedule(data['schedule']);
						}else{
							dialog.success("<bean:message key='return.success' arg0=''/>");
						}
						window.close_edit();//关闭窗口
					}
				},
				error:function(xhr, textStatus, errorThrown){//操作失败
					//window.loading.hide();
					dialog.failure('<bean:message key="return.optFailure" />');
					window.close_edit();
				}
			});
		};
		
		//关闭
		window.close_edit=function(){
			$(":reset").trigger("click");
			$("#calendar_add").fadeOut();//隐藏对话框
			
		};
		
		//打开日程详细页面
		window.openEvent=function(init){
			var url = "/km/calendar/km_calendar_main/kmCalendarMain.do?method=addEvent";
			//需要初始化参数(将简单页面的数据带入详细页面)
			if(init){
				var isAllDayEvent = $("#fdIsAlldayevent").prop('checked');
				var subject = $("#docSubject").val();
				subject=encodeURIComponent(subject);//转码
				var startTime = $("#docStartTime").val();
				var endTime = $("#docFinishTime").val();
				var labelId = $("#simple_event :input[name='labelId']").val();
				var ownerId = $("#simple_event :input[name='docOwnerId']").val();
				var ownerName = $("#simple_event :input[name='docOwnerName']").val();
				url += "&isAllDayEvent="+isAllDayEvent+"&subject="+subject+"&startTime="+startTime+"&endTime="+endTime+"&labelId="+labelId+"&ownerId="+ownerId+"&ownerName="+encodeURI(ownerName);
				//不是全天,带出小时、分钟
				if(!isAllDayEvent){
					 var startHour = $("#startHour").val();
					 var startMinute = $("#startMinute").val();
					 var endHour = $("#endHour").val();
					 var endMinute = $("#endMinute").val();
					 url += "&startHour="+startHour+"&startMinute="+startMinute+"&endHour="+endHour+"&endMinute="+endMinute;
				}
			}
			var header = '<ul class="clrfix schedule_share"><li class="current" id="event_base_label">${lfn:message("km-calendar:kmCalendarMain.opt.create")}</li>'
					+ '<li>|</li><li id="event_auth_label">${lfn:message("km-calendar:kmCalendar.label.table.share")}</li>'
					+ '</ul>';
			var dia = dialog.iframe(url,header,function(rtn){
				if(rtn != null){
					//重复日程直接刷新整个界面
					if(rtn.isRecurrence != null && rtn.isRecurrence==true){
						LUI('calendar').refreshSchedules();
						return ;
					}
					if(rtn.schedule!=null && rtn.isSelf == true){
						if(typeof setColor!="undefined"){
							setColor(rtn.schedule);
						}
						LUI('calendar').addSchedule(rtn.schedule);
					}
				}
			},{width:700,height:550});
			// 防止拖拽控件引起标题切换无法点击
			dia.on('layoutDone',function(){
				var title = this.title;
				title.mousedown(function(evt) {
					evt.stopPropagation();
				});
			});
			window.close_edit();//关闭简单编辑页面
		};


		//打开笔记详细页面
		window.openNote=function(){
			var url = "/km/calendar/km_calendar_main/kmCalendarMain.do?method=addNote";
			var subject = $("#docSubject_note").val();
			subject=encodeURIComponent(subject);//转码
			var docContent = $("#docContent_note").val();
			docContent=encodeURIComponent(docContent);//转码
			var labelId = $("#simple_noteTab :input[name='labelId']").val();
			var startTime = $("#docStartTimeNote").val();
			url += "&subject="+subject+"&labelId="+labelId+"&startTime="+startTime+"&docContent="+docContent;
			window.close_edit();//关闭简单编辑页面
			dialog.iframe(url,"${lfn:message('km-calendar:kmCalendarMain.opt.note.create')}",function(schedule){
				if(schedule!=null){
					if(typeof setColor!="undefined"){
						setColor(schedule);
					}
					LUI('calendar').addSchedule(schedule);
				}
			},{width:750,height:550});
		};

		//是否全天
		window.changeAllDayValue=function(){
			var isAllday=$("#fdIsAlldayevent").prop('checked');
			if(isAllday){
				$("#startTimeDiv,#endTimeDiv,#startTimeDivLunar,#endTimeDivLunar").css("display","none");
			}else{
				var date = new Date();
				var hours = date.getHours();
				var minutes = date.getMinutes();
				$("#startHour").val(date.getHours()+1);
				//$("#startMinute").val(date.getMinutes());
				if(date.getHours()>=22){
					$("#endHour").val(23);
					$("#endMinute").val(59);
				}else{
					date.setHours(date.getHours()+2);
					$("#endHour").val(date.getHours());
					//$("#endMinute").val(date.getMinutes());	
				}
				$("#startTimeDiv,#endTimeDiv,#startTimeDivLunar,#endTimeDivLunar").css("display","inline");
			}
		};

		//开始时间改变
		window.startMinuteSelect=function(){
			if(parseInt($("#startHour").val())>=22){
				$("#endHour").val(23);
				$("#endMinute").val(59);	
			}else{
				$("#endHour").val(parseInt($("#startHour").val())+2);
				$("#endMinute").val($("#startMinute").val());
			}	
		};
		
		//标签切换(日程、笔记)
		window.switchTab=function(type){
			if(type=='event'){
				$('#tab_event').addClass("current");
				$('#tab_note').removeClass("current");
				$('#simple_calendarTab').show();
				$('#simple_noteTab').hide();
				clearReminder('#simple_event');
			}else{
				var date=$("#docStartTime").val();
				if(date==""){
					var today=new Date();
					date=today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();
				}
				$("#docStartTimeNote").val(date);
				$('#tab_event').removeClass("current");
				$('#tab_note').addClass("current");
				$('#simple_calendarTab').hide();
				$('#simple_noteTab').show();
				clearReminder('#simple_note');
				$("#simple_note").submit(function(e){
					//事件不冒泡
					e.preventDefault();
				});
			}
		};

		//开始时间改变时，校验结束时间是否小于开始时间，如果小于将结束时间=开始时间
		window.docStartTimeChange=function(obj){
			if($("[name='docFinishTime']").val()==null || $("[name='docFinishTime']").val()==""){
				return;
			}
			var docStartTime=formatDate($("[name='docStartTime']").val(),"${formatter}");
			var docFinishTime=formatDate($("[name='docFinishTime']").val(),"${formatter}");
			if(docStartTime.getTime()>docFinishTime.getTime()){
				$("[name='docFinishTime']").val($("[name='docStartTime']").val());	
			}
		};
		
		//修改日程所有者
		window.changeOwner = function(){
			if(control){
				label_html_all = $(".fixedSelect").html();
				control=false;
			}
			var url = '/km/calendar/km_calendar_label/kmCalendarLabel.do?method=listJson';
			var docOwner=$("#docOwnerId"),
				selectedIndex = docOwner.get(0).selectedIndex,				
				selectedValue = docOwner.get(0).value;
			if(selectedIndex == 0){
				//日程所有者为自己时可选标签
				LUI("label_edit").source.url = url;
				LUI("label_edit").source.get();							
			}else if(docOwner.val()=="multiCreate"){
				//日程所有者为群组时只可以选默认标签(即"我的日历")
				$(".fixedSelect").html(label_html_myEvent);
			}else{
				//日程所有者为别人时只可以选系统标签
				LUI("label_edit").source.url = url + "&userId=" + docOwner.val();
				LUI("label_edit").source.get();				
			}
			//创建群组日程
			if(docOwner.val()=="multiCreate"){
				//显示群组地址本
				$("#multiOwner").show();
				emptyNewAddress('docOwnerNames',null,0);
			}else{
				//隐藏群组地址本
				$("#multiOwner").hide();
			}
		};
	});

	function setTab(name, cursel, n) {
	    for (var i = 1; i <= n; i++) {
	        var menu = document.getElementById(name + i);
	        var con = document.getElementById("con_" + name + "_" + i);
	        menu.className = i == cursel ? "current" : "";
	        con.style.display = i == cursel ? "block" : "none";
	    }
	};

	

	
</script>
<%--新增日程DIV--%>
<div class="lui_calendar calendar_add" id="calendar_add" style="position: absolute; display: none;z-index:100">
	<%--顶部操作栏--%>
	<div class="lui_calendar_top">
   		<div class="lui_calendar_title">
   			<ul class="clrfix schedule_share">
   				<%--切换到日程--%>
                <li class="current" id="tab_event" onclick="switchTab('event')">
                	<bean:message bundle="km-calendar" key="kmCalendar.label.table.calender" />
                </li>
                <li>|</li>
                <%--切换到笔记--%>
                <li id="tab_note" onclick="switchTab('note');">
                	<bean:message bundle="km-calendar" key="kmCalendarMain.note" />
                </li>
            </ul>
   		</div>
        <div class="lui_calendar_close" onclick="close_edit();"></div>
   	</div>
   	<%--日程页面--%>
   	<div class="lui_calendar_view_content" id="simple_calendarTab">
	   	<div>
	   	<div class="add_sched_wrapper">
	   	<form id="simple_event"  name="kmCalendarMainForm">
	   		<input type="reset" style="display: none;" />
	   		<input type="hidden" name="fdType" id="simple_fdType_event" value="event" />
	        <table class="add_sched tb_simple">
	       		<tr>
	       			<%--内容--%>
	                <td width="20%" class="td_normal_title" valign="top">
	                	<bean:message bundle="km-calendar" key="kmCalendarMain.docContent" />
	                 </td>
                    <td width="80%">
                    	<xform:textarea showStatus="edit" htmlElementProperties="id='docSubject'" required="true" isLoadDataDict="fasle" validators="maxLength(500)"
                    		subject="${lfn:message('km-calendar:kmCalendarMain.docContent')}" property="docSubject" style="width:95%;"/>
                    </td>
               </tr>
	         	<tr>
	         		<%--时间--%>
	                <td width="20%" class="td_normal_title" valign="top">
	                	<bean:message bundle="km-calendar" key="kmCalendarMain.docTime" />
	                </td>
	                <td width="80%">
	                	<div class="div_normal">
	                		<%--是否全天--%>
                            <input type="checkbox" id="fdIsAlldayevent" name="fdIsAlldayevent" value="true" onclick="changeAllDayValue();"/>
                            <label><bean:message bundle="km-calendar" key="kmCalendarMain.allDay" /></label>
                         </div>
                         <div id="div_lunar" class="div_lunar" style="display: none;">
                            <select>
                                <option>2001年</option>
                              </select>
                          </div>
                          <%--时间--%>
                          <div id="div_fullDay" >
                          	<%--开始时间--%>
                        	<xform:datetime showScheduling="true" showStatus="edit" htmlElementProperties="id='docStartTime'" property="docStartTime" onValueChange="docStartTimeChange"
                        		 style="width:39%" dateTimeType="date" required="true" isLoadDataDict="false" subject="${lfn:message('km-calendar:kmCalendarMain.docStartTime')}"/>
                            <div id="startTimeDiv" style="top: -10px;position: relative; display: none;">
                            	<select name="startHour" id="startHour" onclick="startMinuteSelect()">
                            		<c:forEach begin="0" end="23" varStatus="status" >
                               			<option value="${status.index}">${status.index}</option>
                               		</c:forEach>
                            	</select>
                            	<bean:message bundle="km-calendar" key="hour" />
                            	<select name="startMinute" id="startMinute" onclick="startMinuteSelect()">
									<c:forEach items="${calendarMinuteList}" var="minute" >
										<option value="${minute}">${minute}</option>
									</c:forEach>
                            	</select>
                            	<bean:message bundle="km-calendar" key="minute" />
                            </div>
                            <span style="top: -10px;position: relative;">—</span>
                            <%--结束时间--%>
                            <xform:datetime showScheduling="true" showStatus="edit"  htmlElementProperties="id='docFinishTime'"  property="docFinishTime" 
                            	style="width:39%" dateTimeType="date" required="true" isLoadDataDict="false" subject="${lfn:message('km-calendar:kmCalendarMain.docFinishTime')}"/>
                       		<div id="endTimeDiv" style="top: -10px;position: relative; display: none;">
                            	<select id="endHour" name="endHour">
                            		<c:forEach  begin="0" end="23" varStatus="status" >
                               			<option value="${status.index}">${status.index}</option>
                               		</c:forEach>
                            	</select>
                            	<bean:message bundle="km-calendar" key="hour" />
                            	<select id="endMinute" name="endMinute">
									<c:forEach items="${calendarMinuteList}" var="minute" >
										<option value="${minute}">${minute}</option>
									</c:forEach>
                            	</select>
                            	<bean:message bundle="km-calendar" key="minute" />
                            </div>
                        </div>
	                </td>
                </tr>
                <tr>
                	<%--标签--%>
                	<td width="20%" class="td_normal_title" valign="top">
                		<bean:message bundle="km-calendar" key="kmCalendarMain.docLabel" />
                	</td>
                	<td>
                	<div>
                		<div style="float:left">
                	  	<ui:dataview id="label_edit" style="float:left;">
                	  		<ui:source type="AjaxJson">
								{url:'/km/calendar/km_calendar_label/kmCalendarLabel.do?method=listJson'}
							</ui:source>
							<ui:render type="Template">
								<c:import url="/km/calendar/tmpl/label_select.jsp" charEncoding="UTF-8"></c:import>
							</ui:render>
						</ui:dataview>
						</div>
						<div style="float:left;margin-top:4px;cursor: pointer;">
							<a onclick="kmCalendarList();" class="link">
								<bean:message bundle="km-calendar" key="kmCalendarLabel.tab.list" />
							</a>
						</div>
						</div>
                     </td>
                     
             	</tr>
             	<tr>
	        	<%--所有者--%>
		        	<td width="20%" class="td_normal_title" valign="top">
	              		<bean:message bundle="km-calendar" key="kmCalendarMain.docOwner" />
	              	</td>
					<td width="80%">
						<input type="hidden" name="docOwnerId" />
						<span id="docOwnerName"></span>
						<input type="hidden" name="docOwnerName" />
					</td>
	        	</tr>
				<kmss:authShow roles="ROLE_KMCALENDAR_MULTI_CREATE">
					<%--所有者(发起多人日程时以地址本选择)--%>
					<tr id="multiOwner" style="display: none;">
						<td width="15%" class="td_normal_title" >
							<bean:message bundle="km-calendar" key="kmCalendarShareGroup.fdGroupMemberIds" />
						</td>
						<td width="85%" colspan="3" >
							<div _xform_type="address">
								<xform:dialog subject="${lfn:message('km-calendar:kmCalendarShareGroup.fdGroupMemberIds') }" style="width:90%;" propertyId="docOwnerIds"
											  propertyName="docOwnerNames" showStatus="edit">
									Dialog_AddressList(true,'docOwnerIds','docOwnerNames',';','kmCalendarAuthService',null,'kmCalendarAuthService&fdName=!{keyword}',null,null,'${ lfn:message('km-calendar:kmCalendarShareGroup.fdGroupMemberIds') }');
								</xform:dialog>
								<span class="txtstrong">*</span>
							</div>
						</td>
					</tr>
				</kmss:authShow>
	        </table>
	     </form>
	   	</div></div>
		<%--底部操作栏(详细设置)--%>	   
	   	 <div class="lui_shades_btnGroup clrfix">
		 	<div class="left">
		 		<a class="btn_Calendar_add" onmousedown="openEvent(true,event);">
		 			<bean:message bundle="km-calendar" key="kmCalendarMain.moreSetting" />
		 		</a>
		 	</div>
		 	<div class="right">
		 		 <ul class="shade_btn_box clrfix">
	               	<li id="owner_desc" style="font-size: 13px;color: darkgray;"></li>
	               	<li>
	               		<ui:button text="${lfn:message('button.save')}"  styleClass="lui_toolbar_btn_gray" onclick="save('simple_event');"/>
	               	</li>
	              </ul>
		 	</div>
		</div>
   	</div>
   	
   	
   <%--笔记--%>
   	<div id="simple_noteTab" style="display: none;">
   	<div>
	   	<div class="add_sched_wrapper">
	   	<form action="/km/calendar/km_calendar_main/kmCalendarMain.do" id="simple_note" name="kmCalendarNodeForm">
	   		<input type="reset" style="display: none;" />
	   		<input type="hidden" name="fdType" id="simple_fdType_note" value="note" />
	   		<input type="hidden" name="docStartTime"  id="docStartTimeNote"/>
	        <div  id="simple_noteTab">
           		<div style="width: 350px;" >
                	<table class="add_sched tb_simple">
                    	<tr>
                    		<%--主题--%>
                        	<td width="20%" class="td_normal_title" >
                             	<bean:message bundle="km-calendar" key="kmCalendarMain.docSubject"/>
                             </td>
                             <td>
                             	<xform:text showStatus="edit" property="docSubject" htmlElementProperties="id='docSubject_note'" 
                             		subject="${lfn:message('km-calendar:kmCalendarMain.docSubject')}" style="width:95%;" required="true" />
                             </td>
                        </tr>
                        <tr>
                        	<%--内容--%>
                        	<td width="20%" class="td_normal_title" >
                            	<bean:message bundle="km-calendar" key="kmCalendarMain.docContent"/>
                            </td>
                            <td>
                            	<xform:textarea showStatus="edit" property="docContent" htmlElementProperties="id='docContent_note'" 
                            		subject="${lfn:message('km-calendar:kmCalendarMain.docContent')}" style="width:95%;" required="true" />
                           </td>
                        </tr>
                        
                     </table>
                  </div>
              </div>
	     </form>
	   	</div>
	   	</div>
	   	<%--底部操作栏--%>
	   	 <div class="lui_shades_btnGroup clrfix">
		 	<div class="left">
		 		<a class="btn_Calendar_add" onmousedown="openNote();">
		 			<bean:message bundle="km-calendar" key="kmCalendarMain.moreSetting" />
		 		</a>
		 	</div>
		 	<div class="right">
		 		 <ul class="shade_btn_box clrfix">
	               	<li>
	               		<ui:button text="${lfn:message('button.save')}"  styleClass="lui_toolbar_btn_gray" onclick="save('simple_note');"/> 
	               	</li>
	              </ul>
		 	</div>
		</div>
   	</div>
</div>

