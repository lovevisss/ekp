<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="java.util.Date"%>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<%-- WPS中台和撤回套红操作JS --%>
<jsp:include page="/km/imissive/wps/kmImissive_wpsCenter_script.jsp">
    <jsp:param name="imissiveFormName" value="kmImissiveSignMainForm"/>
</jsp:include>
<%-- WPS中台操作脚本 --%>
<%@ include file="/km/imissive/wps/kmImissive_wpsCenter_script.jsp"%>
<c:set var="fdYqqKeyPdf" value="yqqSigned" />
<c:set var="fdEqbKeyPdf" value="eqbSign" />
<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
<c:set var="fdConvertOfd" value="convert_toOFD" />
<c:set var="fdConvertPdf" value="convert_toPDF" />
<c:choose>
    <c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
        <c:set var="fdSignKey" value="yqqSigned" scope="request"/>
    </c:when>
    <c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
        <c:set var="fdSignKey" value="eqbSign" scope="request"/>
    </c:when>
    <c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
        <c:set var="fdSignKey" value="ofdEqbSign" scope="request"/>
    </c:when>
    <c:when test="${not empty kmImissiveSignMainForm.attachmentForms['dianjuSign'].attachments}">
        <c:set var="fdSignKey" value="dianjuSign" scope="request"/>
    </c:when>
    <c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdSsKeyOfd].attachments}">
        <c:set var="fdSignKey" value="ofdSursenSign" scope="request"/>
    </c:when>
    <c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdConvertOfd].attachments}">
        <c:set var="fdSignKey" value="convert_toOFD" scope="request"/>
    </c:when>
    <c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdConvertPdf].attachments}">
        <c:set var="fdSignKey" value="convert_toPDF" scope="request"/>
    </c:when>
    <c:otherwise>
        <c:set var="fdSignKey" value="" scope="request"/>
    </c:otherwise>
</c:choose>
<script>
    Com_IncludeFile("dialog.js|jquery.js");
    Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<script language="JavaScript">
	function _updateDraft(){
	   validation.resetElementsValidate($('#kmImissiveSignXform')[0]);
	   submitOrUpdateDoc(document.kmImissiveSignMainForm, 'updateDraft');
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
		var formObj = document.kmImissiveSignMainForm;
		var docNum = document.getElementsByName("fdDocNum")[0];
		var flag = true;
		if(docNum.value != "" || docNum.value != null){
			var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=checkUniqueNum"; 
			 $.ajax({     
			     type:"post",   
			     url:url,     
			     data:{fdNo:docNum.value,fdId:"${kmImissiveSignMainForm.fdId}",fdTempId:"${kmImissiveSignMainForm.fdTemplateId}"},
			     async:false,    //用同步方式 
			     success:function(data){
			    	 var results =  eval("("+data+")");
			    	 if(results['unique'] =='false'){
			    		//如果编号被占用，则删除cookie和 数据库保存的编号
			    	    	 if("${fdNoId}" !=""){
			    	    		 deleteBufferNumByNumberId();
			 		}
			    		 alert('<bean:message key="kmImissiveSignMain.message.error.fdDocNum.repeat" bundle="km-imissive" />');
			    		 flag = false;
			    	 }
				}    
		   });	
		 }
		if(flag){	   
	 		submitOrUpdateDoc(formObj, commitType,true);
			 //删除cookie,避免新建每次取到同一编号
			 if("${fdNoId}"!=""  && validation.validate() && docNum.value != ""  && checkIfFutureNodeSelected()){
				 deleteBufferNumByNumberId();
			}
       	}
	}

	
	var fdVirtualNum = "";  //记录当前所预览的编号规则的虚拟值
	function commitMethod(commitType, saveDraft){
		var formObj = document.kmImissiveSignMainForm;
		var docStatus = document.getElementsByName("docStatus")[0];
		var docNum = document.getElementsByName("fdDocNum")[0];
		var flag = true;
		if(saveDraft=="true"){
			docStatus.value="10";
			validation.removeElements($('#kmImissiveSignXform')[0],'required');
            validation.removeElements($('#nextNodeRow')[0],'required');
		}else{
			validation.resetElementsValidate($('#kmImissiveSignXform')[0]);
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
                        if (contents[i].id == "kmImissiveSignMain_baseinfo") {
                            LUI("tabpanelDiv").setSelectedIndex(i);
                        }
                    }
                }
            }
		}
		if('${nodeExtAttributeMap['modifyDocNum4Draft']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'on'){
		   if(""==docNum.value){
			   if("${fdNoId}" != ""){
			     generateAutoNum();
			     flag = true;
			   }else{
				   flag = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
			   }
		   }else{
				var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=checkUniqueNum"; 
				 $.ajax({     
				     type:"post",   
				     url:url,     
				     data:{fdNo:docNum.value,fdId:"${kmImissiveSignMainForm.fdId}",fdTempId:"${kmImissiveSignMainForm.fdTemplateId}"},
				     async:false,    //用同步方式 
				     success:function(data){
				    	 var results =  eval("("+data+")");
				    	 if(results['unique'] =='false'){
				    		//如果编号被占用，则删除cookie和 数据库保存的编号
				    	    	 if("${fdNoId}" !=""){
				    	    		 deleteBufferNumByNumberId();
				 		}
				    		 alert('<bean:message key="kmImissiveSignMain.message.error.fdDocNum.repeat" bundle="km-imissive" />');
				    		 flag = false;
				    	 }
					}    
			 });	
			}
		 }
	 	if(flag){	   
	 		submitOrUpdateDoc(formObj, commitType);
			 //删除cookie,避免新建每次取到同一编号
			 if("${fdNoId}"!=""  && validation.validate() && docNum.value != ""  && (checkIfFutureNodeSelected() || docStatus.value=="10")){
				 deleteBufferNumByNumberId();
			 }
       	}
	}
	
	function deleteBufferNumByNumberId(){
		 var docBufferNum = getTempNumberFromDb("${fdNoId}","com.landray.kmss.km.imissive.model.KmImissiveSignMain");
		if(docBufferNum){
			var fdYearNo = document.getElementsByName("fdYearNo");
			var nowYearNo = "";
			var date = new Date();
			nowYearNo = date.getFullYear();
		    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
		    	var docNum = document.getElementsByName("fdDocNum")[0];
		    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
		    	if((docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || (fdYearNo.length > 0 && fdYearNo[0].value == nowYearNo && fdFlowNo.value > docBufferNumArr[1])){
		    		delTempNumFromDb("${fdNoId}",decodeURI(docBufferNum));
					 //delCookieByName(fdBufferNumId);
		    	}
		}
	}
	
	
	function submitOrUpdateDoc(formObj, commitType,isShow){
        if (!isShow) {
            validation.resetElementsValidate($('#kmImissiveReceiveXform')[0]);
            validation.resetElementsValidate($('#nextNodeRow')[0]);
            if (!validation.validate()) {
                // 移除检验组件在新UI下的顶部提示
                if ($("#lui_validate_message").length > 0) {
                    $("#lui_validate_message").remove();
                }
                if (LUI("tabpanelDiv")) {
                    var contents = LUI("tabpanelDiv").contents;
                    for (var i = 0; i < contents.length; i++) {
                        if (contents[i].id == "kmImissiveReceiveMain_baseinfo") {
                            LUI("tabpanelDiv").setSelectedIndex(i);
                        }
                    }
                }
            }
        }
		//提交时判断是否需要正文，如果不需要则移除页面控件对象
		var type =  document.getElementsByName("fdNeedContent");
		var _isWpsCloudEnable = "${_isWpsCloudEnable}";
        var _isWpsCenterEnable = "${_isWpsCenterEnable}";
		if(_isWpsCloudEnable == "false" && _isWpsCenterEnable == "false"){
			var obj = document.getElementById("JGWebOffice_editonline");
	       	 if(type[0].value !="1"){
	       		if("${wpsoaassist}"!="true"){
		       		if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
			        	jg_attachmentObject_editonline.unLoad();
			            $("#wordEdit").remove();
		       		 }
	       		}
	       	}else{
		    	if("${wpsoaassist}"!="true"){
		    		if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad && jg_attachmentObject_editonline.ocxObj){
			   			jg_attachmentObject_editonline.ocxObj.Active(true);
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
		}
		 Com_Submit(formObj, commitType);
	}
	
	function doRedHead(){
	       var type =  document.getElementsByName("fdNeedContent");
	       if(type[0].value !="1"){
	    	 		alert('当前为不需要正文模式，套红请切换为在线编辑模式！');
	       }else{
		    	   if("${kmImissiveSignMainForm.method_GET}" == 'add'){
		    		   dialog.confirm("当前为起草节点,套红将自动对文档进行暂存，是否继续？",function(flag){
		    		    	if(flag==true){
		    		    		redheadFlag = "true";
		    		    		saveDraft4RedHead();
		    		    	}else{
		    		    		return;
		    			    }
		    		  },"warn");
		    	   }else{
		    		   if("${_isWpsCloudEnable}" == "true"){
	    	 			  LoadWpsHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');
	    	 		   }else if("${_isWpsCenterEnable}" == "true"){
                           LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');
                       }else{
	    	 			  LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');
	    	 		   }
		    	   }
	       }
	   }
	 
	 function saveDraft4RedHead(){
	 	var formObj = document.kmImissiveSignMainForm;
		var docStatus = document.getElementsByName("docStatus")[0];
		docStatus.value="10";
		var docNum = document.getElementsByName("fdDocNum")[0];
		validation.removeElements($('#kmImissiveSignXform')[0],'required');
		
		submitOrUpdateDoc(formObj, "saveDraft4RedHead",true);
		 //删除cookie,避免新建每次取到同一编号
		 if("${fdNoId}"!=""  && validation.validate() && docNum.value != ""  && (checkIfFutureNodeSelected() || docStatus.value=="10")){
			 var docBufferNum = getTempNumberFromDb("${fdNoId}","com.landray.kmss.km.imissive.model.KmImissiveSignMain");
			 if(docBufferNum){
			    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
			    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
				    	if(docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])|| fdFlowNo.value > docBufferNumArr[1]){
				    		 delTempNumFromDb("${fdNoId}",decodeURI(docBufferNum));
				    	}
			    }
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
		var wordFloat = $("#wordEditFloat");
		var missiveButtonDiv = $("#missiveButtonDiv");
		var wpsoaassist = "${wpsoaassist}";
		var wpsAddIn = $("#wpsAddIn");
        var fdSignKey = '${fdSignKey}';
        if("1" == value){
			type.value = "1";
			if (wpsoaassist=="true") {
				wpsAddIn.css({'width':'auto','height':'auto','filter':'alpha(opacity=100)','opacity':'1'});
				missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
				_wordEdit.css({'display':"block",'width':"100%",'height':"auto"});
				return;
			}
			_wordEdit.css({'display':"block",'width':"100%",'height':"auto"});
			//var xw = $("#wordEditWrapper").width();
			wordFloat.css({'width':'auto','height':'auto','filter':'alpha(opacity=100)','opacity':'1'});
			missiveButtonDiv.css({'width':'auto','height':'25px','filter':'alpha(opacity=100)','opacity':'1','display':"block"});
			var obj = document.getElementById("JGWebOffice_editonline");
            if(fdSignKey == "") {
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
                                    $('#office-iframe').width("100%");
                                }else{
                                    $('#office-iframe').height( "580px");
                                    $('#office-iframe').width("100%");
                                }
                            }
                        }
                    }else{
                        if("${wpsoaassist}"!="true"){
                            if(!Attachment_ObjectInfo['editonline'].getOcxObj()){
                                dialog.alert("当前浏览器检测不到金格控件,在线编辑功能无法使用，若是刚安装完金格控件，请刷新页面或重新浏览器试试！");
                            }else{
                                if(obj&&Attachment_ObjectInfo['editonline'] && !Attachment_ObjectInfo['editonline'].hasLoad){
                                    jg_attachmentObject_editonline.load();
                                    jg_attachmentObject_editonline.show();
                                    jg_attachmentObject_editonline.ocxObj.Active(true);
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
        } else {
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
$(document).ready(function(){
	<c:if  test="${(nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on')}">
	 //generateAutoNum();
	</c:if>
});
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});


function generateAutoNumById(fdNoId){
	var docNum = document.getElementsByName("fdDocNum")[0];
	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
    var fdNoRule = document.getElementsByName("fdNoRule")[0];
    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
    var fdVirtualNum =""; 
    var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=generateNumByNumberId"; 
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdNumberId:fdNoId,fdId:"${kmImissiveSignMainForm.fdId}"},   
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
		    path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/kmImissiveNum.jsp?fdId=${kmImissiveSignMainForm.fdId}&fdNumberId=${fdNoId}&fdTemplateId=${kmImissiveSignMainForm.fdTemplateId}&isAdd=true';
		    dialog.iframe(path,"文件编号",function(rtn){
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
		   },{width:550,height:320});
	}
</script>