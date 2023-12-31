<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	pageContext.setAttribute("_isBoenEnable", new Boolean(KmImeetingConfigUtil.isBoenEnable()));
%>
<script>
	var validation=$KMSSValidation(document.forms['kmImeetingMainForm']);//校验框架
	Com_IncludeFile("security.js",null,"js");
</script>
<script>

	seajs.use([
	      'km/imeeting/resource/js/dateUtil',
	      'km/imeeting/resource/js/arrayUtil',
	      'lui/jquery',
	      'lui/dialog',
	      'lui/topic',
	      'lui/util/env'],function(dateUtil,arrayUtil,$,dialog,topic,env){
		
		LUI.ready(function(){
			check3();
		});
		function check3(){
			$(":checkbox").each(function(){
				if($(this).attr("checked") == "checked"){
					console.log($(this).val());
				}
			});
		}
		
		/* $("input[value='mobile']").οnclick(function(e){
			consol.log("ss");
		}); */
		
		window.clickSysUiStep = function(stepFlag){
			 $("input[data-lui-mark='step." + stepFlag + "']").click();
		};
		
		
		 $('[name="fdPlaceName"]').hover(function(){
			 if($('.roomDetail').html()!=''){
				 $('.roomDetail').show();
			 }
          },function(){
       	   $('.roomDetail').hide();
             });
		
		
		//校验召开时间不能晚于结束时间
		var _compareTime=function(){
			var fdHoldDate=$('[name="fdHoldDate"]');
			var fdFinishedDate=$('[name="fdFinishDate"]');
			var result=true;
			if( fdHoldDate.val() && fdFinishedDate.val() ){
				var start=dateUtil.parseDate(fdHoldDate.val());
				var end=dateUtil.parseDate(fdFinishedDate.val());
				if( start.getTime()>=end.getTime() ){
					result=false;
				}
			}
			return result;
		};
		
		validation.addValidator('valExpectTime','该时间必须介于开始时间和结束时间之间',function(v, e, o){
			var feedBackDeadVal = dateUtil.parseDate(v);
			var result=true;
			var fdHoldDate=$('[name="fdHoldDate"]');
			var fdFinishedDate=$('[name="fdFinishDate"]');
			if( fdHoldDate.val()){
				var start=dateUtil.parseDate(fdHoldDate.val());
				if (feedBackDeadVal) {
					if( start.getTime()>feedBackDeadVal.getTime() ){
						result=false;
					}
				}else{
					result=false;
				}
				
			}
			if(fdFinishedDate.val()){
				var end=dateUtil.parseDate(fdFinishedDate.val());
				if (feedBackDeadVal) {
					if( feedBackDeadVal.getTime()>end.getTime() ){
						result=false;
					}
				}else{
					result=false;
				}
			}
			return result;
		});
		
		validation.addValidator('valDeadline','回执截止时间不能晚于会议开始时间',function(v, e, o){
			var feedBackDeadVal = dateUtil.parseDate(v);
			var result=true;
			var fdHoldDate=$('[name="fdHoldDate"]');
			var fdFinishedDate=$('[name="fdFinishDate"]');
			if( fdHoldDate.val()){
				var start=dateUtil.parseDate(fdHoldDate.val());
				if( feedBackDeadVal.getTime() > start.getTime()){
					result=false;
				}
			}
			return result;
		});
		
		//自定义校验器:校验召开时间不能晚于结束时间
		validation.addValidator('compareTime','${lfn:message("km-imeeting:kmImeetingMain.fdDate.tip")}',function(v, e, o){
			 var fdHoldDate=document.getElementsByName('fdHoldDate')[0];
			 var result=true;
			 if(e.name=="fdFinishDate"){//fdFinishDate的这个校验与fdHoldDate的相同，直接执行fdHoldDate的
				 validation.validateElement(fdHoldDate);
			 }else{
				 result= _compareTime();
			 }
			//存在地点,进行会议时长校验
			 var place = $('[name="fdPlaceName"]');
			 if(place.val()){
				 validation.validateElement(place[0]);
			 }
			return result;
		});
		
		var _validateDuration = function(){
			var fdHoldDurationHour = $('[name="fdHoldDurationHour"]'),
				fdHoldDurationMin = $('[name="fdHoldDurationMin"]'),
				fdHoldDate=$('[name="fdHoldDate"]'),
				fdFinishedDate=$('[name="fdFinishDate"]');
			if(fdHoldDurationHour.val() && fdHoldDurationMin.val() && fdHoldDate.val() && fdFinishedDate.val()){
				var realDuration =  _caculateDuration(fdHoldDate.val(),fdFinishedDate.val())[0],
					duration = fdHoldDurationHour.val()* 3600 * 1000 + fdHoldDurationMin.val() * 60 * 1000,
					durationValidator = validation.getValidator('validateDuration');
				var ___name = '${lfn:message("km-imeeting:kmImeetingMain.fdHoldDuration")}';
				if(duration > realDuration){
					var ___error = '${lfn:message("km-imeeting:kmImeetingMain.fdHoldDuration.tip")}';
					___error = ___error.replace(___name,'{name} ');
					durationValidator.error = ___error;
					return false;
				}
				if(duration == 0){
					var ___error = '${lfn:message("km-imeeting:kmImeetingMain.fdHoldDuration.zore.tip")}';
					___error = ___error.replace(___name,'{name} ');
					durationValidator.error = ___error
					return false;
				}
			}
			return true;
		};
		
		//修改时间触发
		var changeDateTime=function(___value,___element){
			var fdHoldDate=$('[name="fdHoldDate"]').val();//召开时间
			var fdFinishDate=$('[name="fdFinishDate"]').val();//结束时间
			var fdPlaceId=$('[name="fdPlaceId"]').val();//地点时间
			//选择了开始时间后，结束时间默认带出
			if( fdHoldDate && !fdFinishDate && ___element && ___element.name =='fdHoldDate' ){
				var ___finishDate = dateUtil.parseDate(fdHoldDate).getTime() + 3600 * 1000;
				___finishDate = dateUtil.formatDate(new Date(___finishDate),'${dateTimeFormatter}');
				$('[name="fdFinishDate"]').val(___finishDate);
				fdFinishDate=___finishDate;
			}
			if(fdHoldDate && fdFinishDate ){
				//如果结束日期早于召开日期，自动调整结束日期为开始日期
				if(dateUtil.parseDate(fdHoldDate).getTime()>dateUtil.parseDate(fdFinishDate).getTime()){
					var ___finishDate = dateUtil.parseDate(fdHoldDate).getTime() + 3600 * 1000;
					___finishDate = dateUtil.formatDate(new Date(___finishDate),'${dateTimeFormatter}');
					$('[name="fdFinishDate"]').val(___finishDate);
					fdFinishDate=___finishDate;
				}
				validation.validateElement($('[name="fdFinishDate"]')[0]);
				
				var duration=_caculateDuration(fdHoldDate,fdFinishDate);
				// 设置会议历时
				$('[name="fdHoldDuration"]').val(duration[0]);
				// $('[name="fdHoldDurationHour"]').val(duration[1]);
				// $('[name="fdHoldDurationMin"]').val(duration[2]);
				
				//设置临时值
				$('[name="fdHoldDateTmp"]').val(fdHoldDate);
				$('[name="fdFinishDateTmp"]').val(fdFinishDate);
				
			}
		};

		//自定义校验器:校验会议历时不能大于会议实际时差
		validation.addValidator('validateDuration','${lfn:message("km-imeeting:kmImeetingMain.fdHoldDuration.tip")}',function(v,e,o){
			var fdHoldDurationHour = document.getElementsByName('fdHoldDurationHour')[0],
				result = true;
			if(e.name=='fdHoldDurationMin'){//fdHoldDurationMin的这个校验与fdHoldDurationHour的相同，直接执行fdHoldDurationHour的
				 validation.validateElement(fdHoldDurationHour);
			}else{
				result = _validateDuration();
			}
			return result;
		});
		
		//校验与会人员和外部与会人员不全为空
		var _validatePerson=function(){
			var attendPerson=$('[name="fdAttendPersonIds"]').val();//与会人员
			var otherAttendPerson=$('[name="fdOtherAttendPerson"]').val();//外部与会人员
			if( attendPerson || otherAttendPerson){
				return true;
			}else{
				return false;
			}
		};
		
		//自定义校验器:参加人员和外部参加人员不能全为空
		validation.addValidator('validateattend','{name} ${lfn:message("km-imeeting:kmImeetingMain.tip.notNull")}',function(v, e, o){
			 var fdAttendPersonNames = $('[data-propertyname="fdAttendPersonNames"]')[0];
			 var result=true;
			 if(e.name=="fdOtherAttendPerson"){
				 validation.validateElement(fdAttendPersonNames);
			 }else{
				 result= _validatePerson();
				 if(result && $('[name="fdOtherAttendPerson"]').parent()){
					setTimeout(function(){
						$('[name="fdOtherAttendPerson"]').parent().find(".validation-advice").hide();
					},10);
				 }
			 }
			return result;
			
		});
		
		//校验最大使用时长
		var _validateUserTime = function(){
			var userTime = $('[name="fdPlaceUserTime"]'),
				fdPlaceId = $('[name="fdPlaceId"]');
			if(fdPlaceId.val() && userTime.val() && parseFloat(userTime.val()) ){
				var start = $('[name="fdHoldDate"]').val(),
					end = $('[name="fdFinishDate"]').val(),
					duration = _caculateDuration(start, end)[0];
				if( duration > userTime.val() * 3600 * 1000 ){
					return false;
				}else{
					return true;
				}
			}
			return true;
		};
		
		var _validateViceUserTime = function(){
			var viceUserTimes = $('[name="fdVicePlaceUserTimes"]');
			var vicePlaceNames = $('[name="fdVicePlaceNames"]');
			if(viceUserTimes.val()){
				var start = $('[name="fdHoldDate"]').val(),
					end = $('[name="fdFinishDate"]').val(),
					duration = _caculateDuration(start, end)[0];
				viceUserTimes = viceUserTimes.val().split(';');
				vicePlaceNames = vicePlaceNames.val().split(';');
				for(var i = 0; i < viceUserTimes.length; i++){
					if(!viceUserTimes[i]){
						continue;
					}
					if( duration > viceUserTimes[i] * 3600 * 1000 ){
						return {
							placeName : vicePlaceNames[i],
							userTime : viceUserTimes[i]
						};
					}
				}
			}
			return null;
		};
		
		//自定义校验器:校验当前会议用时是否超过了该会议室最大使用时长
		validation.addValidator('validateUserTime','${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}',function(v,e,o){
			var result = _validateUserTime();
			if(result == false){
				validator = this.getValidator('validateUserTime');
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',$('[name="fdPlaceName"]').val()).replace('%fdUserTime%',$('[name="fdPlaceUserTime"]').val());
				validator.error = error;
			}
			return result;
		});
		
		//自定义校验器:校验各个分会场用时是否超过最大使用时长
		validation.addValidator('validateViceUserTime','${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}',function(v,e,o){
			var errorResult = _validateViceUserTime();
			if(errorResult){
				validator = this.getValidator('validateViceUserTime');
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',errorResult.placeName).replace('%fdUserTime%',errorResult.userTime);
				validator.error = error;
				return false;
			}
			return true;
		});
		
		//校验地点和外部地点不能全为空 
		var _validatePlace=function(){
			
			// 是否开启铂恩，开启内部会议室必须不为空
			var fdIsEnableBoen = "${_isBoenEnable}";
			var fdPlaceId=$('[name="fdPlaceId"]').val();//地点
			var fdOtherPlace=$('[name="fdOtherPlace"]').val();//外部地点
			
			if (fdIsEnableBoen == "true") {
				if (!fdPlaceId) {
					return false;
				} else {
					return true;
				}
			} else {
				if( fdPlaceId || fdOtherPlace){
					return true;
				} else {
					return false;
				}
			}
		};
		
		var validatePlaceTip = "{name} ${lfn:message('km-imeeting:kmImeetingMain.tip.notNull')}";
		
		if ("true" == "${_isBoenEnable}") {
			validatePlaceTip = "开启铂恩会议后，内部会议室不能为空"
		}
		
		//自定义校验器:会议地点不能全为空
		validation.addValidator("validateplace", validatePlaceTip, function(v, e, o) {
			 var fdPlaceName=document.getElementsByName('fdPlaceName')[0];
			 var result=true;
			 if(e.name=="fdOtherPlace"){//fdOtherPlace的这个校验与fdPlaceName的相同，直接执行fdPlaceName的
				 validation.validateElement(fdPlaceName);
			 }else{
				 result= _validatePlace();
			 }
			return result;
		});

		//校验催办纪要
		var _validateHurrySummary=function(){
			
		};

		//自定义校验器:若催办纪要，填写纪要参与人
		validation.addValidator("validateSummaryInputPerson","若催办纪要，请选择纪要录入人",function(v, e, o) {
			var fdIsHurrySummary=$('[name="fdIsHurrySummary"]');
			var fdSummaryInputPersonId=$('[name="fdSummaryInputPersonId"]');
			if( fdIsHurrySummary.prop('checked')==true && !fdSummaryInputPersonId.val() ){
				return false;
			}
			return true;
		});

		//自定义校验器:若催办纪要,既要完成时间不能为空
		validation.addValidator("validateSummaryCompleteTime","纪要完成时间不能为空",function(v, e, o) {
			var fdIsHurrySummary=$('[name="fdIsHurrySummary"]');
			var fdSummaryCompleteTime=$('[name="fdSummaryCompleteTime"]');
			if( fdIsHurrySummary.prop('checked')==true && !fdSummaryCompleteTime.val() ){
				return false;
			}
			return true;
		});
		
		//自定义校验器:若催办纪要,纪要完成时间不能早于会议召开时间
		validation.addValidator("validateWithHoldDate","纪要完成时间不能早于会议召开时间",function(v, e, o) {
			var fdHoldDate=$('[name="fdHoldDate"]');
			if(fdHoldDate.val() && v){
				var holdDate=dateUtil.parseDate(fdHoldDate.val());
				holdDate.setHours(0);
				holdDate.setMinutes(0);
				holdDate.setSeconds(0);
				holdDate.setMilliseconds(0);
				var summaryDate=dateUtil.parseDate(v);
				if( holdDate.getTime()>summaryDate.getTime() ){
					return false;
				}
			}
			return true;
		});
		
		//自定义校验器:若催办纪要，提前天数不能为空
		validation.addValidator('validateHurrySummaryDay','提前催办天数不能为空',function(v){
			var fdIsHurrySummary = $('[name="fdIsHurrySummary"]'),
				checked = fdIsHurrySummary.prop('checked');
			if(checked && !v){
				return false;
			}
			return true;
		});
    	
		//计算会议历时时间,返回数组,依次为:总时差、小时时差、分钟时差、……
		var _caculateDuration=function(start, end){
			if( start && end ){
				// start = env.fn.parseDate(start, Com_Parameter.DateTime_format);
				// end = env.fn.parseDate(end, Com_Parameter.DateTime_format);
				start = dateUtil.parseDate(start);
				end = dateUtil.parseDate(end);
				if(start.getTime()<end.getTime()){
					var total=end.getTime()-start.getTime();
					var hour=parseInt((end.getTime()-start.getTime() )/(1000*60*60));
					var minute=parseInt((end.getTime()-start.getTime() )%(1000*60*60)/(1000*60));
					return [total,hour,minute];
				}else{
					return [0.0,0,0];
				}
			}
		};


		
		
		//选择分会场
		var selectHoldVicePlace=function(index){
			var fdHoldDate = $('[name="fdHoldDate"]').val();//召开时间
			var fdFinishDate = $('[name="fdFinishDate"]').val();//结束时间
			var resIds = $('[name="fdVicePlaceIds"]').val();//地点ID
			var exceptResIds = $('[name="fdPlaceId"]').val(); //不可选地点ID
			var bookId = $('[name="bookId"]').val();//会议预约ID，如果会议安排是通过会议预约转换过来的时候不为空
			var url = "/km/imeeting/km_imeeting_res/kmImeetingRes_showViceResDialog.jsp";
			url = Com_SetUrlParameter(url,'fdHoldDate',fdHoldDate);
			url = Com_SetUrlParameter(url,'fdFinishDate',fdFinishDate);
			url = Com_SetUrlParameter(url,'resIds',resIds);
			url = Com_SetUrlParameter(url,'bookId',bookId);
			url = Com_SetUrlParameter(url,'exceptResIds',exceptResIds);
			dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingMain.selectHoldPlace"/>',function(arg){
				if(arg){
					$('[name="fdVicePlaceIds"]').val(arg.resId);
					$('[name="fdVicePlaceNames"]').val(arg.resName);
					$('[name="fdVicePlaceUserTimes"]').val(arg.resUserTime);
				}
				validation.validateElement( $('[name="fdVicePlaceNames"]')[0] );
			},{width:800,height:500});
		};
		
		//选择会议室
		var selectHoldPlace=function(){
			var fdHoldDate=$('[name="fdHoldDate"]').val();//召开时间
			var fdFinishDate=$('[name="fdFinishDate"]').val();//结束时间
			var resId=$('[name="fdPlaceId"]').val();//地点ID
			var resName=$('[name="fdPlaceName"]').val();//地点Name
			var exceptResIds = $('[name="fdVicePlaceIds"]').val(); //不可选地点ID
			var bookId = $('[name="bookId"]').val();//会议预约ID，如果会议安排是通过会议预约转换过来的时候不为空
			var url="/km/imeeting/km_imeeting_res/kmImeetingRes_showResDialog.jsp?exceptResIds="+ exceptResIds +"&fdHoldDate="+fdHoldDate+"&fdFinishDate="+fdFinishDate+"&resId="+resId+"&resName="+encodeURI(resName)+"&bookId="+bookId;
			dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingMain.selectHoldPlace"/>',function(arg){
				if(arg){
					$('[name="fdPlaceId"]').val(arg.resId);
					$('[name="fdPlaceName"]').val(arg.resName);
					$('[name="fdPlaceUserTime"]').val(arg.resUserTime);
					$('.roomDetail').html('');
					if(arg.resFdAddressFloor !='')
						$('.roomDetail').append('<div><bean:message bundle="km-imeeting" key="kmImeetingRes.fdAddressFloor"/>:'+arg.resFdAddressFloor+'</div>');
					if(arg.resFdSeats !='')
						$('.roomDetail').append('<div><bean:message bundle="km-imeeting" key="kmImeetingRes.fdSeats"/>:'+arg.resFdSeats+'</div>');
					if(arg.resFdDetail !='')
						$('.roomDetail').append('<div><bean:message bundle="km-imeeting" key="kmImeetingRes.fdDetail"/>:'+arg.resFdDetail+'</div>');					
					//修改日期，重新计算会议历时
					if(arg.fdFinishDate && arg.fdHoldDate){
						$('[name="fdHoldDate"]').val(arg.fdHoldDate);
						$('[name="fdFinishDate"]').val(arg.fdFinishDate);
					}
				}
				validation.validateElement( $('[name="fdPlaceName"]')[0] );
			},{width:800,height:520});
		};

		//显示、隐藏纪要催办天数
		var showHurryDayDiv=function(){
			var fdIsHurrySummary=$('[name="fdIsHurrySummary"]');
			if(fdIsHurrySummary.prop('checked')==true){
				$('#HurryDayDiv').show();
			}else{
				$('#HurryDayDiv').hide();
			}
			validation.validateElement( $('[name="fdHurryDate"]')[0] );
		};

		//点击上一步下一步的验证
		var _pre_nextValidate=function(obj,_evt) {
			//去掉前面的验证
			if(!validation){
				validation = $KMSSValidation(obj);
			}
			validation.form = obj;
			//只验证第一个
			if(!Com_Parameter.event["submit"][0]()) {
					_evt.cancel = true;
					return false;
			}
			return true;
		};

		//验证不过后的跳转
		var _afterFormValidate = function (result, form, first) {
			if(!result)	{
				var t = LUI.$(first).parents('[data-lui-content-index]');
				if (LUI('__step')) {
					if(LUI('__step').__index != t.attr('data-lui-content-index')){
						LUI('__step').fireJump(t.attr('data-lui-content-index'));
					}
				}
				
			}
		};

		//点击下一步时触发
		topic.subscribe('JUMP.STEP', function(evt) {
			var result = true;
			//验证基本信息
			if(evt.last==0 ) {
				if(_pre_nextValidate(document.getElementById('validate_ele0'),evt)){
					//校验时间
					//if( !_compareTime() ){
					//	dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.endDate.than.holdDate.tip')}");
					//	evt.cancel = true;
					//}
					
					//校验与会人员
					//if( !_validatePerson() ){
					//	dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.attend.notNull.tip')}");
					//	evt.cancel = true;
					//}
				}
			}
			//验证流程信息
			if(evt.last==1 && evt.cur!=0) {
				/* if(_pre_nextValidate(document.getElementById('validate_ele1'),evt)){
					//校验地点
					if( !_validatePlace() ){
						dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.place.notNull.tip')}");
						evt.cancel = true;
					}
					
				} */
				if(lbpm){
					result = lbpm.globals.submitFormEvent();
					if(!result){
						evt.cancel = true;
					}
				}
			}
			//跳到发送会议通知
			if(evt.cur==3){
				
			}
			if(result){
				//回到顶部
				$('body,html').animate({scrollTop:0},0);
			}
		});
		
		//提交
		window.commitMethod=function(commitType, saveDraft){
			if(!validation) {
				validation = $KMSSValidation(document.forms['kmImeetingMainForm']);
			}
			
			validation.form = document.forms['kmImeetingMainForm'];
			validation.options.afterFormValidate = _afterFormValidate;
			
			//暂存不需要校验#9721
			if (saveDraft == "true") {
				_removeRequireValidate();
				$('[name="docStatus"]').val('10');
				var formObj = document.kmImeetingMainForm;
				if ('save' == commitType) {
					Com_Submit(formObj, commitType, 'fdId');
				} else {
					Com_Submit(formObj, commitType);
				}
				return ;
			}
			//validation.resetElementsValidate(document.kmImeetingMainForm);
			//校验
			if(!validation.validate()){
				//#93800
				var fdFeedBackDeadline=document.getElementsByName('fdFeedBackDeadline')[0];
				validation.validateElement(fdFeedBackDeadline);
				return;
			}
			
			// 开启铂恩之后，校验议题不能为空
			if ("true" == "${_isBoenEnable}") {
				var _firstTopicContent = $("[name='kmImeetingAgendaForms[0].fdMainId']");
				if (!_firstTopicContent.length > 0) {
					dialog.alert("开启铂恩会议之后，会议议题信息不能为空");
					return;
				}
			}
			
			//校验时间
			if( !_compareTime() ){
				dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.endDate.than.holdDate.tip')}");
				LUI('__step').fireJump("0");
				return;
			}
			//校验与会人员
			if( !_validatePerson() ){
				dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.attend.notNull.tip')}");
				LUI('__step').fireJump("0");
				return;
			}
			
			//校验地点
			if( !_validatePlace() ){
				dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.place.notNull.tip')}");
				LUI('__step').fireJump("0");
				return;
			}
			
			//校验使用时长
			if( !_validateUserTime() ){
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',$('[name="fdPlaceName"]').val()).replace('%fdUserTime%',$('[name="fdPlaceUserTime"]').val());
				dialog.alert(error);
				LUI('__step').fireJump("0");
				return;
			}
			//校验分会场使用时长
			var errorResult = _validateViceUserTime();
			if( errorResult){
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',errorResult.placeName).replace('%fdUserTime%',errorResult.userTime);
				dialog.alert(error);
				LUI('__step').fireJump("0");
				return;
			}			
			
			//资源冲突检测
			_checkResConflict().done(function(){
				//设备冲突检测
				_checkEquipmentConflict().done(function(){
					__validateFinish(commitType, saveDraft);
				}).fail(function(){
					// LUI('__step').fireJump("0");
					console.warm("会议资源冲突！");
				});
			}).fail(function(){
				//冲突
				// LUI('__step').fireJump("0");
				console.warm("会议资源冲突！");
			});
		};
		
		//保存
		function __validateFinish(commitType, saveDraft){
			if (saveDraft == "true") {
				$('[name="docStatus"]').val('10');
			}else{
				$('[name="docStatus"]').val('20');
			}
			var formObj = document.kmImeetingMainForm;
			if ('save' == commitType) {
				Com_Submit(formObj, commitType, 'fdId');
			} else {
				Com_Submit(formObj, commitType);
			}
		}
		
		//提交前校验资源是否被占用
		function _checkResConflict(){
			var deferred=$.Deferred();
			if($('[name="fdPlaceId"]').val() || $('[name="fdVicePlaceIds"]').val()){
				var placeArr = [];
				if($('[name="fdPlaceId"]').val()){
					placeArr.push($('[name="fdPlaceId"]').val());
				}
				if($('[name="fdVicePlaceIds"]').val()){
					placeArr.push($('[name="fdVicePlaceIds"]').val());
				}
				//资源冲突检测
				$.ajax({
					url: "${LUI_ContextPath}/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=checkConflict",
					type: 'POST',
					dataType: 'json',
					data: { 
						meetingId : $('[name="fdId"]').val() , 
						bookId : $('[name="bookId"]').val(), 
						fdPlaceId: placeArr.join(';'), 
						fdHoldDate:$('[name="fdHoldDate"]').val() ,
						fdFinishDate:$('[name="fdFinishDate"]').val()
					},
					success: function(data, textStatus, xhr) {//操作成功
						if(data && !data.result ){
							deferred.resolve();
						}else{
							var isCycle;
							if(data.isCycle){
								isCycle = data.isCycle;
							}
							var conflictArr;
							var conflictTime = "";
							if(data.conflictArr){
								conflictArr = data.conflictArr;
								for(var i = 0; i<conflictArr.length;i++){
									var conflict = conflictArr[i];
									var startDate = conflict.startDate;
									var endDate = conflict.endDate;
									conflictTime += startDate + " ~ " + endDate +"<br/>";
								}
							}
							if(isCycle == true){
								dialog.confirm("${lfn:message('km-imeeting:kmImeetingMain.conflict.tip2')}".replace('%conflictTime%',conflictTime),function(flag){
									if(flag){
										deferred.resolve();
									}else{
										deferred.reject();
									}
								});
							}else{
								//冲突
								var fdPlaceName = $('[name="fdPlaceName"]').val();
								if(data.resName){
									fdPlaceName = data.resName;
								}
								dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.conflict.tip')}".replace('%Place%',fdPlaceName));
								deferred.reject();
							}
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
		
		//提交前校验有设备是否被占用
		function _checkEquipmentConflict(){
			var deferred=$.Deferred();
			if($('[name="kmImeetingEquipmentIds"]').val()){
				var meetingId = "${JsParam.fdOriginalId}" || $('[name="fdId"]').val();
				//设备冲突检测
				$.ajax({
					url: "${LUI_ContextPath}/km/imeeting/km_imeeting_equipment/kmImeetingEquipment.do?method=checkConflict",
					type: 'POST',
					dataType: 'json',
					data: { equipmentIds: $('[name="kmImeetingEquipmentIds"]').val(), "fdHoldDate":$('[name="fdHoldDate"]').val() , "fdFinishDate":$('[name="fdFinishDate"]').val() , "meetingId":meetingId},
					success: function(data, textStatus, xhr) {//操作成功
						if(data && !data.conflict ){
							deferred.resolve();
						}else{
							//冲突
							var conflictNames = '';
							for(var i = 0 ;i < data.conflictArray.length;i++){
								conflictNames += data.conflictArray[i].name + ';';
							}
							dialog.alert('<bean:message  bundle="km-imeeting" key="kmImeetingMain.deviceOccupation.tip1"/>'+ conflictNames + '<bean:message  bundle="km-imeeting" key="kmImeetingMain.deviceOccupation.tip2"/>');
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

		//移除必填校验
		function _removeRequireValidate(){
			$('.validation-advice,.lui_validate').hide();//隐藏提示信息(后期修改校验框架，在removeElements时增加移除对应提示信息)
			var formObj = document.kmImeetingMainForm;
			validation.removeElements(formObj,'required');//不校验单字段必填
			validation.removeElements(formObj,'validateattend');//不校验参加人员不全为空
			validation.removeElements(formObj,'validateplace');//不校验地点不全为空
			validation.removeElements(formObj,'min(1)');//不校验地点不全为空
			if($('[name="fdFeedBackDeadline"]')[0]){
				validation.removeValidators("valDeadline,after");
			}
			validation.addElements($('[name="fdName"]')[0],'required');//标题还是要必填
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
		
		//检查潜在与会者的忙闲状态
		window.checkFree=function(){
			var attendIds=convertToArray($('[name="fdHostId"]').val(),$('[name="fdAttendPersonIds"]').val(),$('[name="fdParticipantPersonIds"]').val());
			var fdHoldDate=$('[name="fdHoldDate"]').val(),
				fdFinishDate=$('[name="fdFinishDate"]').val();
			var recurrenceStr = $("input[name='fdRecurrenceStr']").val();
			if(!recurrenceStr){
				recurrenceStr = "";
			}
			if(!fdHoldDate || !fdFinishDate){
				dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.dateNotNull")}');
				return;
			}
			if(attendIds.length == 0){
				dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.personNotNull")}');
				return;
			}
			//检查潜在与会者的忙闲状态
			$.ajax({
				url: "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=checkFree",
				type: 'POST',
				dataType: 'json',
				data:{
					attendIds:attendIds.join(';'),
					fdHoldDate:fdHoldDate,
					fdFinishDate:fdFinishDate,
					recurrenceStr:recurrenceStr
				},
				success: function(data, textStatus, xhr) {
					if(data){
						if(recurrenceStr != ""){
							var confilctStr = "";
							for(var i = 0;i < data.length;i++){
								var d = data[i];
								if(d.type=='01'){
									dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.morePerson")}');
								}
								if(d.type=='04'){
									dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.moreDate")}');
								}
								if(d.type=='02'){
									dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.noConflict")}');
								}
								if(d.type=='03'){
									var names=d.array.join('、');
									var startDate = d.startDate;
									var endDate = d.endDate;
									var str = '${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.conflict2")}'.replace('{0}',startDate).replace('{1}',endDate).replace('{2}',names);
									confilctStr += str;
								}
							}
							if(confilctStr != ""){
								dialog.alert(confilctStr);
							}
						}else{
							var d = data[0];
							if(d.type=='01'){
								dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.morePerson")}');
							}
							if(d.type=='02'){
								dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.noConflict")}');
							}
							if(d.type=='03'){
								var names=d.array.join('、');
								dialog.alert('${lfn:message("km-imeeting:kmImeetingMain.checkFree.tip.conflict")}'.replace('{0}',names));
							}
						}
					}
				}
			});
		};
		
		//#25189,页面未显示完全便开始校验，导致顶部出现冗余的校验提示。暂时使用定时器来确定是否开始执行校验
		var timer = setInterval(function(){
			if($('[name="fdFinishDate"]:visible').length > 0){
				clearTimeout(timer);
				timer = null;
			}
		},100);
		
		//提交
		window.commitMethodChange=function(commitType, saveDraft,isChange){
			
			//暂存不需要校验#9721
			if (saveDraft == "true") {
				_removeRequireValidate();
				$('[name="docStatus"]').val('10');
				var formObj = document.kmImeetingMainForm;
				if ('save' == commitType) {
					Com_Submit(formObj, commitType, 'fdId');
				} else {
					Com_Submit(formObj, commitType);
				}
				return ;
			}
			//validation.resetElementsValidate(document.kmImeetingMainForm);
			//校验
			if(!validation.validate()){
				var fdFeedBackDeadline=document.getElementsByName('fdFeedBackDeadline')[0];
				validation.validateElement(fdFeedBackDeadline);
				return;
			}
			//校验时间
			if( !_compareTime() ){
				dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.endDate.than.holdDate.tip')}");
				return;
			}
			//校验参加人员
			if( !_validatePerson() ){
				dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.attend.notNull.tip')}");
				return;
			}
			//校验地点
			var isChecked = "true" == $("input[name='fdNeedPlace']").val();
			if(isChecked){
				if( !_validatePlace() ){
					dialog.alert("${lfn:message('km-imeeting:kmImeetingMain.place.notNull.tip')}");
					return;
				}
			}
			
			//校验使用时长
			if( !_validateUserTime() ){
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',$('[name="fdPlaceName"]').val()).replace('%fdUserTime%',$('[name="fdPlaceUserTime"]').val());
				dialog.alert(error);
				return;
			}
			//校验分会场使用时长
			var errorResult = _validateViceUserTime();
			if( errorResult){
				var error = '${lfn:message("km-imeeting:kmImeetingRes.fdUserTime.error.tip")}';
				error = error.replace('%fdPlaceName%',errorResult.placeName).replace('%fdUserTime%',errorResult.userTime);
				dialog.alert(error);
				return;
			}
			
			// 开启铂恩之后，校验议题不能为空
			if ("true" == "${_isBoenEnable}") {
				var _firstTopicContent = $("[name='kmImeetingAgendaForms[0].fdMainId']");
				if (!_firstTopicContent.length > 0) {
					dialog.alert("开启铂恩会议之后，会议议题信息不能为空");
					return;
				}
			}
			
			//资源冲突检测
			/* _checkResConflict().done(function(){
				__validateFinishChange(commitType, saveDraft,isChange);
			}); */
			
			//资源冲突检测
			_checkResConflict().done(function(){
				//设备冲突检测
				_checkEquipmentConflict().done(function(){
					__validateFinishChange(commitType, saveDraft,isChange);
				}).fail(function(){
					// LUI('__step').fireJump("0");
					console.warm("会议资源冲突！");
				});
			}).fail(function(){
				//冲突
				// LUI('__step').fireJump("0");
				console.warm("会议资源冲突！");
			});
			
		};
		
		var selectEquipment = function() {
			var fdHoldDate=$('[name="fdHoldDate"]').val();//召开时间
			var fdFinishDate=$('[name="fdFinishDate"]').val();//结束时间
			var equipmentId = $('[name="kmImeetingEquipmentIds"]').val();
			var equipmentName = $('[name="kmImeetingEquipmentNames"]').val();
			var method_GET = "${kmImeetingMainForm.method_GET}";
			var meetingId = "${kmImeetingMainForm.fdId}";
			equipmentName = encodeURI(equipmentName);
			var url="/km/imeeting/km_imeeting_equipment/kmImeetingEquipment_showDialog.jsp?fdHoldDate="+fdHoldDate+"&fdFinishDate="+fdFinishDate+"&meetingId="+meetingId+"&equipmentId="+equipmentId+"&equipmentName="+equipmentName+"&method_GET="+method_GET;
			dialog.iframe(url,'<bean:message bundle="km-imeeting" key="kmImeetingEquipment.btn.select"/>',function(arg){
				if(arg){
					$('[name="kmImeetingEquipmentIds"]').val(arg.equipmentId);
					$('[name="kmImeetingEquipmentNames"]').val(arg.equipmentName);
				}
			},{width:500,height:520});
		};
		
		function __validateFinishChange(commitType, saveDraft,isChange){
			if (saveDraft == "true") {
				$('[name="docStatus"]').val('10');
			}else{
				$('[name="docStatus"]').val('20');
			}
			var formObj = document.kmImeetingMainForm;
			if('true'==isChange){//会议变更
				Change_Submit(formObj,commitType);
			}else if ('save' == commitType) {
				Com_Submit(formObj, commitType, 'fdId');
			} else {
				Com_Submit(formObj, commitType);
			}
		}
		
		//变更提交
		var Change_Submit=function(formObj, commitType){
			var showMore = false,
				limit = 10;
			//变更前内容
			var beforeContent=LUI.toJSON($('[name="beforeChangeContent"]').val());
			var beforePersons=[],afterPersons=[],
				totalPersons={};//totalPersons存储id:name
			
			//变更前的人员
			var beforeIds=convertToArray(beforeContent['fdHostId'],beforeContent['fdSummaryInputPersonId'],beforeContent['fdAttendPersonIds'],beforeContent['fdParticipantPersonIds'],
					beforeContent['fdInvitePersonIds'],beforeContent['fdControlPersonId'],beforeContent['fdAssistPersonIds'],beforeContent['reporterIds'],beforeContent['liaisonPersonIds']),
			beforeNames=convertToArray(beforeContent['fdHostName'],beforeContent['fdSummaryInputPersonName'],beforeContent['fdAttendPersonNames'],beforeContent['fdParticipantPersonNames'],
					beforeContent['fdInvitePersonNames'],beforeContent['fdControlPersonName'],beforeContent['fdAssistPersonNames'],beforeContent['reporterNames'],beforeContent['liaisonPersonNames']);
			for (var i=0; i < beforeIds.length; i++) {
				beforePersons.push(beforeIds[i]);
				totalPersons[beforeIds[i]]=beforeNames[i];
			}
			
			//变更后的人员
			var afterIds,afterNames;
			var hostId = $('[name="fdHostId"]').val();
			var hostName = $('[name="fdHostName"]').val();
			var controlPersonId = $('[name="fdControlPersonId"]').val();
			var controlPersonName = $('[name="fdControlPersonName"]').val();
			var summaryInputPersonId = $('[name="fdSummaryInputPersonId"]').val();
			var summaryInputPersonName = $('[name="fdSummaryInputPersonName"]').val();
			var attendIds = $('[name="fdAttendPersonIds"]').val();
			var participantIds = $('[name="fdParticipantPersonIds"]').val();
			var invitePersonIds = $('[name="fdInvitePersonIds"]').val();
			var fdAssistPersonIds = $('[name="fdAssistPersonIds"]').val();
			// 议题汇报人
			var docReporterIdArray = $('.docReporterIdValue');
			var docReporterIds = '';
			if (docReporterIdArray && docReporterIdArray.length > 0) {
				docReporterIdArray.each(function(index, item) {
					docReporterIds += item.value + ";";
				});
			}
			if (docReporterIds && docReporterIds.length > 1) {
				docReporterIds = docReporterIds.substring(0, docReporterIds.length - 1);
			}
			var docReporterNameArray = $('.td_reporter');
			var docReporterNames = '';
			if (docReporterNameArray && docReporterNameArray.length > 0) {
				docReporterNameArray.each(function(index, item) {
					docReporterNames += item.title + ";";
				});
			}
			if (docReporterNames && docReporterNames.length > 1) {
				docReporterNames = docReporterNames.substring(0, docReporterNames.length - 1);
			}
			
			// 议题单位 列席 + 旁听
			var fdAttendUnitIdsArray = $('.fdAttendUnitIdsValue');
			var fdAttendUnitIds = '';
			if (fdAttendUnitIdsArray && fdAttendUnitIdsArray.length > 0) {
				fdAttendUnitIdsArray.each(function(index, item) {
					if (item.value) {
						fdAttendUnitIds += item.value + ";";
					}
				});
			}
			var fdListenUnitIdsArray = $('.fdListenUnitIdsValue');
			var fdListenUnitIds = '';
			if (fdListenUnitIdsArray && fdListenUnitIdsArray.length > 0) {
				fdListenUnitIdsArray.each(function(index, item) {
					if (item.value) {
						fdListenUnitIds += item.value + ";";
					}
				});
			}
			
			if (fdAttendUnitIds && fdAttendUnitIds.length > 1) {
				fdAttendUnitIds = fdAttendUnitIds.substring(0, fdAttendUnitIds.length - 1);
			}
			
			if (fdListenUnitIds && fdListenUnitIds.length > 1) {
				fdListenUnitIds = fdListenUnitIds.substring(0, fdListenUnitIds.length - 1);
			}
			
			var fdUnitIds = fdAttendUnitIds + ";" + fdListenUnitIds;
			
			$.ajax({
				url: "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=getPersonIds",
				type: 'POST',
				async:false,
				dataType: 'json',
				data:{
					attendIds:attendIds,
					participantIds:participantIds,
					invitePersonIds:invitePersonIds,
					fdAssistPersonIds : fdAssistPersonIds,
					fdAttendUnitIds : fdListenUnitIds,
					fdUnitIds : fdUnitIds
				},
				success: function(data, textStatus, xhr) {
					var json = eval(data);
					var attend = json['attend'];
					var participant = json['participant'];
					var invite = json['invite'];
					var assistPerson = json['assistPerson'];
					var liaison = json['liaison'];
					var attendIds = '';
					var attendNames = '';
					if (attend) {
						attendIds = attend['ids'];
						attendNames = attend['names'];
					}
					var participantIds = '';
					var participantNames = '';
					if (participant) {
						participantIds = participant['ids'];
						participantNames = participant['names'];
					}
					var invitePersonIds = '';
					var invitePersonNames = '';
					if (invite) {
						invitePersonIds = invite['ids'];
						invitePersonNames = invite['names'];
					}
					var assistPersonIds = '';
					var assistPersonNames = '';
					if (assistPerson) {
						assistPersonIds = assistPerson['ids'];
						assistPersonNames = assistPerson['names'];
					}
					var liaisonIds = '';
					var liaisonNames = '';
					if (liaison) {
						liaisonIds = liaison['ids'];
						liaisonNames = liaison['names'];
					}
					afterIds = convertToArray(hostId,summaryInputPersonId,attendIds,participantIds,invitePersonIds,assistPersonIds,controlPersonId,docReporterIds,liaisonIds);
					afterNames = convertToArray(hostName,summaryInputPersonName,attendNames,participantNames,invitePersonNames,assistPersonNames,controlPersonName,docReporterNames,liaisonNames);
				}
			});
			for(var i=0; i < afterIds.length; i++){
				afterPersons.push(afterIds[i]);
				totalPersons[afterIds[i]]=afterNames[i];
			}
			var newPersons=arrayUtil.minus(afterPersons, beforePersons, true);//新增人员
			var staticPersons=arrayUtil.intersect(beforePersons, afterPersons, true);//不变的人员
			var deletePersons=arrayUtil.minus(beforePersons, afterPersons, true);//剔除人员
	
			//#19440 会议其他人员（代理人、受邀人）也要收到待办
			var fdOtherPersonIds = convertToArray(beforeContent['fdOtherPersonIds']),
				fdOtherPersonNames = convertToArray(beforeContent['fdOtherPersonNames']);
			for(var i=0;i<fdOtherPersonIds.length;i++){
				staticPersons.push(fdOtherPersonIds[i]);
				totalPersons[fdOtherPersonIds[i]]=fdOtherPersonNames[i];
			}
			
			var str="",names="",index=1;
			
			var ___fdName = env.fn.formatText($('[name="fdName"]').val()),
				___fdPlaceName="";
			if($('[name="fdPlaceName"]').val() && $('[name="fdPlaceName"]').val() != ""){
				___fdPlaceName = env.fn.formatText($('[name="fdPlaceName"]').val());
			}
			if($('[name="fdOtherPlace"]').val() && $('[name="fdOtherPlace"]').val() != ""){
				___fdPlaceName += ' '+env.fn.formatText($('[name="fdOtherPlace"]').val());
			}
			
			//新增人员收到的待办
			if( newPersons.length>0 ){
				for(var i=0 ;i< newPersons.length;i++){
					names+=totalPersons[newPersons[i]]+";";
				}
				names=names.substring(0,names.length-1);
				names = '<span class="com_author">'+names+'</span>';
				if(___fdPlaceName && ___fdPlaceName !=""){
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.attend.notify.place.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())
					.replace('%km-imeeting:kmImeetingMain.fdPlace%',___fdPlaceName )	+"<br/><br/>";
				}else{
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.attend.notify.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())+"<br/><br/>";
				}
				index++;
				names="";
			}
			
			// 获取变更类型："all":变更了时间和地点 、"date":变更了时间、"place":变更了地点、"none":时间和地点均未变更
			var changeType=getChangeType();
			for(var i=0 ;i< staticPersons.length;i++){
				names+=totalPersons[staticPersons[i]]+";";
			}
			names=names.substring(0,names.length-1);
			//给以下人员发送通知：……………………………………，敬请注意
			if (names) {
				if(changeType=="all"){
					if(___fdPlaceName && ___fdPlaceName !=""){
						str+=index+"、"+'<span class="com_author">'+names+'</span>'+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.holdDateAndFdPlace.notify.subject')}"
						.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
						.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())
						.replace('%km-imeeting:kmImeetingMain.fdPlace%',___fdPlaceName)+"<br/><br/>";
					}else{
						str+=index+"、"+'<span class="com_author">'+names+'</span>'+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.holdDate.notify.subject')}"
						.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
						.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())+"<br/><br/>";
					}
					index++;
				}
				
				if(changeType=="date"){
					str+=index+"、"+'<span class="com_author">'+names+'</span>'+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.holdDate.notify.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())+"<br/><br/>";
					index++;
				}
				
				if(changeType=="place"){
					if(___fdPlaceName && ___fdPlaceName !=""){
						str+=index+"、"+'<span class="com_author">'+names+'</span>'+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.fdPlace.notify.subject')}"
						.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
						.replace('%km-imeeting:kmImeetingMain.fdPlace%',___fdPlaceName) +"<br/><br/>";
					}else{
						str+=index+"、"+'<span class="com_author">'+names+'</span>'+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.notify.subject')}"
						.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
						.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val()) +"<br/><br/>";
					}
					index++;
				}
			}
			
			names="";
			
			//给以下人员发送通知：邀请您参加会议：%km-imeeting:kmImeetingMain.fdName%，召开时间：%km-imeeting:kmImeetingMain.fdDate%
			if( (changeType == "none" && staticPersons.length>0)  ){
				for(var i=0 ;i< staticPersons.length;i++){
					names+=totalPersons[staticPersons[i]]+";";
				}
				names=names.substring(0,names.length-1);
				names = '<span class="com_author">'+names+'</span>';
				if(___fdPlaceName && ___fdPlaceName !=""){
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.place.notify.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())
					.replace('%km-imeeting:kmImeetingMain.fdPlace%',___fdPlaceName)	+"<br/><br/>";
				}else{
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.notify.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())+"<br/><br/>";
				}
				index++;
				names="";
			}
			
			//剔除人员....给以下人员发送通知：原定于%km-imeeting:kmImeetingMain.fdDate%举行的会议%km-imeeting:kmImeetingMain.fdName%已不需要参加，敬请注意
			if(deletePersons.length>0){
				for(var i=0 ;i< deletePersons.length;i++){
					names+=totalPersons[deletePersons[i]]+";";
				}
				names=names.substring(0,names.length-1);
				names = '<span class="com_author">'+names+'</span>';
				if(___fdPlaceName && ___fdPlaceName !=""){
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.delete.notify.place.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())
					.replace('%km-imeeting:kmImeetingMain.fdPlace%',___fdPlaceName)+"<br/><br/>";
				}else{
					str+=index+"、"+names+"${lfn:message('km-imeeting:kmImeetingMain.change.getMessage')}"+"${lfn:message('km-imeeting:kmImeetingMain.change.delete.notify.subject')}"
					.replace('%km-imeeting:kmImeetingMain.fdName%',___fdName)
					.replace('%km-imeeting:kmImeetingMain.fdDate%',$('[name="fdHoldDate"]').val())+"<br/><br/>";
				}
				index++;
				names="";
			}
			
			if(str){
				var text = str;
				var text = '<div style="text-align: left; max-height: 128px; overflow: hidden;">'+text+'</div>';
				// #57757 【会议管理-修复】会议变更，点击提交的弹出框优化，3、详情，这样显示很误导，请调整为 查看更多详情>>，超链方式
				if(text.length > 256){
					text += '<div style="text-align: left;">......</div>';
					text += (
						'<p style="color: #999; text-align: center; margin: 8px 0;">' + 
							'<a style="font-size:14px;text-decoration:underline;cursor:pointer" onclick="showMoreFn();">查看更多详情&gt;&gt;</a>' + 
						'</p>'
					);
					window.changeInfo = str;
				}
				
				dialog.confirm(text,function(value){
					if(value==true){
						Com_Submit(formObj, commitType);
					}
				});
			}else{
				Com_Submit(formObj, commitType);
			}
		};
		
		window.showMoreFn = function(){
			dialog.iframe('/km/imeeting/km_imeeting_main/kmImeetingMain_changeDialog.jsp',"${lfn:message('km-imeeting:tips.change.details')}",null,{width:500,height:320});
		};
		
		//时间或者地点改变
		function getChangeType(){
			var type="none";
			var beforeContent=LUI.toJSON($('[name="beforeChangeContent"]').val());
			
			if(beforeContent.fdHoldDate != $('[name="fdHoldDate"]').val() ){
				type="date";
			}
			
			if(beforeContent.fdPlaceId != $('[name="fdPlaceId"]').val()){
				if(type=="date"){
					type="all";
				}else{
					type="place";
				}
			}
			return type;
		}
		
		
		$(document).ready(function() {
			
		});
		
		window.voteConfig = function(){
			 var url = "/km/imeeting/km_imeeting_vote/kmImeetingVote_edit_list.jsp?fdMeetingId=${kmImeetingMainForm.fdId}";
			dialog.iframe(url,"投票配置",null,{width:1200, height:600, topWin : window, close: true});
		}
		
		window.voteEnableChange = function(){
			var voteEnableValue = $("input[name='fdVoteEnable']").val();
			if("true" == voteEnableValue){
				$("#voteConfig").css("display","block");
			}else{
				$("#voteConfig").css("display","none");
			}
		}
		
		window.selectHoldPlace=selectHoldPlace; //选择会议室
		window.selectHoldVicePlace=selectHoldVicePlace;//选择分会场
		window.showHurryDayDiv=showHurryDayDiv;//显示、隐藏纪要催办天数
		window.selectEquipment = selectEquipment; //选择会议辅助设备
		window.changeDateTime=changeDateTime;//计算会议历时（修改日期选择框时触发） 
	});
</script>