<%@ page import="com.landray.kmss.util.IDGenerator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<%@ include file="/km/imissive/kmImissiveReg_script.jsp"%>

<script>
    Com_IncludeFile("jquery.js|docutil.js");
    Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<script>
 	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		window.dialog=dialog;
	});

	var subject = "${kmImissiveReceiveMainForm.docSubjectBak}";
	subject = subject.replace("&#039;", "'").replace("&#034;", "\"").replace( "%5C",   "\\").replace(/&#013;/g, "\r").replace(/&#010;/g, "\n");

	seajs.use(['lui/topic' ], function(topic) {
		topic.subscribe('/sys/attachment/wpsCloud/loaded', function(obj) {
			if(obj){
				var officeIframeh = "560";
				if($('.content').length > 0){
					var contentH = $('.content').height();
					officeIframeh = contentH-70;
				}
				obj.iframe.style.height=officeIframeh+"px";
			}
		});

		topic.subscribe('/sys/attachment/wpsCenter/loaded', function(obj) {
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
 	
 	//#105274 流程分发页面调整
	$(document).ready(function(){
		if($('#assignOprRow .lui-lbpm-checkbox').length > 0){
			$('#assignOprRow .lui-lbpm-checkbox').hide();
		}
		if($('input:radio[name="assignType"]')){
			$("#assignTypeDIV").hide();
			$('input:radio[name="assignType"][value="1"]').prop('checked', true);
			$('input:radio[name="assignType"][value="1"]').click();
			$("#canMultiAssign").click();
		}
		//如果表单没有纳入督办元素，移除督办先
		var fdIsSupervised = document.getElementsByName("fdIsSupervised");
		 if(fdIsSupervised.length <= 0){
			 $('#superVisedDiv').remove();
		}
	});

	//转pdf or ofd
	window.convertFileType=function(fileType){
		var attKey = '${contentKey}';
		var attShowType = '${attShowType}';
		var editStatus = '${editStatus}';
		if('0'==attShowType && 'true' == editStatus){
			var obj_ = document.getElementById("JGWebOffice_"+attKey);
			if(obj_){
				var saveA = document.getElementsByName(attKey+"_saveDraft")[0];
				if(saveA != null && saveA != undefined){
					saveA.click();
					convertFile(fileType);
				}
			}else{
				dialog.alert("金格控件加载异常，操作失败！");
			}
		}else if('1'==attShowType && 'true' == editStatus){
			var wpsObject;
			if (attKey == 'editonline' && wps_cloud_editonline){
				wpsObject = wps_cloud_editonline;
			}
			if (attKey == 'mainonline' && wps_cloud_mainonline){
				wpsObject = wps_cloud_mainonline;
			}
			if(wpsObject){
				if(!wpsObject.hasLoad){
					dialog.alert("当前正文内容未加载，请切换到正文页签加载正文后操作！");
					return;
				}
				var  savePromise = wpsObject.wpsObj.save();
				savePromise.then(function(rtn){
					convertFile(fileType);
				});
			}else{
				dialog.alert("wps加载异常，操作失败！");
			}
		}else{
			convertFile(fileType);
		}
	}

	window.ofdSursen=function(key){
		var convertId = "";
		if('${convertAttType}' == 'toOFD'){
			convertId = '${convertAttId}';
		}
		var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_main/kmImissiveMain.do?method=existSursenSignFile";
		$.ajax({
			url : url,
			type : 'post',
			data : {"fdId":"${param.fdId}","contentKey":key,"modelName":"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain","convertId":convertId},
			async : false,
			dataType:"json",
			error : function(){
				dialog.alert('请求出错');
			} ,
			success:function(data){
				if(data){
					var result= data['result'];
					if(result == 'true'){
						var restDownloadUrl= data['restDownloadUrl'];
						console.log(restDownloadUrl);
						var openUrl ="${LUI_ContextPath}/km/imissive/km_imissive_sign/sursenSign/kmImissiveMain_sursenSign.jsp?fdId=${param.fdId}"  +
								"&filePath=" + encodeURIComponent(restDownloadUrl) +
								"&fdKey=" + key +
								"&fdUserId=<%=UserUtil.getUser().getFdId()%>" +
								"&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
						window.open(openUrl, '_self');
					}else{
						dialog.alert('文件未转换');
					}
				}
			}
		});
	}

	function convertFile(fileType){
		var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_main/kmImissiveMain.do?method=convertTypeInfo";
		$.ajax({
			url : url,
			type : 'post',
			data : {"fdMainId":"${param.fdId}","converterKey":fileType,"modelKey":"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain","fdKey":"${contentKey}"},
			dataType : 'text',
			async : false,
			dataType:"json",
			error : function(){
				dialog.alert('请求出错');
			} ,
			success:function(data){
				if(data){
					var convertStatus= data['convertStatus'];
					var resultMsg= data['resultMsg'];
					switch (convertStatus) {
						case "200":
							dialog.alert(resultMsg);
							window.parent.location.reload();
							break;
						default:
							dialog.alert(resultMsg);
							break;
					}
				}
			}
		});
	}
 	
	 window.yqq=function(key){
		 var fileTypeUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateReceiveFileType&signId=${param.fdId}";
		 var queryStatusUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryStatus&signId=${param.fdId}";
		 var validateOnceUrl = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateOnce&signId=${param.fdId}";
		 $.ajax({
				url : fileTypeUrl,
				type : 'post',
				data : {},
				dataType : 'text',
				async : true,     
				error : function(){
					dialog.alert('请求出错');
				} ,   
				success:function(data){
					if(data == "true"){
						 $.ajax({
								url : queryStatusUrl,
								type : 'post',
								data : {},
								dataType : 'text',
								async : true,     
								error : function(){
									dialog.alert('请求出错');
								} ,   
								success : function(data) {
									if(data == "false"){
										$.ajax({
											url : validateOnceUrl,
											type : 'post',
											data : {},
											dataType : 'text',
											async : true,     
											error : function(){
												dialog.alert('请求出错');
											} ,   
											success:function(data){
												if(data == "true"){
													dialog.alert("当前收文已经发送过易企签签署，整个签署事件未完成，请等待完成后在发起签署！！");
												}else{
													var obj_ = document.getElementById("JGWebOffice_"+key);
												    if(obj_){
														if(Attachment_ObjectInfo[key]){
															 if(Attachment_ObjectInfo[key].ocxObj){
																 var rFlag=Attachment_ObjectInfo[key].ocxObj.WebSave();
																 if(rFlag){
																	 var infoUrl = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
																	 var extendIframe=dialog.iframe(infoUrl,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
																 }
															 }
														}
												    }else{
												    	var infoUrl = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=openYqqExtendInfo&signId=${param.fdId}";
														var extendIframe=dialog.iframe(infoUrl,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
												    }
												}
											}
										});
									}else{
										var extendIframe=dialog.iframe(data,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
									}
								}
							}); 
					}else{
						dialog.alert("易企签不支持该文件类型("+data+")签署，请上传以下文件类型(.pdf;.doc;.xls;.ppt;.docx;.xlsx;.pptx;.jpg;.jpeg;.png;)");
					}
				}
			});
		
	 };

	window.eqb = function(signType) {
		var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=";
		var attQueryData = {};
		if ("PDF" == signType) {
			url += "queryCfcaStatusPdf";
			attQueryData['fdId'] = "${param.fdId}";
			attQueryData['fdName'] = "receive";
			attQueryData['signFalg'] = "eqb";
			signType = "PDF";
		} else if ("OFD" == signType) {
			url += "queryContentAttOfdDone";
			attQueryData['fdModelId'] = "${param.fdId}";
			attQueryData['fdModelName'] = "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
		}
		var validateOnceUrl = Com_Parameter.ContextPath +
				"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=validateSignOnce";

		$.ajax({
			url: validateOnceUrl,
			type: 'post',
			data: {signId: "${param.fdId}", getSignUrl: "true", signatoryType: "eqb"},
			dataType: 'text',
			async: true,
			error: function() {
				dialog.alert('请求出错');
			},
			success: function(data) {
				data = eval('(' + data + ')');
				console.log("validator", data);
				if (data.isSign == "true") {
					if (data.signUrl) {
						confirmOpenSignPage("当前发文已经发送过e签宝签署，整个签署事件未完成，是否跳转到签署页面？", data.signUrl);
					} else {
						dialog.alert("当前发文已经发送过e签宝签署，整个签署事件未完成，请等待完成后在发起签署。");
					}
				} else if(data.isSign == "saas" && data.signUrl == "SaasFalse"){
					dialog.alert("当前发文已经发送过e签宝签署，整个签署事件未完成，请完成后在发起签署。");
				} else {
					$.ajax({
						url: url,
						type: 'post',
						data: attQueryData,
						dataType: 'text',
						async: false,
						dataType: "json",
						error: function() {
							dialog.alert('请求出错');
						},
						success: function(data) {
							if (data == true) {
								var signLoading = dialog.loading();
								var url = Com_Parameter.ContextPath +
										"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=sendEqb";

								$.ajax({
									url: url,
									type: 'post',
									data: JSON.stringify(buildEqbInfo(signType)),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									async: true,
									error: function() {
										signLoading.hide();
										dialog.alert("发送失败，请确认是否重复发送。");
									},
									success: function(data) {
										console.log("sendData: ", data);
										signLoading.hide();
										if (data.code == '0000') {
											if (data.data.signatories[0]) {
												var signUrl = data.data.signatories[0].signUrl;
												if(signUrl){
													confirmOpenSignPage("签署发送成功，是否立即跳转到签署页面，以免错过签署期限？",signUrl);
												}
											}else {
												dialog.alert("签署发送成功，请立即前往到签署页面，以免错过签署期限");
											}
										} else {
											dialog.alert("发送签署失败:" + data.desc);
											if (btn) {
												btn.setDisabled(false);
											}
										}
									}
								});
							} else {
								var tipStr = "当前PDF文件未转换成功，无法进行签署!";
								if ("OFD" == signType) {
									tipStr = "当前OFD文件未转换成功，无法进行签署!";
								}
								dialog.alert(tipStr);
							}
						}
					});
				}
			}
		});
	};

	window.querySignStatus = function(){
		var flag = false;
		var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
		$.ajax({
			url : url,
			type : 'post',
			data : {},
			dataType : 'text',
			async : false,
			error : function(){
				dialog.alert('请求出错');
			} ,
			success:function(data){
				if(data == "true"){
					flag = true;
				}else{
					dialog.alert("当前签署任务未完成，无法提交！！");
					flag = false;
				}
			}
		});
		return flag;
	};

	window.querySignStatusJgPdf = function(){
		var flag = false;
		var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
		$.ajax({
			url: url,
			type: 'post',
			data: {},
			dataType: 'text',
			async: false,
			error: function () {
				dialog.alert('请求出错');
			},
			success: function (data) {
				if (data == "true") {
					flag = true;
				} else {
					//谷歌下金格控件隐藏显示问题
					if (navigator.userAgent.indexOf("Firefox") >= 0 || navigator.userAgent.indexOf("Chrome") >= 0) {
						try {
							if (navigator.userAgent.indexOf("Chrome") >= 0) {
								// iwebPDF2018控件的优先级过高，会将弹出框和后面的按钮遮挡住value=1显示 value=0 隐藏
								var pdfFrame = document.getElementById('pdfFrame');
								if (pdfFrame != null) {
									pdfFrame.contentWindow.document.getElementById('JGWebPdf_convert_toPDF').HidePlugin(0);
								}
							}
						} catch (e) {
						}
					}
					dialog.confirm("当前签署任务未完成，无法提交，请签章完成之后点击保存再提交！", function (_flag) {
						//谷歌下金格控件隐藏显示问题
						if (navigator.userAgent.indexOf("Firefox") >= 0 || navigator.userAgent.indexOf("Chrome") >= 0) {
							try {
								if (navigator.userAgent.indexOf("Chrome") >= 0) {
									// iwebPDF2018控件的优先级过高，会将弹出框和后面的按钮遮挡住value=1显示 value=0 隐藏
									var pdfFrame = document.getElementById('pdfFrame');
									if (pdfFrame != null) {
										pdfFrame.contentWindow.document.getElementById('JGWebPdf_convert_toPDF').HidePlugin(1);
									}
								}
							} catch (e) {
							}
						}
					}, "warn");
					flag = false;
				}
			}
		});
		return flag;
	};

	/**
	 * 确认是否跳转到签署页面
	 */
	function confirmOpenSignPage(tipText, signUrl) {
		dialog.confirm(tipText, function (value) {
			if (value) {
				Com_OpenWindow(signUrl, "_blank");
				setTimeout(function () {
					dialog.confirm("是否已经完成签署？", function (confirmVal) {
						if (confirmVal) {
							window.location.reload();
						}
					})
				}, 1000)
			}
		});
	}

	/**
	 * 构建e签宝签署信息
	 */
	function buildEqbInfo(signType) {
		var signData = {};
		var our = {};

		signData['signId'] = '${param.fdId}';
		signData['applyId'] = '${kmImissiveReceiveMainForm.fdId}';
		// contractNo由后台生成UUID设值
		signData['contractNo'] = '';
		// signData['contractName'] = 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain';
		signData['contractName'] = subject;
		signData['signType'] = signType;
		signData['missiveName'] = 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain';
		signData['convertId'] = '${convertAttId}';
		signData['convertType'] = '${convertAttType}';

		//信息
		our['enterPriseName'] = subject; //名称
		//our['enterPriseMan']='${loginName}';//联系人
		our['enterPrisePhone'] = '${mobileNo}' //联系电话
		our['enterPriseManNo']='${fdCertNo}'//证件号
		our['enterPriseManType']='${fdCertType}'//证件类型

		//绑定
		our['bindOrgId'] = '${contentKey}'; //fdKey
		our['bindSignerName'] = '${loginName}'; //签署人
		our['enterpriseId'] = '${enterpriseId}'; //企业Id
		signData['ourInfo'] = our;
		return signData;
	}

	<c:if test="${(kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.eqbSign =='true' or kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.OfdEqbSign =='true')  && eqbFlag=='true'}">
		Com_Parameter.event["submit"].push(function(){
			var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
			//操作类型为通过类型 ，才判断是否已经签署
			if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
				return querySignStatus();
			}else{
				return true;
			}
		});
	</c:if>
 	
	<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
	 Com_Parameter.event["submit"].push(function(){
		 var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
		//操作类型为通过类型 ，才判断是否已经签署
		if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
			return querySignStatus();
		}else{
			return true;
		} 
	 });
	 </c:if>

	<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =='true'}">
		Com_Parameter.event["submit"].push(function () {
			var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
			//操作类型为通过类型 ，才判断是否已经签署
			if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
				return querySignStatus();
			} else {
				return true;
			}
		});
	</c:if>
	<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.pdfJgSign =='true'}">
		seajs.use(['lui/jquery', 'lui/topic'], function ($, topic) {
			topic.subscribe('km.imissive.jgPdfSave', function (evt) {
				if (evt.flag) {
					//政务公文添加/修改kmImissiveOutSign表数据，给公文提交时用来判断是否已经签过章
					var url = Com_Parameter.ContextPath + "km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=jgPdfSaveSign&fdModelId=" + evt.fdModelId + "&persionId=" + evt.persionId;
					$.ajax({
						url: url,
						type: 'post',
						data: {},
						dataType: 'text',
						async: false,
						success: function (data) {
						}
					});
				}
			});
		});
		Com_Parameter.event["submit"].push(function () {
			var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
			//操作类型为通过类型 ，才判断是否已经签署
			if ($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
				return querySignStatusJgPdf();
			} else {
				return true;
			}
		});
	</c:if>

    window.addAdviceOpinionInner = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=addAdviceOpinion&flag=receive&fddetaiId=${kmImissiveReceiveMainForm.fdDetailId}";
       window.open(url, "_self");
    };
 	
 	
   window.addSignOpinionOuter = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_regdetail_opinion/kmImissiveRegDetailOpinion.do?method=addSignOpinion&flag=receive&fddetaiId=${kmImissiveReceiveMainForm.fdDetailId}";
        window.open(url, "_self");
   };
   
   window.addSignOpinionInner = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=addSignOpinion&flag=receive&fddetaiId=${kmImissiveReceiveMainForm.fdDetailId}";
       window.open(url, "_self");
  };
	
	window.returnDocOuter = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_regdetail_opinion/kmImissiveRegDetailOpinion.do?method=addOuter&flag=receive&fddetaiId=${kmImissiveReceiveMainForm.fdDetailId}";
        window.open(url, "_self");
   };
	window.returnDoc = function(){
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=add&flag=receive&fddetaiId=${kmImissiveReceiveMainForm.fdDetailId}&fdreceiveId=${kmImissiveReceiveMainForm.fdId}";
        window.open(url, "_self");
   };
	window.changeToSend = function(){
	     var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkTemp";
		   $.ajax({     
	  	     type:"post",     
	  	     url:url,     
	  	     data:{type:"RS",fdReceiveId:"${kmImissiveReceiveMainForm.fdId}"}, 
	  	     async:false,    //用同步方式 
	  	     success:function(data){
	  	    	 results =  eval("("+data+")");
		    	    if(results['nodata']=="true"){
		    	    	 var url = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fdTemplateId=!{id}&fdReceiveId=${kmImissiveReceiveMainForm.fdId}";
	    	             dialog.categoryForNewFile(
	 							'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',url,false,null,null,null,"_self",null,true);
			    	}else{
			    		dialog.tree('kmImissiveCfgTreeService&type=RS&fdReceiveId=${kmImissiveReceiveMainForm.fdId}','<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.select.sendTemplate"/>',function(rtn){
			    		if(rtn){
			    			var idString = rtn.value;
			                if(idString!=""){
			               	 var idArray = idString.split(";");
			   	             var fdTemplateId = idArray[0];
			   	             var fdCfgId =idArray[1];
			   	             var url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fdTemplateId="+fdTemplateId+"&fdCfgId="+fdCfgId+"&fdReceiveId=${kmImissiveReceiveMainForm.fdId}";
			   	             Com_OpenWindow(url, "_self");
			                }
			    		}
			   		 });  
			      }
	  		 }    
	      });
   };
	window.changeToReceive = function(){
		 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkTemp"; 
		   $.ajax({     
	  	     type:"post",     
	  	     url:url,     
	  	     data:{type:"RR",fdReceiveId:"${kmImissiveReceiveMainForm.fdId}"},    
	  	     async:false,    //用同步方式 
	  	     success:function(data){
	  	    	 results =  eval("("+data+")");
		    	    if(results['nodata']=="true"){
		    	    	 var url = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&isSign=false&fdTemplateId=!{id}&fdReceiveId=${kmImissiveReceiveMainForm.fdId}";
	    	             dialog.categoryForNewFile(
	 							'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate',url,false,null,null,null,"_self",null,true);
			    	}else{
			    		 dialog.tree('kmImissiveCfgTreeService&type=RR&fdReceiveId=${kmImissiveReceiveMainForm.fdId}','<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.select.receiveTemplate"/>',function(rtn){
			    			 if(rtn){
				    			 var idString = rtn.value;
				                 if(idString!=""){
				                	 var idArray = idString.split(";");
				    	             var fdTemplateId = idArray[0];
				    	             var fdCfgId =idArray[1];
				    	             var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fdTemplateId="+fdTemplateId+"&fdCfgId="+fdCfgId+"&fdReceiveId=${kmImissiveReceiveMainForm.fdId}";
				    	             Com_OpenWindow(url, "_self");
				                 }
			    			 }
			    	    });    
			      }
	  		 }    
	      });  
   };
   window.editDocNum = function(){
		var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=editDocNum&fdId=${param.fdId}';
	    dialog.iframe(url,'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.editdocnum"/>',function(rtn){
	    	 if(rtn!=null&&rtn!="cancel"){
	    	    location.reload();
	    	 }
		  },{width:600,height:300});
	};
	window.distributeDoc = function(){
		//saveFinal();
		var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do?method=distribute&fdMainId=${param.fdId}';
	    dialog.iframe(url,'<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.title"/>',function(rtn){
	    	 if(rtn!=null&&rtn!="cancel"){
	    	    location.reload();
	    	 }
		  },{width:850,height:500});
	};
	window.report = function(){
		var url = Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do?method=report&fdMainId=${param.fdId}';
	    dialog.iframe(url,'<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report.title"/>',function(rtn){
	    	 if(rtn!=null&&rtn!="cancel"){
	    	    location.reload();
	    	 }
		  },{width:850,height:500});
	};
	
	 window.cfca=function(){
		 	//判断当前任务是否已完成
		 	var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaFinish";
		 	$.ajax({
				url : url,
				type : 'post',
				data : {"signId":"${param.fdId}"},
				dataType : 'text',
				async : false,
				dataType:"json",
				error : function(){
					dialog.alert('请求出错');
				} ,   
				success:function(data){
					if(data == true){
						dialog.alert("当前签署任务已完成，无法进行签署!");
					}else{
						//判断当前主文档是否有正文
						var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaNeedContent";
					 	$.ajax({
							url : url,
							type : 'post',
							data : {"taskId":"${param.fdId}","taskName":"receive"},
							dataType : 'text',
							async : false,
							dataType:"json",
							error : function(){
								dialog.alert('请求出错');
							} ,   
							success:function(data){
								if(data == true){
									var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryCfcaStatusPdf";
									 $.ajax({
											url : url,
											type : 'post',
											data : {"fdId":"${param.fdId}","fdName":"receive"},
											dataType : 'text',
											async : false,
											dataType:"json",
											error : function(){
												dialog.alert('请求出错');
											} ,   
											success:function(data){
												if(data == true){
													var infoUrl = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=openYqqExtendInfo&signId=${param.fdId}&signFlag=cfca";
													var extendIframe=dialog.iframe(infoUrl,"签署平台签署",null,{width:1200, height:600, topWin : window, close: true});
												}else{
													dialog.alert("当前PDF文件未转换成功，无法进行签署!");
												}
											}
										});
								}else{
									dialog.alert("没有正文附件，无法进行签署!");
								}
							}
						});
					}
				}
			});
		
	 }
	 
	 <c:if test="${eSignatureModuleExist=='true'&&kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sign == 'true'}">
	 Com_Parameter.event["submit"].push(function(){
		 var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
		//操作类型为通过类型 ，才判断是否已经签署CFCA
		if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
			return querySignStatus();
		}else{
			return true;
		} });
	 </c:if>
	
	
	function Delete(){
    	/* dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
	    	if(flag==true){
	    		Com_OpenWindow('kmImissiveReceiveMain.do?method=delete&fdId=${param.fdId}','_self');
	    	}else{
	    		return false;
		    }
	    },"warn"); */
		Com_Delete_Get(delUrl, 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain');
		return;
    }; 
    
    /* 软删除配置 */
    function Delete(delUrl){
		Com_Delete_Get(delUrl, 'com.landray.kmss.km.imissive.model.KmImissiveReceiveMain');
    	return;
   }	
	
		function filingDoc() {
			seajs.use(['sys/ui/js/dialog'],
					function(dialog) {
			    	dialog.confirm("${lfn:message('km-imissive:alert.filing.msg')}",function(flag){
				    	if(flag==true){
				    		Com_OpenWindow('kmImissiveReceiveMain.do?method=filing&fdId=${param.fdId}','_self');
				    	}else{
				    		return;
					    }
				  },"warn");
			});
		}
	</script>
<script language="javascript"><!--
var wnd;  //定义辅助功能全局变量

//作用：签章
function DoJFSignature()
{
	var nodeId = $("#processNodeId").text();
	var processNodeId = "fd_" + nodeId.substring(0,nodeId.indexOf("."));
  kmImissiveReceiveMainForm.SignatureControl.FieldsList="DOCUMENTID=文档主键值"       //所保护字段
  kmImissiveReceiveMainForm.SignatureControl.DivId=processNodeId;                             //设置签章位置是相对于哪个标记的什么位置 
  kmImissiveReceiveMainForm.SignatureControl.RunSignature();                         //执行签章操作
	//标签页是否展开
	var tab = LUI('kmImissiveSendMain_content');
	
	if (tab != null) {
		var panel = tab.parent;
		$.each(panel.contents, function(i) {
			if (this == tab) {
				panel.onToggle(i, false, true);
				panel.onToggle(i, false, false);
				return false;
			}
		});
	}
}


//作用：自动锁定文档
function ProtectDocument()
{
   var mLength=document.getElementsByName("iHtmlSignature").length; 
   var mProtect = false;
   for (var i=0;i<mLength;i++){
       var vItem=document.getElementsByName("iHtmlSignature")[i];
	   if(vItem.DocProtect)
	   {
          mProtect = true;
		  break;
	   }	   
   }
  if(!mProtect){
     var vItem = document.getElementsByName("iHtmlSignature")[mLength-1];
	 vItem.LockDocument(true);
   }
}


//作用：进行手写签名
function DoSXSignature()
{
	var isIEFlag = '${isIE}';
	if (null != isIEFlag && isIEFlag != 'true') {
		alert('<bean:message key="kmImissiveSignature.signatureIsIE" bundle="km-imissive"/>');
		return '';
	}
	var nodeId = $("#processNodeId").text();
	var processNodeId = "fd_" + nodeId.substring(0,nodeId.indexOf("."));
	var siginatureDivObj = document.getElementById(processNodeId);
	if (null == siginatureDivObj || "undefined" == siginatureDivObj) {
		alert('<bean:message key="kmImissiveSignature.signatureAlert" bundle="km-imissive"/>');
		return '';
	}  
  //雾化功能
  //var mXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
  //mXml = mXml + "  <Signature>";
  //mXml =mXml  +  "<OtherParam>";
  //mXml = mXml + "  <IsAtomize>TRUE</IsAtomize>";
  //mXml = mXml + "  <AtomizeValue>5</AtomizeValue>";
  //mXml =mXml  +  "</OtherParam>";
  //mXml = mXml + "  </Signature>";
  //kmImissiveReceiveMainForm.SignatureControl.XmlConfigParam = mXml;
  
  //屏蔽签章中的不通过项
  var noPassXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
  noPassXml = noPassXml + "  <Signature><RunHandwrite> " +
  	"  <PermissionNotPassEnabled>0</PermissionNotPassEnabled>"
  	+ "  </RunHandwrite></Signature>";
  kmImissiveReceiveMainForm.SignatureControl.XmlConfigParam = noPassXml;
  
  kmImissiveReceiveMainForm.SignatureControl.FieldsList="DOCUMENTID=文档主键值"       //所保护字段
  kmImissiveReceiveMainForm.SignatureControl.Position(0,0);                           //手写签名位置
  kmImissiveReceiveMainForm.SignatureControl.HandPenWidth = 1;                        //设置、读取手写签名的笔宽
  kmImissiveReceiveMainForm.SignatureControl.HandPenColor = 100;                      //设置、读取手写签名
  kmImissiveReceiveMainForm.SignatureControl.HandPenWidth = 1;                        //设置、读取手写签名的笔宽
  kmImissiveReceiveMainForm.SignatureControl.HandPenColor = 100;                      //设置、读取手写签名笔颜色笔颜色
  kmImissiveReceiveMainForm.SignatureControl.DivId=processNodeId;                            //设置签章位置是相对于哪个标记的什么位置
  kmImissiveReceiveMainForm.SignatureControl.RunHandWrite();                          //执行手写签名
}
//作用：删除签章
function DeleteSignature()
{
   var mLength=document.getElementsByName("iHtmlSignature").length; 
   var mSigOrder = "";
   for (var i=mLength-1;i>=0;i--){
       var vItem=document.getElementsByName("iHtmlSignature")[i];
	   //mSigOrder := 
	   if (vItem.SignatureOrder=="1")
	   {
         vItem.DeleteSignature();
	   }
   }
}

//作用：打印文档
function PrintDocument(){
   //var tagElement = document.getElementById('kmImissiveSendMain_content');
  // alert(tagElement);
  // tagElement.className = 'print';                                                 //样式改变为可打印
   var mCount = kmImissiveReceiveMainForm.SignatureControl.PrintDocument(false,2,5);  //打印控制窗体
  // alert("实际打印份数："+mCount);
  // tagElement.className = 'Noprint';                                               //样式改变为不可打印
}
<c:if test="${JGSignatureHTMLEnabled == 'true'}">
window.onload=function(){
	kmImissiveReceiveMainForm.SignatureControl.ShowSignature('${param.fdId}');
};
window.onunload=function(){
	kmImissiveReceiveMainForm.SignatureControl.DeleteSignature();
};
</c:if>
--></script>
<script>
$KMSSValidation(document.forms['kmImissiveReceiveMainForm']);
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});


function generateFileNum4Publsh(){
	  var path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/kmImissiveNum.jsp?fdId=${kmImissiveReceiveMainForm.fdId}&fdNoId=${fdNoId}&fdBufferNumId='+fdBufferNumId+'&fdTemplateId=${kmImissiveReceiveMainForm.fdTemplateId}';
    dialog.iframe(path,'<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />',function(rtn){
		  if(rtn!="undefined"&&rtn!=null){
			  var arr =  rtn.fdRtnNum.split("#");
			  console.log(arr);
			  if(arr.length==3){
				  var fdNoRule = arr[0];
		    		  var fdFlowNo = arr[1];
		    		  var fdNumberMainId = arr[2];
		    		  var docNum = rtn.fdNum;
		    		  var fdYearNo = rtn.fdYearNo;
	  		     var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveDocNum"; 
			    	 $.ajax({     
			    	     type:"post",     
			    	     url:url,     
			    	     data:{fdDocNum:docNum,fdFlowNo:fdFlowNo,fdNoRule:fdNoRule,fdNumberMainId:fdNumberMainId,fdId:"${kmImissiveReceiveMainForm.fdId}",fdYearNo:fdYearNo},
			    	     async:false,    //用同步方式 
		    	     	 success:function(data){
				    	   results =  eval("("+data+")");
				    	    if(results['isRepeat']=="true"){
				    	    		dialog.failure('<bean:message bundle="km-imissive" key="kmImissiveSendMain.message.error.fdDocNum.repeat"/>');
				    		}else{
				    			dialog.success("更新文档编号成功");
				    			LUI('toolbar').removeButton(LUI('generateFileNum4Publsh'));
			             	LUI('generateFileNum4Publsh').destroy();
				    		}
				    	    if(fdBufferNumId !=""){
			 			    	var docBufferNum = getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain");
			 			    	if(docBufferNum){
							    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
							    	if((docNum == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || fdFlowNo > docBufferNumArr[1]){
							    		delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
							    	}
							 }
			 			}
				     }     
		          });
			  }
		  }
	  },{width:600,height:400});
}


//文件编号
function generateFileNum(){
		 //文件编号的时候，审批人不一定有编辑正文的权限，先接触文档保护
	    if(Attachment_ObjectInfo['editonline']){
	    	if(Attachment_ObjectInfo['editonline'].ocxObj){
	    		Attachment_ObjectInfo['editonline'].ocxObj.EditType = "1";
			}
	    }
	    if(Attachment_ObjectInfo['mainonline']){
	    	if(Attachment_ObjectInfo['mainonline'].ocxObj){
	    		Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "1";
	    	}
	    }
        var docNum = document.getElementsByName("fdReceiveNum")[0];
        var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
        var fdNoRule = document.getElementsByName("fdNoRule")[0];
        var fdYearNo = document.getElementsByName("fdYearNo")[0];
        var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
	    path=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/kmImissiveNum.jsp?fdId=${kmImissiveReceiveMainForm.fdId}&fdTemplateId=${kmImissiveReceiveMainForm.fdTemplateId}&fdNumberId=${fdNoId}&fdBufferNumId='+fdBufferNumId;
	    dialog.iframe(path,'<bean:message key="kmImissive.modifyDocNum" bundle="km-imissive" />',function(rtn){
		  if(rtn!="undefined"&&rtn!=null){
			  var arr =  rtn.fdRtnNum.split("#");
			  if(arr.length==3){
				  fdNoRule.value = arr[0];
		    		  fdFlowNo.value = arr[1];
		    		  fdNumberMainId.value = arr[2];
		    		  docNum.value = rtn.fdNum;
		    		  fdYearNo.value = rtn.fdYearNo;
	   		      document.getElementById("docnum").innerHTML = rtn.fdNum;
			  }
   		      //填充控件中的文号书签
   		      if(Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad){
   		         Attachment_ObjectInfo['editonline'].setBookmark('receivenum',rtn.fdNum);
   		         if("${isReadOnly}"=="true"){
   		        	 if(Attachment_ObjectInfo['editonline'].ocxObj){
   		        		if(!Attachment_ObjectInfo['editonline'].canCopy){
   							Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
   							Attachment_ObjectInfo['editonline'].ocxObj.EditType = "0,1";
   						}else{
   							Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
   							Attachment_ObjectInfo['editonline'].ocxObj.EditType = "4,1";
   						}
   		        	 }
		         }
   		      }
	   		  if(Attachment_ObjectInfo['mainonline']&&Attachment_ObjectInfo['mainonline'].hasLoad){
	   			 Attachment_ObjectInfo['mainonline'].setBookmark('receivenum',rtn.fdNum);
	   			if("${isReadOnly}"=="true"){
	   				if(Attachment_ObjectInfo['mainonline'].ocxObj){
	   					if(!Attachment_ObjectInfo['mainonline'].canCopy){
							Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
							Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "0,1";
						}else{
							Attachment_ObjectInfo['mainonline'].ocxObj.CopyType = "1";
							Attachment_ObjectInfo['mainonline'].ocxObj.EditType = "4,1";
						}
	   				}
		         }
	   		  }
		  }
	   },{width:600,height:400});
}

function loadWordEdit(fdKey){
	var wordFloat = $("#wordEditFloat");
	var _attEdit = $('#'+fdKey);
	wordFloat.css({'width':'auto','height':'600px','filter':'alpha(opacity=100)','opacity':'1'});
	_attEdit.css({'display':"none"});
	setTimeout(function(){
		 if(Attachment_ObjectInfo[fdKey]){
			 if($('.bar-right') && $('.content')){
					$('.bar-right').css('width','50%');
					$('.content').css('margin-right','51.5%');
			}
			Attachment_ObjectInfo[fdKey].load();
			Attachment_ObjectInfo[fdKey].show();
			if("${isReadOnly}"=="true"){
				if(Attachment_ObjectInfo[fdKey].ocxObj){
					if(!Attachment_ObjectInfo[fdKey].canCopy){
						Attachment_ObjectInfo[fdKey].ocxObj.CopyType = "1";
						Attachment_ObjectInfo[fdKey].ocxObj.EditType = "0,1";
					}else{
						Attachment_ObjectInfo[fdKey].ocxObj.CopyType = "1";
						Attachment_ObjectInfo[fdKey].ocxObj.EditType = "4,1";
					}
				}
			}
			if(Attachment_ObjectInfo[fdKey].ocxObj){
				Attachment_ObjectInfo[fdKey].ocxObj.Active(true);
				//在线编辑打开，默认显示留痕
				if(!Attachment_ObjectInfo[fdKey].forceRevisions){
					Attachment_ObjectInfo[fdKey].ocxObj.WebShow(Attachment_ObjectInfo[fdKey].forceRevisions);
				}else if(Attachment_ObjectInfo[fdKey].showRevisions == true  ){
					Attachment_ObjectInfo[fdKey].ocxObj.WebSetRevision(true,true,true,true);
				}
			}
		 }
	},1000);
}


var confirmSuperviseFlag = "";  //是否核发督办标示
function confirmSupervisedInner(){
	var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=updateConfirmSupervise"
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdModelId:"${kmImissiveReceiveMainForm.fdId}",fdModelName:"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"},    
	     async:false,    //用同步方式 
	     success:function(data){
	    	    results =  eval("("+data+")");
	    	    if(results['flag']=="true"){
	    	    	confirmSuperviseFlag = "true";
	    	    	//隐藏督办核发按钮  
	    	    	$("#confirmSuperVisedBtn").hide();
		    	    dialog.alert("督办核发成功");
		    	}
	    }     
     });
}

function confirmSupervised(){
	if("${kmImissiveReceiveMainForm.fdSuperviseFlag}" == 'true'){
		dialog.confirm("该督办已核发，是否确定重新核发？",function(flag){
		    	if(flag==true){
		    		confirmSupervisedInner();
		    	}else{
		    		return;
			}
	  	},"warn");
	}else{
		confirmSupervisedInner();
	}
}

var fdBufferNumId = "";	  //记录当前所预览的编号规则id
var fdVirtualNum = "";  //记录当前所预览的编号规则的虚拟值
function  Com_submitReviewInner(){
	
	Com_Submit(document.kmImissiveReceiveMainForm, 'approveReceive');
	
	var docNum = document.getElementsByName("fdReceiveNum")[0];
	//删除当前所用编号规则的cookie,避免新建每次取到同一编号
	var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
	if(fdBufferNumId !="" && (checkIfFutureNodeSelected() || (canStartProcess && canStartProcess.value == "false"))){
   	 	deleteBufferNumByNumberId(fdBufferNumId);
	}
}

function deleteBufferNumByNumberId(fdBufferNumId){
	var docBufferNum = getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveReceiveMain");
	if(docBufferNum){
		var fdYearNo = document.getElementsByName("fdYearNo");
		var nowYearNo = "";
		var date = new Date();
		nowYearNo = date.getFullYear();
	    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
	    	var docNum = document.getElementsByName("fdReceiveNum")[0];
	    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
	    	if((docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || (fdYearNo.length > 0 && fdYearNo[0].value == nowYearNo && fdFlowNo.value > docBufferNumArr[1])){
	    		 delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
				 //delCookieByName(fdBufferNumId);
	    	}
	}
}

<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.confirmSupervise =='true' and not empty fdSuperviseId}">
Com_Parameter.event["submit"].push(function(){
	var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
	if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
		var fdSuperviseFlag = '${kmImissiveReceiveMainForm.fdSuperviseFlag}';
		if(""==confirmSuperviseFlag && "true"!=fdSuperviseFlag){
			flag =  confirm("当前审批节点有“核发督办”附加选项，请确认是否核发督办？");
			if(flag){
				confirmSupervised();
			}
		}
	}
    return true;
});
</c:if>



function  Com_submitReview(){
	
	var fdIsSupervised = document.getElementsByName("fdIsSupervised");
	var superVisedFrame = LUI('superVisedFrame');
	if(fdIsSupervised.length > 0 && fdIsSupervised[0].value == "true" && superVisedFrame.src !=""){		
		superVisedFrame.$iframeNode[0].contentWindow.goushi();
	}else{
		Com_submitReviewInner();
	}
}

<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
Com_Parameter.event["submit"].push(function(){
		//操作类型为通过类型 ，才写回编号 
		if(lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
		    var docNum = document.getElementsByName("fdReceiveNum")[0];
		    var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
		    var fdNoRule = document.getElementsByName("fdNoRule")[0];
		    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
		    var fdYearNo = document.getElementsByName("fdYearNo")[0];
		    var isRepeat=true;
		    var results;
		    if(""==docNum.value){
		    	isRepeat = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
		     }else{
		    	 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveDocNum"; 
		    	 $.ajax({     
		    	     type:"post",     
		    	     url:url,     
		    	     data:{fdDocNum:docNum.value,fdFlowNo:fdFlowNo.value,fdNoRule:fdNoRule.value,fdNumberMainId:fdNumberMainId.value,fdId:"${kmImissiveReceiveMainForm.fdId}",fdYearNo:fdYearNo.value},    
		    	     async:false,    //用同步方式 
		    	     success:function(data){
				    	    results =  eval("("+data+")");
				    	    if(results['isRepeat']=="true"){
				    	    	 //如果编号被占用，则删除cookie和 数据库保存的编号
				    	    	 if(fdBufferNumId !=""){
				    	    		 deleteBufferNumByNumberId(fdBufferNumId);
				 		 }
				    		    alert('<bean:message bundle="km-imissive" key="kmImissiveReceiveMain.message.error.fdDocNum.repeat"/>');
				    		    isRepeat = false;
				    	}
				    }     
		          });
		        if(results['flag']=="false"&&results['isRepeat']!="true"){
			        alert("更新文档编号不成功");
			        return false
			    }else{
		    	    return isRepeat;
			    }
		     }
		    return isRepeat;
		}else{
			return true;
		}
});
</c:if>
</script>
