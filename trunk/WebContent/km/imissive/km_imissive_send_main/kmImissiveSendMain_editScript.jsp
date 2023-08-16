<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.landray.kmss.util.IDGenerator" %>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<%-- WPS中台和撤回套红操作JS --%>
<jsp:include page="/km/imissive/wps/kmImissive_wpsCenter_script.jsp">
	<jsp:param name="imissiveFormName" value="kmImissiveSendMainForm"/>
</jsp:include>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<%
	//生成一个附件id,供原始稿上传用
	request.setAttribute("attId", IDGenerator.generateID());
%>
<script>
    Com_IncludeFile("dialog.js|jquery.js");
    Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<c:set var="fdYqqKeyPdf" value="yqqSigned" />
<c:set var="fdEqbKeyPdf" value="eqbSign" />
<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
<c:set var="fdDianJuOfd" value="dianjuSign" />
<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
<c:set var="fdConvertOfd" value="convert_toOFD" />
<c:set var="fdConvertPdf" value="convert_toPDF" />
<c:choose>
	<c:when  test="${not empty kmImissiveSendMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
		<c:set var="fdSignKey" value="yqqSigned" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
		<c:set var="fdSignKey" value="eqbSign" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
		<c:set var="fdSignKey" value="ofdEqbSign" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdDianJuOfd].attachments}">
		<c:set var="fdSignKey" value="dianjuSign" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdSsKeyOfd].attachments}">
		<c:set var="fdSignKey" value="ofdSursenSign" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdConvertOfd].attachments}">
		<c:set var="fdSignKey" value="convert_toOFD" scope="request"/>
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdConvertPdf].attachments}">
		<c:set var="fdSignKey" value="convert_toPDF" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="fdSignKey" value="" scope="request"/>
	</c:otherwise>
</c:choose>
<script language="JavaScript">

  function saveAttTrack(fdFileId,fdFileName,type,fdNodeName){
   var flag = false;
   var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addAttTrack"; 
   $.ajax({     
 	     type:"post",     
 	     url:url,     
 	     data:{fdMainId:"${kmImissiveSendMainForm.fdId}",type:type,fdFileId:fdFileId,fdFileName:fdFileName,fdNodeName:fdNodeName},    
 	     async:false,    //用同步方式 
 	     success:function(){
 	    	flag = true;
 		 }    
     });
   return flag;
  }
function doRedHead(){
    var type =  document.getElementsByName("fdNeedContent");
    if(type[0].value !="1"){
 		 alert('当前正文为上传附件模式，套红请切换为在线编辑模式！');
    }else{
 	   if("${kmImissiveSendMainForm.method_GET}" == 'add'){
 		   dialog.confirm("<bean:message bundle='km-imissive' key='kmImissive.redhead.comfirm.draft2'/>",function(flag){
 		    	if(flag==true){
 		    		redheadFlag = "true";
 		    		saveDraft4RedHead();
 		    	}else{
 		    		return;
 			    }
 		  },"warn");
 	   }else{
 		   if("${_isWpsCloudEnable}" == "true"){
 			  LoadWpsHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');
 		   }else if("${_isWpsCenterEnable}" == "true"){
			   LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');
		   }else{
 			  LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');
 		   }
 	   }
    }
}
function saveDraft4RedHead(){
   	var formObj = document.kmImissiveSendMainForm;
	var docStatus = document.getElementsByName("docStatus")[0];
	docStatus.value="10";
	var docNum = document.getElementsByName("fdDocNum")[0];
	validation.removeElements($('#kmImissiveSendXform')[0],'required');
	beforeSubjectForm().then(function(){
	//提交时判断是否需要正文，如果不需要则移除页面控件对象
	submitOrUpdateDoc(formObj, "saveDraft4RedHead",true);

	//删除当前所用编号规则的cookie,避免新建每次取到同一编号
	  if(fdBufferNumId!=""  && validation.validate() && docNum.value != "" && (checkIfFutureNodeSelected() || docStatus.value=="10")){
		  deleteBufferNumByNumberId(fdBufferNumId);
      }
   });
}
function _updateDraft(){
   validation.resetElementsValidate($('#kmImissiveSendXform')[0]);
   submitOrUpdateDoc(document.kmImissiveSendMainForm, 'updateDraft');
}


function saveSend(commitType, saveDraft){
	 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkSend"; 
	 $.ajax({     
	     type:"post",    
	     url:url,   
	     data:{fdDetailId:"${kmImissiveSendMainForm.fdDetailId}"},
	     async:false,    //用同步方式 
	     success:function(data){
	 	    var results =  eval("("+data+")");
	 	    if (results['cancel'] == "true") {
	 	    	 dialog.alert('该签收单已经撤回，无法提交！');
	 	    } else if(results['exist'] == "true"){
		    	 dialog.confirm('该签收单已经签收过，转到对应的签收发文？',function(flag){
					 if(flag==true){
						 var url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId="+results['fdSendId'];
						 window.open(url, "_self");
					 }else{
						 return;
					 }
				 },"warn"); 
		    }else{
		    	commitMethod(commitType, saveDraft);
		    }
		 }
	 });
}


function commitMethodOffLine(commitType, saveDraft){
	lbpm.globals.common_operationCheckForPassType = function(nextNodeArray, operatorInfo){
		return true;
	};
	if($('input:radio[name^="manualFutureNodeId_"]').length > 0){
		$('input:radio[name^="manualFutureNodeId_"]')[0].checked=true;
	}
	if($('input:checkbox[name="futureNode"]').length > 0){
		$('input:checkbox[name="futureNode"]')[0].checked=true;
	}else if($('input:radio[name="futureNode"]').length > 0){
		$('input:radio[name="futureNode"]')[0].checked=true;
	}

  	var docStatus = document.getElementsByName("docStatus")[0];
	docStatus.value="20";
	var formObj = document.kmImissiveSendMainForm;
	var docNum = document.getElementsByName("fdDocNum")[0];
	var flag = true;
	if(docNum.value != "" || docNum.value != null){
		var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkUniqueNum"; 
		 $.ajax({     
		     type:"post",   
		     url:url,     
		     data:{fdNo:docNum.value,fdId:"${kmImissiveSendMainForm.fdId}",fdTempId:"${kmImissiveSendMainForm.fdTemplateId}"},
		     async:false,    //用同步方式 
		     success:function(data){
		    	 var results =  eval("("+data+")");
		    	 if(results['unique'] =='false'){
		    		 //如果编号被占用，则删除cookie和 数据库保存的编号
		    		 if(fdBufferNumId!=""){
		    			 deleteBufferNumByNumberId(fdBufferNumId);
			      }
		    		 dialog.alert('<bean:message key="kmImissiveSendMain.message.error.fdDocNum.repeat" bundle="km-imissive" />');
		    		 flag = false;
		    	 }
			}    
	 	});	
	 }
	
	if(flag){
		 beforeSubjectForm().then(function(){
		//提交时判断是否需要正文，如果不需要则移除页面控件对象
		submitOrUpdateDoc(formObj, commitType);
	
		//删除当前所用编号规则的cookie,避免新建每次取到同一编号
		  if(fdBufferNumId!=""  && validation.validate() && docNum.value != "" && checkIfFutureNodeSelected()){
			  deleteBufferNumByNumberId(fdBufferNumId);
	      }
	   });
	}
}




//记录下当前预览的编号规则id
var fdBufferNumId = "${fdNoId}"; 
var fdVirtualNum = ""; 
function commitMethod(commitType, saveDraft){

	var relationdDiv = $(".imissiveRelationDiv");
	var fdModelId = $("input[name='fdModelId']").val();
	var fdModelName = $("input[name='fdModelName']").val();
	if ($(".imissiveRelationDiv").length != 0
			&& !fdModelId && !fdModelName) {
		seajs.use(['lui/dialog'], function(dialog){
			dialog.alert("请先选择会议通知再提交！");
		});
		return;
	}
	
	var formObj = document.kmImissiveSendMainForm;
	var docStatus = document.getElementsByName("docStatus")[0];
	var docNum = document.getElementsByName("fdDocNum")[0];
	var flag = true;
	if(saveDraft=="true"){
		docStatus.value="10";
		validation.removeElements($('#kmImissiveSendXform')[0],'required');
		validation.removeElements($('#nextNodeRow')[0],'required');
	}else{
		validation.resetElementsValidate($('#kmImissiveSendXform')[0]);
		validation.resetElementsValidate($('#nextNodeRow')[0]);
		docStatus.value="20";
		if (!validation.validate()) {
			// 移除检验组件在新UI下的顶部提示
			if ($("#lui_validate_message").length > 0) {
				$("#lui_validate_message").remove();
			}
			if (LUI("tabpanelDiv")) {
				var contents = LUI("tabpanelDiv").contents;
				for (var i = 0; i < contents.length; i++) {
					if (contents[i].id == "kmImissiveSendMain_baseinfo") {
						LUI("tabpanelDiv").setSelectedIndex(i);
					}
				}
			}
		}
	}
	
	 if('${nodeExtAttributeMap['modifyDocNum4Draft']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'on'){
		   if(docNum.value != "" || docNum.value != null){
			var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkUniqueNum"; 
			 $.ajax({     
			     type:"post",   
			     url:url,     
			     data:{fdNo:docNum.value,fdId:"${kmImissiveSendMainForm.fdId}",fdTempId:"${kmImissiveSendMainForm.fdTemplateId}"},
			     async:false,    //用同步方式 
			     success:function(data){
			    	 var results =  eval("("+data+")");
			    	 if(results['unique'] =='false'){
			    		 //如果编号被占用，则删除cookie和 数据库保存的编号
			    		 if(fdBufferNumId!=""){
			    			 deleteBufferNumByNumberId(fdBufferNumId);
				      }
			    		 dialog.alert('<bean:message key="kmImissiveSendMain.message.error.fdDocNum.repeat" bundle="km-imissive" />');
			    		 flag = false;
			    	 }
				}    
		 	});	
		 }
	  }
	
	if(flag){
		if(saveDraft=="true"){
			submitOrUpdateDoc(formObj, commitType,true);
			//删除当前所用编号规则的cookie,避免新建每次取到同一编号
			  if(fdBufferNumId!=""  && validation.validate() && docNum.value != ""){
				  deleteBufferNumByNumberId(fdBufferNumId);
		      }
		}else{
			 beforeSubjectForm().then(function(){
			//提交时判断是否需要正文，如果不需要则移除页面控件对象
			submitOrUpdateDoc(formObj, commitType,true);

			//删除当前所用编号规则的cookie,避免新建每次取到同一编号
			  if(fdBufferNumId!=""  && validation.validate() && docNum.value != "" && (checkIfFutureNodeSelected() || docStatus.value=="10")){
				  deleteBufferNumByNumberId(fdBufferNumId);
		      }
		   });
		}
	}
}

function deleteBufferNumByNumberId(fdBufferNumId){
	var docBufferNum = getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveSendMain");
	if(docBufferNum){
		var fdYearNo = document.getElementsByName("fdYearNo");
		var nowYearNo = "";
		var date = new Date();
		nowYearNo = date.getFullYear();
	    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
	    	var docNum = document.getElementsByName("fdDocNum")[0];
	    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
	    	if((docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || (fdYearNo.length > 0 && fdYearNo[0].value == nowYearNo && fdFlowNo.value > docBufferNumArr[1])){
	    		 delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
				 //delCookieByName(fdBufferNumId);
	    	}
	}
}

var kmImissiveEvent = kmImissiveEvent || new Array;
function beforeSubjectForm(){ 
   var dtd = $.Deferred();
   var count = 0;
   if(kmImissiveEvent && kmImissiveEvent.length >0){
	   for(var i = 0 ;i<kmImissiveEvent.length;i++){
		  kmImissiveEvent[i]().then(function(){
			  count ++ ;
			  if(count == kmImissiveEvent.length){
				   dtd.resolve();
			   }
		  });
	   }
   }else{
	   dtd.resolve();
   }
   return dtd;
  }

function saveModifyRecord(){
	if(validation.validate()){
		var dtd = $.Deferred();
		 path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_modify_record/kmImissiveModifyRecord.do?method=add&fdType=send&fdImissiveId=${kmImissiveSendMainForm.fdId}';
		    dialog.iframe(path,'修订记录',function(rtn){
		    	if(rtn && rtn['flag'] == "true"){
		    		dtd.resolve();
		    	}else{
		    		dtd.reject();
		    	}
		    	
	    },{width:600,height:300});
		 return dtd;
	}
}

function saveDoc(formObj, commitType){
	var type =  document.getElementsByName("fdNeedContent");
	var _isWpsCloudEnable = "${_isWpsCloudEnable}";
	var _isWpsCenterEnable = "${_isWpsCenterEnable}";
	var xinChuangWps = "${xinChuangWps}";
	var wpsoaassist = "${wpsoaassist}";
	if(_isWpsCloudEnable == "false" && _isWpsCenterEnable == "false" && xinChuangWps =="false" && wpsoaassist == "false"){
		var obj = document.getElementById("JGWebOffice_editonline");
	     if(type[0].value !="1"){
	       	 if("${kmImissiveSendMainForm.method_GET}"=="add"){
	       		 if(obj&&Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad){
	    	      		 jg_attachmentObject_editonline.unLoad();
	       		 }
	       	 }
	      }else{
			  if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
				  if(jg_attachmentObject_editonline.ocxObj){
					jg_attachmentObject_editonline.ocxObj.Active(true);
				  }
					addBookMarks("editonline");
					if(!jg_attachmentObject_editonline._submit()){
						return;
					}
			  }else{
				  dialog.alert('<div class="msgTitle">无法正常提交，可能原因:</div><div class="msgContent">1、当前浏览器不支持在线编辑<br>2、当前浏览器没正常安装金格控件<br>3、当前正文为在线编辑方式，正文页签内容没正常加载</div>');
					return;
			  }
	      }
	}
	var method = Com_GetUrlParameter(location.href,'method');
	 if (method == "addSend") {
		 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=checkSend"; 
		 $.ajax({     
		     type:"post",    
		     url:url,   
		     data:{fdDetailId:"${kmImissiveSendMainForm.fdDetailId}"},
		     async:false,    //用同步方式 
		     success:function(data){
		 	    var results =  eval("("+data+")");
		 	    if (results['cancel'] == "true") {
		 	    	 dialog.alert('该签收单已经撤回，无法提交！');
		 	    } else if(results['exist'] == "true"){
			    	 dialog.confirm('该签收单已经签收过，转到对应的签收发文？',function(flag){
						 if(flag==true){
							 var url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId="+results['fdSendId'];
							 window.open(url, "_self");
						 }else{
							 return;
						 }
					 },"warn"); 
			    }else{
			    	Com_Submit(formObj, commitType);
			    }
			 }
		 });
	 } else {
		 Com_Submit(formObj, commitType);
	 }
	  
}

function submitOrUpdateDoc(formObj, commitType,isShow){
	if (!isShow) {
		validation.resetElementsValidate($('#kmImissiveSendXform')[0]);
		validation.resetElementsValidate($('#nextNodeRow')[0]);
		if (!validation.validate()) {
			// 移除检验组件在新UI下的顶部提示
			if ($("#lui_validate_message").length > 0) {
				$("#lui_validate_message").remove();
			}
			if (LUI("tabpanelDiv")) {
				var contents = LUI("tabpanelDiv").contents;
				for (var i = 0; i < contents.length; i++) {
					if (contents[i].id == "kmImissiveSendMain_baseinfo") {
						LUI("tabpanelDiv").setSelectedIndex(i);
					}
				}
			}
		}
	}
	if("${kmImissiveSendMainForm.docStatus}" == '30'){
		saveModifyRecord().then(function(){
			saveDoc(formObj, commitType);
		});
	}else{
		saveDoc(formObj, commitType);
	} 
}

seajs.use(['lui/topic'],function(topic){
	 topic.subscribe('/sys/attachment/wpsCloud/loaded', function(obj) {
		if(obj){
			if($('.content').length > 0){
				var contentH = $('.content').height();
				obj.iframe.style.height=(contentH-110)+"px";
			}else{
				obj.iframe.style.height="560px";
			}
		}
	});
});

var wpsFlag = false;
var wpsCenterFlag = false;
var showButtonDivFlag = false;
function checkEditType(value){
	var type=document.getElementsByName("fdNeedContent")[0];
	type.value = "0";
	var _wordEdit = $('#wordEdit');
	var _attEdit = $('#attEdit');
	var wordFloat = $("#wordEditFloat");
	var missiveButtonDiv = $("#missiveButtonDiv");
	var wpsoaassist = "${wpsoaassist}";
	var wpsAddIn = $("#wpsAddIn");
	var sendContentFlag = '${sendContentFlag}';
	var fdSignKey = '${fdSignKey}';
	if("1" == value){
		type.value = "1";
		if (wpsoaassist=="true") {
			wpsAddIn.css({'width':'auto','height':'auto','filter':'alpha(opacity=100)','opacity':'1'});
			missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
			_wordEdit.css({'display':"block",'width':"100%",'height':"auto"});
			_attEdit.css({'display':"none"});
			
			//默认是文本后，切换word，样式问题 #133035
			var defaultTextRegion = document.getElementsByClassName('upload_list_tr upload_list_tr_edit');
			if(defaultTextRegion && defaultTextRegion.length > 0)
			{
				document.getElementsByClassName('upload_list_tr upload_list_tr_edit')[0].classList.add('upload_list_tr_edit_block');
				$('.upload_list_filename_title').css({'max-width':'200px'});
				$('.upload_list_status').css({'margin-right': '15px'});
				document.getElementsByClassName('upload_opt_status success')[0].innerHTML="<i></i>成功";
			}
			return;
		}
		_wordEdit.css({'display':"block",'width':"100%",'height':"auto"});
		//var xw = $("#wordEditWrapper").width();
		wordFloat.css({'width':'auto','height':'auto','filter':'alpha(opacity=100)','opacity':'1'});
		missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
		_attEdit.css({'display':"none"});
		var obj = document.getElementById("JGWebOffice_editonline");
		if(fdSignKey == ""){
			setTimeout(function(){
				if("${_isWpsCloudEnable}" == "true"){
					if(!wpsFlag && wps_cloud_editonline){
						if("${flatOrTab}" == 'true'){
							wps_cloud_editonline.load();
						}
						wpsFlag  =true;
						if($('#office-iframe')){
							if($('.content').length > 0){
								var contentH = $('.content').height();
								contentH = contentH-110;
								if(contentH < 580){
									contentH = 580;
								}
								$('#office-iframe').height( (contentH)+"px");
							}else{
								$('#office-iframe').height( "580px");
							}
						}
					}
				}else if("${_isWpsCenterEnable}" == "true"){
					if(!wpsCenterFlag && wps_center_editonline){
						if("${flatOrTab}" == 'true'){
							wps_center_editonline.load();
						}
						wpsCenterFlag  =true;
						if($('#office-iframe')){
							if($('.content').length > 0){
								var contentH = $('.content').height();
								contentH = contentH-110;
								if(contentH < 580){
									contentH = 580;
								}
								$('#office-iframe').height( (contentH)+"px");
							}else{
								$('#office-iframe').height( "580px");
							}
						}
					}
				}else{
					if (wpsoaassist !="true") {
						if(!Attachment_ObjectInfo['editonline'].getOcxObj()){
							dialog.alert("当前浏览器检测不到金格控件,在线编辑功能无法使用，若是刚安装完金格控件，请刷新页面或重新浏览器试试！");
						}else{
							if(obj&&Attachment_ObjectInfo['editonline'] && !Attachment_ObjectInfo['editonline'].hasLoad){
								jg_attachmentObject_editonline.load();
								jg_attachmentObject_editonline.show();
								if(Attachment_ObjectInfo['editonline'].ocxObj){
									jg_attachmentObject_editonline.ocxObj.Active(true);
								}
							}
						}
					}
				}
			},1000);
		}
		seajs.use(['lui/topic'],function(topic){
			topic.subscribe("Sidebar",function(data){
				//var xw = $("#wordEditWrapper").width();
				wordFloat.css({'width':'auto','height':'auto','filter':'alpha(opacity=100)','opacity':'1'});
				missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
			});
		});
		chromeHideJG_2015(1);
		var jgObjH = "550";
		if($('.content')&&$('.content').height()){
			jgObjH = $('.content').height()-120;
		}
		var obj1 = document.getElementById("JGWebOffice_editonline");
		if(obj1){
			obj1.setAttribute("height",jgObjH+"px");
		}
		if(sendContentFlag == 'true'){
			if(Attachment_ObjectInfo['mainonline']){
				Attachment_ObjectInfo['mainonline'].requiredExec(false);
			}
		}
	} else {
		if(sendContentFlag == 'true'){
			if(Attachment_ObjectInfo['mainonline']){
				Attachment_ObjectInfo['mainonline'].requiredExec(true);
			}
		}
		_attEdit.css({'display':"block"});
		if(showButtonDivFlag){
			missiveButtonDiv.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0','display':"none"});
		}else{
			setTimeout(function(){
				missiveButtonDiv.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0','display':"none"});
			},2000);
			showButtonDivFlag = true;
		}
		_wordEdit.css({'width':"0px",'height':"0px"});
		wordFloat.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0'});
		wpsAddIn.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0'});
		var obj2 = document.getElementById("JGWebOffice_editonline");
		if(obj2){
			obj2.setAttribute("height","0px");
		}
		chromeHideJG_2015(0);
	}
}	
</script>
<script language="JavaScript">
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});
function generateAutoNumById(fdNoId){
	var docNum = document.getElementsByName("fdDocNum")[0];
	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
    var fdNoRule = document.getElementsByName("fdNoRule")[0];
    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
    var fdVirtualNum =""; 
    var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generateNumByNumberId"; 
	 $.ajax({    
	     type:"post",   
	     url:url,     
	     data:{fdNumberId:fdNoId,fdId:"${kmImissiveSendMainForm.fdId}",fdTemplateId:"${kmImissiveSendMainForm.fdTemplateId}",addCache:"false"},
	     async:false,    //用同步方式 
	     success:function(data){
	 	    var results =  eval("("+data+")");
	 	   if(results['fdVirtualNum']!=null){
		      fdVirtualNum = results['fdVirtualNum'];
			    if(results['docNum']!=null){
			    	 var arr =  results['docNum'].split("#");
				  if(arr.length>1){
			    		  fdNoRule.value = arr[0];
			    		  fdFlowNo.value = arr[1];
			    		  fdNumberMainId.value = arr[2];
			    		  docNum.value = arr[0].replace(new RegExp("@flow@",'g'),arr[1]);
				  }
	   		      //填充控件中的文号书签
	   		      if(Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad){
	   		         Attachment_ObjectInfo['editonline'].setBookmark('docnum',arr[0].replace(new RegExp("@flow@",'g'),arr[1]));
	   		      }
				}
	 	   } 
		}    
  });
}
//文档加载时自动获取文号
function generateAutoNum(){
	generateAutoNumById("${fdNoId}");
}

//文件编号
   function generateFileNum(){
	        var docNum = document.getElementsByName("fdDocNum")[0];
	        var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
	        var fdNoRule = document.getElementsByName("fdNoRule")[0];
	        var fdYearNo = document.getElementsByName("fdYearNo")[0];
	        var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
		    path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/kmImissiveNum.jsp?fdId=${kmImissiveSendMainForm.fdId}&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}&fdNoId=${fdNoId}&fdBufferNumId='+fdBufferNumId+'&isAdd=true';
		    dialog.iframe(path,'<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />',function(rtn){
			  if(rtn!="undefined"&&rtn!=null&&rtn!=""){
				  var arr =  rtn.fdRtnNum.split("#");
				  if(arr.length>1){
					  fdNoRule.value = arr[0];
		    		  	  fdFlowNo.value = arr[1];
		    		  	  fdNumberMainId.value = arr[2];
		    		  	  docNum.value = rtn.fdNum;
		    		  	  fdYearNo.value = rtn.fdYearNo;
		   		      document.getElementById("docnum").innerHTML = rtn.fdNum;
				  }
	   		      //填充控件中的文号书签
	   		      if(Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad){
	   		         Attachment_ObjectInfo['editonline'].setBookmark('docnum',rtn.fdNum);
	   		      }
			  }
		   },{width:650,height:400});
	}
	
 
var redheadFlag = ""; //是否进行套红标示
<c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on'}">
	 Com_Parameter.event["submit"].push(function(){
	   var type =  document.getElementsByName("fdNeedContent");
	   var flag = true;
	   if("${wpsoaassist}"!="true"){
		   if(""==redheadFlag&&type[0].value =="1"){
			   flag =  confirm('<bean:message key="kmImissive.redhead.comfirm.notNull" bundle="km-imissive" />');
		   }
	   }
	   return flag;
	});
</c:if>
</script>