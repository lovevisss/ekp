<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="java.util.Date"%>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<%
	//生成一个附件id,供原始稿上传用
	request.setAttribute("attId", IDGenerator.generateID());
%>
<script>
    Com_IncludeFile("dialog.js|jquery.js");
    Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
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
 		   LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');
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
	submitOrUpdateDoc(formObj, "saveDraft4RedHead");

	//删除当前所用编号规则的cookie,避免新建每次取到同一编号
	  if(fdBufferNumId!=""  && validation.validate() && docNum.value != "" && checkIfFutureNodeSelected()){
		  var docBufferNum = getTempNumberFromDb(fdBufferNumId);
		  if(docBufferNum){
		    	var fdVirtualNum = decodeURI(docBufferNum).split("#");
		    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
		    	if(docNum.value == formatNum(fdVirtualNum[0],fdVirtualNum[1]) || fdFlowNo.value > fdVirtualNum[1]){
		    		 delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
					 //delCookieByName(fdBufferNumId);
		    	}
		   }
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
		    if(results['exist'] == "true"){
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


//记录下当前预览的编号规则id
var fdBufferNumId = "${fdNoId}"; 
function commitMethod(commitType, saveDraft){
	var formObj = document.kmImissiveSendMainForm;
	var docStatus = document.getElementsByName("docStatus")[0];
	var docNum = document.getElementsByName("fdDocNum")[0];
	var flag = true;
	if(saveDraft=="true"){
		docStatus.value="10";
		validation.removeElements($('#kmImissiveSendXform')[0],'required');
	}else{
		validation.resetElementsValidate($('#kmImissiveSendXform')[0]);
		docStatus.value="20";
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
							  var docBufferNum = getTempNumberFromDb(fdBufferNumId);
						    if(docBufferNum){
						    	var fdVirtualNum = decodeURI(docBufferNum).split("#");
						    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
						    	if(docNum.value == formatNum(fdVirtualNum[0],fdVirtualNum[1]) || fdFlowNo.value > fdVirtualNum[1]){
						    		 delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
									 //delCookieByName(fdBufferNumId);
						    	}
						    }
					      }
			    		 dialog.alert('<bean:message key="kmImissiveSendMain.message.error.fdDocNum.repeat" bundle="km-imissive" />');
			    		 flag = false;
			    	 }
				}    
		 	});	
		 }
	  }
	}
	if(flag){
	   beforeSubjectForm().then(function(){
		//提交时判断是否需要正文，如果不需要则移除页面控件对象
		submitOrUpdateDoc(formObj, commitType);
	
		//删除当前所用编号规则的cookie,避免新建每次取到同一编号
		  if(fdBufferNumId!=""  && validation.validate() && docNum.value != "" && checkIfFutureNodeSelected()){
			  var docBufferNum = getTempNumberFromDb(fdBufferNumId);
			  if(docBufferNum){
			    	var fdVirtualNum = decodeURI(docBufferNum).split("#");
			    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
			    	if(docNum.value == formatNum(fdVirtualNum[0],fdVirtualNum[1]) || fdFlowNo.value > fdVirtualNum[1]){
			    		 delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
						 //delCookieByName(fdBufferNumId);
			    	}
			   }
	      }
	   });
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
	
	 var obj = document.getElementById("JGWebOffice_editonline");
     if(type[0].value !="1"){
       	 if("${kmImissiveSendMainForm.method_GET}"=="add"){
       		 if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
    	       jg_attachmentObject_editonline.unLoad();
       		 }
       	 }
      }else{
    	  if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
    		  if(jg_attachmentObject_editonline.ocxObj){
    		    jg_attachmentObject_editonline.ocxObj.Active(true);
    		  }
    		    addBookMarks("editonline");
	            jg_attachmentObject_editonline._submit();
    	  }else{
    		  dialog.alert('<div class="msgTitle">无法正常提交，可能原因:</div><div class="msgContent">1、当前浏览器不支持在线编辑<br>2、当前浏览器没正常安装金格控件<br>3、当前正文为在线编辑方式，正文页签内容没正常加载</div>');
	       		return;
    	  }
      }
     
	  Com_Submit(formObj, commitType);
}

function submitOrUpdateDoc(formObj, commitType){
	if("${kmImissiveSendMainForm.docStatus}" == '30'){
		saveModifyRecord().then(function(){
			saveDoc(formObj, commitType);
		});
	}else{
		saveDoc(formObj, commitType);
	} 
}

function checkEditType(value){
	var type=document.getElementsByName("fdNeedContent")[0];
	type.value = "0";
	var _wordEdit = $('#wordEdit');
	var _attEdit = $('#attEdit');
	var wordFloat = $("#wordEditFloat");
	var missiveButtonDiv = $("#missiveButtonDiv");
	if("1" == value){
		type.value = "1";
		_wordEdit.css({'display':"block",'width':"100%",'height':"600px"});
		//var xw = $("#wordEditWrapper").width();
		wordFloat.css({'width':'auto','height':'600px','filter':'alpha(opacity=100)','opacity':'1'});
		missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
		_attEdit.css({'display':"none"});
		var obj = document.getElementById("JGWebOffice_editonline");
		setTimeout(function(){
			
			if(!jg_attachmentObject_editonline.getOcxObj()){
				dialog.alert("当前浏览器检测不到金格控件,在线编辑功能无法使用，若是刚安装完金格控件，请刷新页面或重新浏览器试试！");
			}else{
				if(obj&&Attachment_ObjectInfo['editonline'] && !jg_attachmentObject_editonline.hasLoad){
					jg_attachmentObject_editonline.load();
					jg_attachmentObject_editonline.show();
					if(jg_attachmentObject_editonline.ocxObj){
						jg_attachmentObject_editonline.ocxObj.Active(true);
					}
				 }
			}
		},1000);
		seajs.use(['lui/topic'],function(topic){
			topic.subscribe("Sidebar",function(data){
				//var xw = $("#wordEditWrapper").width();
				wordFloat.css({'width':'auto','height':'600px','filter':'alpha(opacity=100)','opacity':'1'});
				missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
			});
		});
		chromeHideJG_2015(1);
		$("#JGWebOffice_editonline").height("550px");
	} else {
		_attEdit.css({'display':"block"}); 
		missiveButtonDiv.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0','display':"none"});
		_wordEdit.css({'width':"0px",'height':"0px"});
		wordFloat.css({'width':'0px','height':'0px','filter':'alpha(opacity=0)','opacity':'0'});
		$("#JGWebOffice_editonline").height("0px");
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
	var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generateVirtualNumByNumberId"; 
	 $.ajax({     
	     type:"post",    
	     url:url,   
	     data:{fdNumberId:fdNoId,fdId:"${kmImissiveSendMainForm.fdId}",fdTemplateId:"${kmImissiveSendMainForm.fdTemplateId}"},
	     async:false,    //用同步方式 
	     success:function(data){
	 	    var results =  eval("("+data+")");
		    if(results['fdVirtualNum']!=null){
		       fdVirtualNum = results['fdVirtualNum'];
				 if(getTempNumberFromDb(fdNoId)){
			    	fdNoRule.value = getNumberRule(getTempNumberFromDb(fdNoId));
			    	fdFlowNo.value = getFlowNum(getTempNumberFromDb(fdNoId));
			    	fdNumberMainId.value = getNumberMainId(getTempNumberFromDb(fdNoId));
					 docNum.value = formatNum(fdVirtualNum,fdFlowNo.value);  //对从cookie中取出来的值进行解码
				}else{
					var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=generateNumByNumberId"; 
					 $.ajax({    
					     type:"post",   
					     url:url,     
					     data:{fdNumberId:fdNoId,fdId:"${kmImissiveSendMainForm.fdId}"},
					     async:false,    //用同步方式 
					     success:function(data){
					 	    var results =  eval("("+data+")");
						    if(results['docNum']!=null){
						    	 var arr =  results['docNum'].split("#");
								  if(arr.length>1){
						    		  fdNoRule.value = arr[0];
						    		  fdFlowNo.value = arr[1];
						    		  fdNumberMainId.value = arr[2];
						    		  docNum.value = arr[0].replace(new RegExp("@flow@",'g'),arr[1]);
								  }
					   		      //填充控件中的文号书签
					   		      if(Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
					   		         Attachment_ObjectInfo['editonline'].setBookmark('docnum',arr[0].replace(new RegExp("@flow@",'g'),arr[1]));
					   		      }
							}
						}    
				  });
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
	        var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
		    path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/kmImissiveNum.jsp?fdId=${kmImissiveSendMainForm.fdId}&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}&fdNoId=${fdNoId}&isAdd=true';
		    dialog.iframe(path,'<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />',function(rtn){
			  if(rtn!="undefined"&&rtn!=null&&rtn!=""){
				  var arr =  rtn.fdRtnNum.split("#");
				  if(arr.length>1){
					  fdNoRule.value = arr[0];
		    		  fdFlowNo.value = arr[1];
		    		  fdNumberMainId.value = arr[2];
		    		  docNum.value = rtn.fdNum;
		   		      document.getElementById("docnum").innerHTML = rtn.fdNum;
				  }
	   		      //填充控件中的文号书签
	   		      if(Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
	   		         Attachment_ObjectInfo['editonline'].setBookmark('docnum',rtn.fdNum);
	   		      }
			  }
		   },{width:600,height:400});
	}
	
 
var redheadFlag = ""; //是否进行套红标示
<c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on'}">
 Com_Parameter.event["submit"].push(function(){
   var type =  document.getElementsByName("fdNeedContent");
   var flag = true;
   if(""==redheadFlag&&type[0].value =="1"){
	   flag =  confirm('<bean:message key="kmImissive.redhead.comfirm.notNull" bundle="km-imissive" />');
   }
   return flag;
 });
</c:if>
</script>