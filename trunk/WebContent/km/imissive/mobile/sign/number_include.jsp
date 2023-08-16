<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/view/DocScrollableView" id="_modifyDocNumView">
	<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header"   data-dojo-props="height:'3.8rem'">
		<div class="muiHeaderBasicInfoTitle">文件编号</div>
		<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this)">
			<i class="mui mui-close"></i>
		</div>
	</div>
	<div data-dojo-type="mui/panel/Content">
		<div class="muiFormContent">
			<table class="muiSimple">
				<tr>
					<td>
						<xform:text property="fdNum" showStatus="readOnly" mobile="true"></xform:text>
						<xform:text property="fdRtnNum" showStatus="noShow" mobile="true"></xform:text>
					</td>
				</tr> 
			</table>
			<div id = "numberEle">
			</div>
			<div id = "unUseTd" style="word-break:break-all;word-wrap:break-word;padding-top:15px">
			</div>
			<div id="errorDiv" style="color:red;padding-top:10px;margin-left: 10px;margin-right: 10px;display:none">
				<div>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info1"/><br>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info2"/><br>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info3"/><br>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info4"/><br>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info5"/><br>
					<bean:message bundle="km-imissive" key="kmImissive.modifyDocNum.error.info6"/>
				</div>
			</div>
		</div>
	</div>
	<%-- 操作按钮展示区域  --%>
	<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
	  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "  onclick="optSubmit(this);">确定</li>
	</ul>
</div>

<script language="JavaScript">
require(['dojo/ready',
		'dijit/registry',
		'dojo/topic',
		'dojo/query',
		'dojo/dom-style',
		"dojo/_base/array",
		'dojo/dom-class',
		"dojo/_base/lang",
		"mui/dialog/Tip",
		"dojo/request",
		"mui/device/adapter",
		"mui/util",
		"mui/device/device" ,
		'dojox/mobile/TransitionEvent',
		'dojo/date/locale'],
	function(ready,registry,topic,query,domStyle,array,domClass,lang,Tip,req,adapter,util,device,TransitionEvent,locale){
	ready(function(){
		//var docId = "${kmImissiveSignMainForm.fdId}";
		//var fdNumberId = "${fdNoId}";
		//generateNum(docId,fdNumberId);
	});
	
	window.optSubmit= function(obj){
		var fdNum = document.getElementsByName("fdNum")[0].value;
		var fdRtnNum = document.getElementsByName("fdRtnNum")[0].value;
		var flag = false;
		 var r = /^-?\d+$/;　　//正整数
		 if(query('input[name^=flow]').length > 0){
			 var length = $('input[name^=flow]').length;
			 var count = 0;
			 array.forEach(query('input[name^=flow]'),lang.hitch(this, function(item,index) {
				 if(!r.test(item.value)){
		  			flag = false;
			  	  }else{
			  		count++;
			  		if(count == index+1){
			  			flag = true;
			  		}
			  	  }
			 }));
			 if(count != length && !flag){
				 Tip.tip({icon:'mui mui-warn', text:'流水号只能输入整数!'});
				 return false;
			 }
		 }else{
			 flag = true;
		 }
		if(flag){
			 var docNum = document.getElementsByName("fdDocNum")[0];
	         var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
	         var fdNoRule = document.getElementsByName("fdNoRule")[0];
	         var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
			 var arr = fdRtnNum.split("#");
			 if(arr.length>1){
				  fdNoRule.value = arr[0];
	    		  	  fdFlowNo.value = arr[1];
	    		  	  fdNumberMainId.value = arr[2];
	    		 	  docNum.value = fdNum;
	    		 	  var fdYearNo = document.getElementsByName("fdYearNo")[0];
				  var date = new Date();
			      fdYearNo.value = date.getFullYear();
	   		      document.getElementById("docnum").innerHTML = fdNum;
			 }
			 var opts = {
				transition : 'slide',
				transitionDir:-1,
				moveTo:'scrollView'
			};
			new TransitionEvent(obj.domNode, opts).dispatch();
		}
	}

	topic.subscribe('/mui/form/valueChanged',function(widget,args){
		if(widget && widget.id == "numberSelect"){
			optGetNum();
		}
	});
	
	window.fdNumberMainId = "";
	window.getUnUseNum= function(){
		var fdNumberId = document.getElementsByName("fdNumberId")[0].value;
		req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getUnUseNum"), {
			method : 'post',
			data:{fdNumberId:fdNumberId,fdId:"${kmImissiveSignMainForm.fdId}",fdTemplateId:"${kmImissiveSignMainForm.fdTemplateId}"}
		}).then(lang.hitch(this, function(data) {
			var results =  eval("("+data+")");
		   	 $('#unUseTd').show();
		   	 if(results['unUseNum']!=null){
		   		var unUseArr = results['unUseNum'].split(";");
		   		var contentHTML = "<div style='font-size: 16px;'>漏号:</div><table class='muiSimple'><tr><td style='padding-right:6px'>"
				for(var i = 0;i<unUseArr.length;i++){
					contentHTML += "<span style='height:30px;line-height:30px;padding-right:5px'>"+unUseArr[i]+"</span>"
				}
				contentHTML += "</td></tr></table>"
		   		$('#unUseTd').html(contentHTML);
		   	 }else{
		   		$('#unUseTd').html('<bean:message bundle="km-imissive" key="kmMissive.number.unUse.null"/>');
		   	 }
		}));
	}
	
	window.fdVirtualNum = "";
	window.generateNum= function(docId,fdNumberId){
		if(fdNumberId!=""){
			var docNum = document.getElementsByName("fdNum")[0];
			var fdRtnNum = document.getElementsByName("fdRtnNum")[0];
			document.getElementById("errorDiv").style.display = "none";
			req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=generateNumByNumberId"), {
					method : 'post',
					data:{fdNumberId:fdNumberId,fdId:docId}
				}).then(lang.hitch(this, function(data) {
				 var results =  eval("("+data+")");
	    	 	    if(results['hasError']=="true"){
	    	 		  document.getElementById("errorDiv").style.display = "block";
	    			}
	    	 	   if(results['fdVirtualNum']!=null){
	    		       fdVirtualNum = results['fdVirtualNum'];
		    		    if(results['docNum']!=null){
			    		    	var fdFlowNo = getFlowNum(results['docNum']);
		    				fdNumberMainId = getNumberMainId(results['docNum']);
			    		    showEle(fdVirtualNum,fdFlowNo);
		    		   	   docNum.value = formatNum(fdVirtualNum,fdFlowNo);
		    			}else{
		    				docNum.value = "";
		    			}
	    	 	   }
			}));
		}
		//记下当前所选的编号规则，用于提交时清除cookie
	   fdBufferNumId = fdNumberId;
	}
	
	 <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'  and kmImissiveSignMainForm.docStatus eq '20'}">
		 Com_Parameter.event["submit"].push(function(){
		 	//操作类型为通过类型 ，才写回编号
			 var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
		 	if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
		 	    var docNum = document.getElementsByName("fdDocNum")[0];
		 	    var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
		 	    var fdNoRule = document.getElementsByName("fdNoRule")[0];
		 	    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
		 	   var fdYearNo = document.getElementsByName("fdYearNo")[0];
		 	    var isRepeat=true;
		 	    var results;
		 	    if(""==docNum.value){
		 	    		isRepeat = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
		 	    }else{
			 	    	req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=saveDocNum"), {
						method : 'post',
						data:{fdDocNum:docNum.value,fdFlowNo:fdFlowNo.value,fdNoRule:fdNoRule.value,fdNumberMainId:fdNumberMainId.value,fdId:"${kmImissiveSignMainForm.fdId}",fdYearNo:fdYearNo.value}
					}).then(lang.hitch(this, function(data) {
					results =  eval("("+data+")");
			    	    if(results['isRepeat']=="true"){
			    	    	 //如果编号被占用，则删除cookie和 数据库保存的编号
			    	    	if(fdBufferNumId !=""){
		 			    	getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveSignMain").then(lang.hitch(this, function(data) { 
		    					 var results =  eval("("+data+")");
		    					 if(results['docNum']!=null){
		    						var docBufferNum =results['docNum'];
		    						if(docBufferNum){
								    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
								    	if((docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || fdFlowNo.value > docBufferNumArr[1]){
								    		delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
								    	}
								 }
		    					 }
		    				}));
			 		 }
			    	    	 Tip.tip({icon:'mui mui-warn', text:'<bean:message bundle="km-imissive" key="kmImissiveSendMain.message.error.fdDocNum.repeat"/>'});
			    		  isRepeat = false;
			   	 	}
			    	    if(results['flag']=="false"&&results['isRepeat']!="true"){
			    	    	    Tip.tip({icon:'mui mui-warn', text:'更新文档编号不成功'});
			 		    return false;
			 		}else{
			 	    	    return isRepeat;
			 		}
				}));
			 	     return isRepeat;
		 	 }
		 	   return isRepeat;
		 	}else{
		 		return true;
		 	} 
		 });
	 </c:if>
});
</script>