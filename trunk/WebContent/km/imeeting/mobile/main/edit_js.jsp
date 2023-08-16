<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	require(["mui/form/ajax-form!kmImeetingMainForm"]);
	require(['dojo/ready','dijit/registry','dojo/query','dojo/dom-style','dojo/dom-class','dojo/_base/lang',
	         'mui/dialog/Tip','dojo/request','mui/util','mui/i18n/i18n!km-imeeting:mobile','dojo/dom-attr',
	         'dojo/topic', 'mui/commondialog/DialogSelector'
	         ],
			function(ready,registry,query,domStyle,domClass,lang,Tip,req,util,msg,domAttr,topic,DialogSelector){
		
		function setNeedFeedback(value){
			var feedBackDeadlineTr = query(".feedBackDeadlineTr")[0];
			var fdFeedBackDeadline = registry.byId('fdFeedBackDeadline');
			if(fdFeedBackDeadline){
				if(value){
					domStyle.set(feedBackDeadlineTr,'display','');
					fdFeedBackDeadline._set('validate', 'required after valDeadline');
				}else{
					domStyle.set(feedBackDeadlineTr,'display','none');
					fdFeedBackDeadline._set('validate', '');
				}
			}
		};
		
		function setNeedPlace(value){
			var placeTr = query(".placeResTr");
			
			var placeComponent = registry.byId('placeComponent');
			if(value) {
				placeTr.forEach(function(node,index){
					domStyle.set(placeTr[index],'display','');
				});
				placeComponent._set('validate', 'validateplace validateUserTime');
				var hasTemplate = "${kmImeetingMainForm.fdTemplateId}";
				if(hasTemplate == ""){
					if(isVideo == 'true'){
						otherPlace[0].style.display = 'none';
					}else{
						validorObj._validation.addElements(query('[name="fdOtherPlace"]')[0],'validateplace');
					}
				}
			} else {
				placeTr.forEach(function(node,index){
					domStyle.set(placeTr[index],'display','none');
				});
				placeComponent._set('validate', '');
				placeComponent.curIds = "";
				placeComponent.curNames = "";
				placeComponent.set("value","");
				placeComponent.buildValue(placeComponent.cateFieldShow);
				
			}
		};
		
		window.getStaffingLevel = function(value) {
			var fdHostId = query('input[name="fdHostId"]')[0].value;
			if (!fdHostId && value) {
				fdHostId = value.curIds;
			}
			
			if  (fdHostId) {
				req(util.formatUrl("/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=getPersonInfo"), {
					method : 'post',
					data : {
						"id" : fdHostId
					}
				}).then(function(data) {
					var dataJson = eval("(" + data + ")");
					if(dataJson.level && dataJson.level.name) {
						query("input[name='fdPosition']")[0].value = dataJson.level.name;
						query("span#fdPositionName")[0].innerHTML = dataJson.level.name;
					}
				});
			} else {
				query("input[name='fdPosition']")[0].value = "";
				query("span#fdPositionName")[0].innerHTML = "";
			}
		};
		
		window.buildUnitInfo = function() {
			
			var topicUnitArray = query(".topicUnitId");
			if (topicUnitArray.length > 0) {
				var topicUnitId = "";
				for (var i = 0; i < topicUnitArray.length; i++) {
					if (topicUnitArray[i].value) {
						topicUnitId += topicUnitArray[i].value +";";
					}
				}
				req(util.formatUrl("/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=getUnitName"), {
					method : 'post',
					data : {
						"topicUnitId" : topicUnitId
					}
				}).then(function(data) {
					var dataJson = eval("(" + data + ")");
					if(dataJson.topicUnitNames) {
						query(".topicUnit").innerHTML(dataJson.topicUnitNames);
					}
				});
			}
		};
		
		//校验对象
		var validorObj=null
		
		ready(function(){
			
			query('#fdSchemeName').innerHTML("${kmImeetingMainForm.fdSchemeName}");
			
			buildUnitInfo();
			
			getMeetingDateInfo();
			
			getStaffingLevel();
			
			validorObj=registry.byId('scrollView');
			
			var fdNeedPlace = true;
			setNeedPlace(fdNeedPlace);
			
			var fdNeedFeedback = "${kmImeetingMainForm.fdNeedFeedback}"=="true" ? true : false;
			setNeedFeedback(fdNeedFeedback);
			
			var hostId = '${kmImeetingMainForm.fdHostId}';
			var hostName = '${kmImeetingMainForm.fdHostName}';
			var presidtor = query("#presidtor")[0].children[0];
			
			var digitAddress = registry.byNode(presidtor);
			digitAddress._setCurIdsAttr(hostId);
			digitAddress._setCurNamesAttr(hostName);
			
			//自定义校验器
			validorObj._validation.addValidator("validateUserTime",'${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}',function(v, e, o){
				var result = _validateUserTime();
				if(result == false){
					validator = this.getValidator('validateUserTime');
					var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
					error = error.replace('%fdPlaceName%', query('[name="fdPlaceName"]')[0].value ).replace('%fdUserTime%', query('[name="fdPlaceUserTime"]')[0].value );
					validator.error = error;
				}
				return result;
			});
			validorObj._validation.addValidator("validateViceUserTimes",'${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}',function(v, e, o){
				var result = _validateViceUserTimes();
				if(result == false){
					validator = this.getValidator('validateViceUserTimes');
					var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
					error = error.replace('%fdPlaceName%', query('[name="fdVicePlaceNames"]')[0].value ).replace('%fdUserTime%', query('[name="fdVicePlaceUserTimes"]')[0].value );
					validator.error = error;
				}
				return result;
			});
			
			//自定义校验器:会议地点不能全为空
			validorObj._validation.addValidator("validateplace","{name} ${lfn:message('km-imeeting:kmImeetingMain.tip.notNull')}",function(v, e, o) {
				var result= _validatePlace();
				return result;
			});
			
			//调用结束时间验证
			validorObj._validation.addValidator("beforeFinishDate",'${lfn:message("km-imeeting:kmImeetingMain.fdDate.beforetip")}',function(v, e, o){
				var fdFinishDate = registry.byId('fdFinishDate');
				 validorObj._validation.validateElement(fdFinishDate);
				 return true;
				
			});
			validorObj._validation.addValidator("afterHoldDate",'${lfn:message("km-imeeting:kmImeetingMain.fdDate.tip")}',function(v, e, o){
				return _validateAfterHoldDate();
			});
			
			validorObj._validation.addValidator("valExpectTime",'该时间必须介于开始时间和结束时间之间',function(v, e, o){
				var result = true
				var feedBackDeadVal = Com_GetDate(v);
				var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
				var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
				if( fdHoldDate.getTime()>feedBackDeadVal.getTime() ){
					result=false;
				}
				if( feedBackDeadVal.getTime()>fdFinishDate.getTime() ){
					result=false;
				}
				return result;
			});
			
			validorObj._validation.addValidator("valDeadline",'回执截止时间不能晚于会议开始时间',function(v, e, o){
				var result = true
				var feedBackDeadVal = Com_GetDate(v);
				var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
				var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
				if( fdHoldDate.getTime() < feedBackDeadVal.getTime() ){
					result=false;
				}
				
				return result;
			});
			
			validorObj._validation.addValidator("valuesIsEmpty",'${lfn:message("km-imeeting:kmImeetingMain.agendaNotNull")}',function(v, e, o){
				validator = this.getValidator('valuesIsEmpty');
				var oUl = e.UlNode;
				var Input = oUl.querySelectorAll(".inputNodeClass");
				for(var i = 0;i<(Input?Input.length:0);i++){
					if(Input[i].value==''){
						return false;
					}
				}
				return true; 
			});
			//var duration = parseFloat( query('[name="fdHoldDurationHour"]')[0].value );
			var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
			var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
			var duration = (fdFinishDate.getTime() - fdHoldDate.getTime()) / 3600000;
			
			onHoldDurationChange(duration);
		});
		
		function _validateBeforeFinishDate() {
			var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
			var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
			return fdHoldDate.getTime() < fdFinishDate.getTime();
		};
		
		function _validateAfterHoldDate() {
			var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
			var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
			return fdFinishDate.getTime() > fdHoldDate.getTime();
		};

		
		window.handleDurationChange = function() {
			var fdHoldDateStr = query('[name="fdHoldDate"]')[0].value;
			var fdFinishDateStr= query('[name="fdFinishDate"]')[0].value
			
			//存在兼容问题，2018-9-3 14:00需变成2018/9/3 14:00格式
 			//fdHoldDateStr = fdHoldDateStr.replace(/-/g,'/');
			//fdFinishDateStr = fdFinishDateStr.replace(/-/g,'/'); 
			
			var fdHoldDate = Com_GetDate(fdHoldDateStr);
			var fdFinishDate = Com_GetDate(fdFinishDateStr);
			
			var fdHoldDurationHour = query('[name="fdHoldDurationHour"]')[0];
			
			
			if(fdHoldDurationHour) {
				if((fdFinishDate.getTime() - fdHoldDate.getTime())>0){
					domAttr.set(fdHoldDurationHour, 'value', ((fdFinishDate.getTime() - fdHoldDate.getTime()) / 3600000).toFixed(1));
					onHoldDurationChange((fdFinishDate.getTime() - fdHoldDate.getTime()) / 3600000);
				}else{
					domAttr.set(fdHoldDurationHour, 'value', '');
				}
				
			}
			
		};
		//校验最大使用时长
		function _validateUserTime(){
			var userTime = query('[name="fdPlaceUserTime"]'),
				fdPlaceId = query('[name="fdPlaceId"]');
			if(fdPlaceId[0].value && userTime[0].value){
				//var duration = parseFloat( query('[name="fdHoldDurationHour"]')[0].value ) * 3600 * 1000;
				var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
				var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
				var duration = fdFinishDate.getTime() - fdHoldDate.getTime();
				
				if( parseFloat(userTime[0].value) == 0 ||  parseFloat(userTime[0].value) == 0.0){
					return true;
				} else if( duration > userTime[0].value * 3600 * 1000 ){
					return false;
				}else{
					return true;
				}
			}
			return true;
		};
		function _validateViceUserTimes(){
			var userTime = query('[name="fdVicePlaceUserTimes"]'),
				fdPlaceId = query('[name="fdVicePlaceIds"]');
			if(fdPlaceId[0].value && userTime[0].value){
				//var duration = parseFloat( query('[name="fdHoldDurationHour"]')[0].value ) * 3600 * 1000;
				var fdHoldDate = Com_GetDate(query('[name="fdHoldDate"]')[0].value);
				var fdFinishDate = Com_GetDate(query('[name="fdFinishDate"]')[0].value);
				var duration = fdFinishDate.getTime() - fdHoldDate.getTime();
				
				if( parseFloat(userTime[0].value) == 0 ||  parseFloat(userTime[0].value) == 0.0){
					return true;
				} else if( duration > userTime[0].value * 3600 * 1000 ){
					return false;
				}else{
					return true;
				}
			}
			return true;
		};
		
		function _validatePlace(){
			var fdPlaceId=query('[name="fdPlaceId"]');//地点
			var fdOtherPlace=query('[name="fdOtherPlace"]');//外部地点
			if(fdPlaceId[0].value || fdOtherPlace[0].value){
				return true;
			}else{
				return false;
			}
		};
		
		function valuesIsEmpty(){
			var inputNode = query(".AgendaList")[0].getElementsByTagName('input');
			for(var i = 0;i<inputNode.length;i++){
				if(inputNode[i].value=""){
					return false;
				}
			}
			return true;
		};
		
		window.onHoldDurationChange = function(value){
			var placeComponent = registry.byId('placeComponent');
			validorObj._validation.validateElement(placeComponent);
			
			if('${fdNeedMultiRes}' == 'true') {
				var vicePlaceComponent = registry.byId('vicePlaceComponent');
				validorObj._validation.validateElement(vicePlaceComponent);
			}
			
			var fdHoldDurationHour = query('[name="fdHoldDurationHour"]')[0];
			
			
			if(fdHoldDurationHour) {
				if(value>0){
					domAttr.set(fdHoldDurationHour, 'value', value.toFixed(1));
				}else{
					domAttr.set(fdHoldDurationHour, 'value', '');
				}
			}
		};
		
		//会议提交
		window.commitMethod = function(commitType,dStatus){
			
			var hasTemplate = "${kmImeetingMainForm.fdTemplateId}";
			
			var validorObj=registry.byId('scrollView');

			setTimeout(function() {
				if (validorObj.validate()) {
					var formObj = document.kmImeetingMainForm;
					var docStatus = document.getElementsByName("docStatus")[0];
					//docStatus.value = '30';
				
					if (dStatus=='true') {
						docStatus.value = '20';
					} else {
						docStatus.value = '30';
					}
					var fdHoldDate = query('[name="fdHoldDate"]')[0].value;
					var fdFinishDate = query('[name="fdFinishDate"]')[0].value;
					
					// 校验冲突
					checkConflictAndSubmit(fdHoldDate, fdFinishDate, commitType, formObj);
				}
			}, 100);
		};
		
		// 先校验会议室再辅助资源，通过则提交
		function checkConflictAndSubmit(fdHoldDate, fdFinishDate, commitType, formObj) {
			// 会议室校验通过后校验辅助资源
			checkResConflict(fdHoldDate, fdFinishDate, commitType, formObj);
		};
		
		// 会议室校验
		function checkResConflict(fdHoldDate, fdFinishDate, commitType, formObj) {
			req(util.formatUrl("/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=checkConflict"), {
				handleAs : 'json',
				method : 'post',
				data : {
					bookId : $('[name="bookId"]').val(),
					fdHoldDate:fdHoldDate,
					fdFinishDate : fdFinishDate,
					fdPlaceId : query('[name="fdPlaceId"]')[0].value,
					meetingId : '${JsParam.fdId}'
				}
			}).then(lang.hitch(this, function(data) {
				if (data && !data.result) {
					checkEquConflict(fdHoldDate, fdFinishDate, commitType, formObj);
				} else {
					Tip.tip({icon:'mui mui-warn', text:msg['mobile.kmImeetingMain.conflict.tip'], width:'240', height:'100'});
				}
			}));
		};
		
		// 辅助资源校验
		function checkEquConflict(fdHoldDate, fdFinishDate, commitType, formObj) {
			req(util.formatUrl("/km/imeeting/km_imeeting_equipment/kmImeetingEquipment.do?method=checkConflict"), {
				handleAs : 'json',
				method : 'post',
				data : {
					equipmentIds : query('[name="kmImeetingEquipmentIds"]')[0].value,
					fdHoldDate : fdHoldDate,
					fdFinishDate : fdFinishDate,
					meetingId : '${JsParam.fdId}'
				}
			}).then(lang.hitch(this, function(data) {
				if (data && !data.conflict) {
					if ('save'== commitType) {
						Com_Submit(formObj, commitType);
				    } else {
				    	Com_Submit(formObj, commitType); 
				    }
				} else {
					//冲突
					var conflictNames = '';
					for (var i = 0 ;i < data.conflictArray.length;i++) {
						conflictNames += data.conflictArray[i].name + ';';
					}
					Tip.tip({
						icon:'mui mui-warn',
						text:"资源：" + conflictNames + " 当前时间段存在冲突,请重新选择",
						width:'240',
						height:'120'
					});
				}
			}));
		}
		
		window.selectScheme = function() {
			DialogSelector.select({
				key : '____cateSelect',
				dataURL : '/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=data&q.docStatus=30&isDialog=0&mainDialog=1',
				modelName:'com.landray.kmss.km.imeeting.model.KmImeetingScheme',
				callback : function(evt){
					
					var fdSchemeId = query("[name='fdSchemeId']").val();
					if (evt.curIds != fdSchemeId) {
						query("[name='fdSchemeId']")[0].value = evt.curIds;
						query("[id='fdSchemeName']")[0].innerHTML = evt.curNames;
						var fdUrl = "";
						var method = "${kmImeetingMainForm.method}";
						if (method == "add") {
							fdUrl = util.setUrlParameter(location.href, "fdSchemeIds", evt.curIds);
							fdUrl = util.setUrlParameter(fdUrl, "_referer", );
							fdUrl = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?"
									+ "method=add&fdTemplateId=${kmImeetingMainForm.fdTemplateId}" + "&_referer=" + util.formatUrl("/km/imeeting/mobile", true)
									+ "&i.docTemplate=${kmImeetingMainForm.fdTemplateId}&fdSchemeIds=" + evt.curIds;
						} else if(method == "edit"){
							fdUrl = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=edit"
									+ "&_referer=" + util.formatUrl("/km/imeeting/mobile", true)
									+ "&fdId=${kmImeetingMainForm.fdId}&fdSchemeIds=" + evt.curIds + "&schemeFlag=true";
						} else if (method == "changeMeeting") {
							fdUrl = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeMeeting"
								+ "&_referer=" + util.formatUrl("/km/imeeting/mobile", true)
								+ "&fdId=${kmImeetingMainForm.fdId}&fdSchemeIds=" + evt.curIds + "&schemeFlag=true";
						}
						window.open(util.formatUrl(fdUrl), "_self");
					}
			}
		})
	};
	
	window.getMeetingDateInfo = function() {
		var fdMeetingHoldDateStr = query("[name='fdHoldDate']")[0].value;
		var fdMeetingEndDateStr = query("[name='fdFinishDate']")[0].value;
		if (fdMeetingHoldDateStr) {
			query('div.kmImeetingHoldTimeTip')[0].innerHTML = "";
			
			var fdholdTime = util.parseDate(fdMeetingHoldDateStr, "yyyy-MM-dd HH:mm");
			
			var holdDate = getDateTimeMessage(fdholdTime, "MM:dd:D");
			query('div.kmImeetingHoldDate')[0].innerHTML = holdDate;
			
			var holdTime = getDateTimeMessage(fdholdTime, "HH:mm");
			query('div.kmImeetingHoldTimeContent')[0].innerHTML = holdTime;
		} else {
			query('div.kmImeetingHoldDate')[0].innerHTML = "";
			query('div.kmImeetingHoldTimeContent')[0].innerHTML = "";
			query('div.kmImeetingHoldTimeTip')[0].innerHTML = "请选择";
		}
		
		if (fdMeetingEndDateStr) {
			query('div.kmImeetingEndTimeTip')[0].innerHTML = "";
			
			var fdEndTime = util.parseDate(fdMeetingEndDateStr, "yyyy-MM-dd HH:mm");

			var endDate = getDateTimeMessage(fdEndTime, "MM:dd:D");
			query('div.kmImeetingEndDate')[0].innerHTML = endDate;
			
			var endTime = getDateTimeMessage(fdEndTime, "HH:mm");
			query('div.kmImeetingEndTimeContent')[0].innerHTML = endTime;
		} else {
			query('div.kmImeetingEndDate')[0].innerHTML = "";
			query('div.kmImeetingEndTimeContent')[0].innerHTML = "";
			query('div.kmImeetingEndTimeTip')[0].innerHTML = "请选择";
		}
	};
	
	function getDateTimeMessage(fdTime, type) {
		
		// 小时分钟
		if ("HH:mm" == type) {
			
			// 小时
			var hour =  fdTime.getHours() < 10 ? "0" + fdTime.getHours() : fdTime.getHours();
			
			// 分钟
			var min = fdTime.getMinutes() < 10 ? "0" + fdTime.getMinutes() : fdTime.getMinutes();
			
			return hour + ":" + min;
		}
		
		// 月份日期带周几
		if ("MM:dd:D" == type) {
			
			var week = new Array("周日", "周一", "周二", "周三", "周四", "周五", "周六");
			
			// 月份
			var month = fdTime.getMonth();
			
			// 号
			var date = fdTime.getDate();
			
			// 礼拜几
			var day = fdTime.getDay();
			
			return (month + 1) + "月" + date + "号" + " " + week[day];
		}
	};
	
	
	});
</script>