<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ include file="/component/locker/import/componentLockerVersion_show.jsp"%>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable(true)));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isWPSCenterEnableMobile(true)));
%>
<template:include ref="mobile.edit" compatibleMode="true">
    <template:replace name="head">
    	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/detailInput.css?s_cache=${MUI_Cache}" />
		
	   	<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
		   		if("${kmImissiveSignMainForm.fdNeedContent}" == '1' && "${_isWpsCloudEnable}" == 'true'){
		   		 	window._narStore = new Memory({
			   			data:[{'text':'<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />', 'moveTo':'scrollView','selected':true},
			   				  {'text':'<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />','moveTo':'contentView'},
			   				 {'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'lbpmView'}
			   			] 
			   		});
		   		}else if("${kmImissiveSignMainForm.fdNeedContent}" == '1' && "${_isWpsCenterEnable}" == 'true'){
					window._narStore = new Memory({
						data:[{'text':'<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />', 'moveTo':'scrollView','selected':true},
							{'text':'<bean:message bundle="km-imissive" key="kmImissiveSendMain.docContent" />','moveTo':'contentView'},
							{'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'lbpmView'}
						]
					});
				}else{
		   			window._narStore = new Memory({
			   			data:[{'text':'<bean:message bundle="km-imissive" key="kmImissiveSendMain.baseinfo" />', 'moveTo':'scrollView','selected':true},
			   				 {'text':'<bean:message  bundle="km-imissive" key="mui.process.records"/>','moveTo':'lbpmView'}
			   			] 
			   		});
		   		}
			    
			   	topic.subscribe("/mui/navitem/_selected",function(evtObj){
			   		setTimeout(function(){topic.publish("/mui/list/resize");},150);
			   	});
		   	});
		 </script>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmImissiveSignMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
	<xform:config  orient="vertical">
		<html:form action="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=save&mobile=true">
			<div class="muiFlowInfoW">
				<%-- 头部页签（1.审批内容、2.流程操作） --%>
				<div data-dojo-type="mui/fixed/Fixed"  id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem" >
						<div data-dojo-type="mui/nav/NavBarStore" data-dojo-mixins="km/imissive/mobile/resource/js/MissiveNavBarMixin" data-dojo-props="store:_narStore"  id="_flowNav"></div>
					</div>
				</div>
				
				<div id="scrollView"  data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
					<div data-dojo-type="mui/panel/Content">
						<div class="muiFormContent">
							<html:hidden property="docStatus" />
							<html:hidden property="fdId"/>
							<html:hidden property="fdModelId" />
							<html:hidden property="fdModelName"/>
							<html:hidden property="fdNeedContent" />
							<input type="hidden" name="mobileEditAttId" value="${mobileEditAttId}">
							<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
								<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
							</c:import>
							<c:import url="/sys/news/mobile/import/edit.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
								<c:param name="fdKey" value="signMainDoc" /> 
							 </c:import>
							<c:import url="/sys/relation/mobile/edit_hidden.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
							</c:import>
							<!-- 版本锁机制 -->
							<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
							</c:import>
						</div>
						<c:if test="${(_isWpsCloudEnable ne 'true' and _isWpsCenterEnable ne 'true') or '0' eq kmImissiveSignMainForm.fdNeedContent}">
							<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
								<c:if test="${kmImissiveSignMainForm.method_GET=='add'}">
									<tr id="fdEditTypeTr">
										<td class="muiTitle" style="width:105px">
											<bean:message key="kmImissiveSignTemplate.fdNeedContent" bundle="km-imissive" />
										</td>
										<td>
											<xform:radio property="fdEditType" mobile="true" showStatus="edit" value="${kmImissiveSignMainForm.fdNeedContent}">
												<xform:enumsDataSource enumsType="kmImissiveSignTemplate_fdNeedContent" />
											</xform:radio>
										</td>
									</tr>
								</c:if>
								<tr id="wordEdit" <c:if test="${'0' eq kmImissiveSignMainForm.fdNeedContent}">style="display:none"</c:if>>
									<td class="muiTitle" style="width:105px">
										正文
									</td>
									<td>
										<div>
											<div  class="oldMui muiFormUploadWrap">
												<div  class="muiAttachmentEditItem muiAttachmentEditOptItem" onclick="editFileOnline();">
													<div class="muiAttachmentItemT">
														<div class="muiAttachmentItemIcon">
															<i class="mui mui-insert mui-rotate-45"></i>
														</div>
														<div class="muiAttachmentItemText">在线编辑</div>
													</div>
												</div>
											</div>
											<div class="tip">
											</div>
							          	  </div>
						            </td>
								</tr>
							</table>
						</c:if>
						<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm" />
							<c:param name="fdKey" value="signMainDoc" />
							<c:param name="backTo" value="scrollView" />
						</c:import>
					</div>
					<c:choose>
						<c:when test="${'1' eq kmImissiveSignMainForm.fdNeedContent and _isWpsCloudEnable}">
							<%-- 操作按钮展示区域  --%>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
							  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
							  		data-dojo-props='moveTo:"contentView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
							</ul>
						</c:when>
						<c:when test="${'1' eq kmImissiveSignMainForm.fdNeedContent and _isWpsCenterEnable}">
							<%-- 操作按钮展示区域  --%>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
									data-dojo-props='moveTo:"contentView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
							</ul>
						</c:when>
						<c:otherwise>
							<%-- 操作按钮展示区域  --%>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
							  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " 
							  		data-dojo-props='moveTo:"lbpmView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>	
				<c:if test="${'1' eq kmImissiveSignMainForm.fdNeedContent and _isWpsCloudEnable}">
					<div data-dojo-type="mui/view/DocScrollableView" id="contentView">
						<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
							<tr>
								<td colspan="2">
									<div id="wordEdit">
										<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
											<c:param name="formBeanName" value="kmImissiveSignMainForm" />
											<c:param name="fdTemplateModelId" value="${kmImissiveSignMainForm.fdTemplateId}" />
											<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="fdTempKey" value="${kmImissiveSignMainForm.fdTemplateId}" />
										</c:import>
						          	 </div>
					            </td>
							</tr>
						</table>
						<%-- 操作按钮展示区域  --%>
						<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
						  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
						  		data-dojo-props='moveTo:"lbpmView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
						</ul>
					</div>
				</c:if>
					<c:if test="${'1' eq kmImissiveSignMainForm.fdNeedContent and _isWpsCenterEnable}">
						<div data-dojo-type="mui/view/DocScrollableView" id="contentView">
							<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
								<tr>
									<td colspan="2">
										<div id="wordEdit">
											<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="editonline" />
												<c:param name="load" value="false" />
												<c:param name="bindSubmit" value="false"/>
												<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
												<c:param name="formBeanName" value="kmImissiveSignMainForm" />
												<c:param name="fdTemplateModelId" value="${kmImissiveSignMainForm.fdTemplateId}" />
												<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
												<c:param name="fdTemplateKey" value="editonline" />
												<c:param name="fdTempKey" value="${kmImissiveSignMainForm.fdTemplateId}" />
											</c:import>
										</div>
									</td>
								</tr>
							</table>
								<%-- 操作按钮展示区域  --%>
							<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext "
									data-dojo-props='moveTo:"lbpmView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
							</ul>
						</div>
					</c:if>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="review_submit();" />
				</c:import>
				<c:if  test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on'}">
					<%@ include file="/km/imissive/mobile/cookieUtil_script.jsp"%>
					<%@ include file="/km/imissive/mobile/sign/number_include.jsp"%>
				</c:if>
			</div>	
			<script>
			require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
				ready(function() {
					if("${_isWpsCloudEnable}" == 'true'){
						 <c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on'}">
						  	BarTip.tip({text: '移动设备不支持套红功能，建议使用电脑操作'});
						  </c:if>
					}else if("${_isWpsCenterEnable}" == 'true'){
						<c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on'}">
						BarTip.tip({text: '移动设备不支持套红功能，建议使用电脑操作'});
						</c:if>
					}else{
						 <c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on' or nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on'}">
						  	BarTip.tip({text: '移动设备不支持正文编号、套红功能，建议使用电脑操作'});
						  </c:if>
					}
				}); 
			});
			</script>
			<script type="text/javascript">
			
			require(["mui/form/ajax-form!kmImissiveSignMainForm"]);
			require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util","mui/device/device" , 'dojox/mobile/TransitionEvent',"dojo/Deferred",'dojo/date/locale'],
					function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,device,TransitionEvent,Deferred,locale){
				//返回主视图
				window.backToDocView=function(obj){
					var opts = {
						transition : 'slide',
						transitionDir:-1,
						moveTo:'scrollView'
					};
					new TransitionEvent(obj, opts).dispatch();
					
				};
				ready(function() {
					var devType = device.getClientType();
					if (devType != 9 && devType != 10){
						var fdEditType = document.getElementById("fdEditTypeTr");
						var _wordEdit = document.getElementById("wordEdit");
						var type=document.getElementsByName("fdNeedContent")[0];
						var flag = false;
						if("${_isWpsCloudEnable}" != 'true' && "${_isWpsCenterEnable}" != 'true' ){
							flag = true;
						}else if(("${_isWpsCloudEnable}" == 'true' && type.value == '0')){
							flag = true;
						}else if( ("${_isWpsCenterEnable}" == 'true' && type.value == '0')){
							flag = true;
						}
						if(flag){
							if(fdEditType){
								fdEditType.style.display = "none";
							}
							type.value='0';
							document.getElementsByName("mobileEditAttId")[0].value = "";
							_wordEdit.style.display = "none";
						}
					}
				});
				
				var wpsLoaded = false;
						var wpsCenterLoaded = false;
				topic.subscribe('mui/view/currentView',function(view){
					if(view && view.id == "contentView"){
						if("${_isWpsCloudEnable}" == 'true') {
							if (!wpsLoaded) {
								wpsCloudAattachment_editonline.load();
								wpsLoaded = true;
							}
						}else if("${_isWpsCenterEnable}" == 'true'){
							if(!wpsCenterLoaded){
								wpsCenterAattachment_editonline.load();
								wpsCenterLoaded = true;
							}
						}
					}
				});
				
				topic.subscribe('/sys/attachment/wpsCloud/loaded',function(obj,evt){
					if(evt && evt.height){
						obj.iframe.style.height = (evt.height-45) + "px";
					}
				});

						topic.subscribe('/sys/attachment/wpsCenter/loaded',function(obj,evt){
							if(evt && evt.height){
								obj.iframe.style.height = (evt.height-45) + "px";
							}
						});
				
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					var _wordEdit = document.getElementById("wordEdit");
					var type=document.getElementsByName("fdNeedContent")[0];
					if(widget && widget.name=="fdEditType"){
						if(args.value == '1'){
							type.value='1';
							_wordEdit.style.display = "";
							//请求在线编辑附件的id
							req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=addOnlineFile"), {
								handleAs : 'json',
								method : 'post',
								data : {
									fdTemplateId:"${kmImissiveSignMainForm.fdTemplateId}"
								}
							}).then(lang.hitch(this, function(data) {
								if (data){
								    if(data['mobileEditAttId']!=null){
							    	 document.getElementsByName("mobileEditAttId")[0].value = data['mobileEditAttId'];
									}
								}
							}));
							
						}else{
							type.value='0';
							document.getElementsByName("mobileEditAttId")[0].value = "";
							_wordEdit.style.display = "none";
						}
					}
				});
				
				
				window.editFileOnline = function(){
					
					var mobileEditAttId = document.getElementsByName("mobileEditAttId")[0].value;
					
					if(typeof(eval(adapter.editfile)) == 'function'){
						adapter.editfile({ 
							fdAttMainId : mobileEditAttId,
							name : "editonline.doc",
							href : util.formatUrl("/sys/attachment/sys_att_main/sysAttMain.do?method=readDownload&fdId="+mobileEditAttId),
							key :"${kmImissiveSignMainForm.fdTemplateId}"
						},function(rtn){
							
							if(rtn.code==0){
								Tip.processing({
									text : rtn.text
								});
							}
							
							if(rtn.code==1){
								var date = new Date();
								var dStr = locale.format(date,{
									selector : 'time',
									timePattern : "${ lfn:message('date.format.datetime') }"
								});
								query('.tip')[0].innerHTML= '<font color="red">上一次保存时间: '+dStr+'</font>';
							}
							
						},function(rtn){
							Tip.fail({
								text : rtn.text
							});
						});
					}else{
						Tip.fail({
							text : '当前平台不支持在线编辑！'
						});
					}
				},
				
				window.deleteBufferNumByNumberId = function(fdBufferNumId){
					var docNum = document.getElementsByName("fdDocNum")[0];
					var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
					getTempNumberFromDb(fdBufferNumId,"com.landray.kmss.km.imissive.model.KmImissiveSignMain").then(lang.hitch(this, function(data) { 
	   					 var results =  eval("("+data+")");
	   					 if(results['docNum']!=null){
	   						var docBufferNum =results['docNum'];
	   						if(docBufferNum){
	   							var fdYearNo = document.getElementsByName("fdYearNo");
	    							var nowYearNo = "";
	    							var date = new Date();
	    							nowYearNo = date.getFullYear();
							    	var docBufferNumArr = decodeURI(docBufferNum).split("#");
							    	if((docNum.value == formatNum(docBufferNumArr[0],docBufferNumArr[1])) || (fdYearNo.length > 0 && fdYearNo[0].value == nowYearNo && fdFlowNo.value > docBufferNumArr[1])){
							    		delTempNumFromDb(fdBufferNumId,decodeURI(docBufferNum));
							    	}
							 }
	   					 }
	   				}));
				},
				
				window.saveWps = function (){
					var defered = new Deferred();
					var type=document.getElementsByName("fdNeedContent")[0];
					if(type.value == '1'){
						if(wpsCloudAattachment_editonline && wpsCloudAattachment_editonline.wpsSdkManage){
							var rtnPromise = wpsCloudAattachment_editonline.wpsSdkManage.save();
						 	rtnPromise.then(function(rtn){
						    		if(rtn.result=="nochange"){
						    			defered.resolve();
						    		}
						    		if(rtn.result=="ok"){
						    			defered.resolve();	
						    		}
					    		});
						}
					}else{
						defered.resolve();
					}
				 	return defered;
				},

						window.saveWpsCenter = function (){
							var defered = new Deferred();
							var type=document.getElementsByName("fdNeedContent")[0];
							if(type.value == '1'){
								if(wpsCenterAattachment_editonline && wpsCenterAattachment_editonline.wpsSdkManage){
									var rtnPromise = wpsCenterAattachment_editonline.wpsSdkManage.save();
									rtnPromise.then(function(rtn){
										if(rtn.result=="nochange"){
											defered.resolve();
										}
										if(rtn.result=="ok"){
											defered.resolve();
										}
									});
								}
							}else{
								defered.resolve();
							}
							return defered;
						},
				
				window.fdBufferNumId = "";
				window.review_submit = function (){
					var docStatus = document.getElementsByName("docStatus")[0];
					var method = Com_GetUrlParameter(location.href,'method');
					var docNum = document.getElementsByName("fdDocNum")[0];
					if("${_isWpsCloudEnable}" == 'true'){
						defer = saveWps();
					}else if("${_isWpsCenterEnable}" == 'true'){
						defer = saveWpsCenter();
					}else{
						var defered = new Deferred();
						defer = defered.resolve();
					}
					defer.then(lang.hitch(this,function(){ 
						if(method=='add'){
							docStatus.value="20";
								if('${nodeExtAttributeMap['modifyDocNum4Draft']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'on'){
								   if(""==docNum.value){
									   if("${fdNoId}" != ""){
											var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
										    var fdNoRule = document.getElementsByName("fdNoRule")[0];
										    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
										    req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=generateNumByNumberId"), {
												handleAs : 'json',
												method : 'post',
												data : {
													fdNumberId:"${fdNoId}",
													fdId:"${kmImissiveSignMainForm.fdId}"
												}
											}).then(lang.hitch(this, function(results) {
												if (results){
												    if(results['docNum']!=null){
											    	 var arr =  results['docNum'].split("#");
													  if(arr.length>1){
											    		  fdNoRule.value = arr[0];
											    		  fdFlowNo.value = arr[1];
											    		  fdNumberMainId.value = arr[2];
											    		  docNum.value = arr[0].replace("@flow@",arr[1]);
													  }
													}
												}
												Com_Submit(document.forms[0],'save');
											}));
									   }else{
										   flag = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
									   }
								   }else{
									   req(util.formatUrl("/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=checkUniqueNum"), {
											handleAs : 'json',
											method : 'post',
											data : {
												fdNo:docNum.value,
												fdId:"${kmImissiveSignMainForm.fdId}",
												fdTempId:"${kmImissiveSignMainForm.fdTemplateId}"
											}
										}).then(lang.hitch(this, function(results) {
										if (results){
										    	 if(results['unique'] =='false'){
										    		//如果编号被占用，则删除cookie和 数据库保存的编号
										    	    	if(fdBufferNumId !=""){
										    	    		deleteBufferNumByNumberId(fdBufferNumId);
										 		 }
										    	    	Tip.tip({icon:'mui mui-warn', text:'<bean:message key="kmImissiveSendMain.message.error.fdDocNum.repeat" bundle="km-imissive" />',width:'260'});
										    		return false;
										     }
										}
										 Com_Submit(document.forms[0],'save');
									}));
								 }
							  }else{
								  Com_Submit(document.forms[0],'save');
							  }
						}else{
							if("${kmImissiveSignMainForm.docStatus} == '10'"){
								docStatus.value="20";
							}
							Com_Submit(document.forms[0],'update');
						}
						//如果编号被占用，则删除cookie和 数据库保存的编号
				    	    	if(fdBufferNumId !=""){
				    	    		deleteBufferNumByNumberId(fdBufferNumId);
				 		}
					}),lang.hitch(this,function(result){
						
					}));
					
				}
			});
			</script>
	</html:form>
</xform:config>
</template:replace>
</template:include>		
