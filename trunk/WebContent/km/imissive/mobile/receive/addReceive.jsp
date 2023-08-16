<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissiveReceiveMain.create.title') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceive&mobile=true">
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel"  class="editPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'正文',icon:'mui-ul'">
						<div class="muiFormContent">
							<html:hidden property="fdId"/>
							<html:hidden property="docStatus" />
							<html:hidden property="fdReceiveStatus" />
							<html:hidden property="fdModelId" />
							<html:hidden property="fdModelName"/>
							<html:hidden property="fdMainId"/>
							<html:hidden property="fdDetailId"/>
							<html:hidden property="fdDeliverType"/>
							<html:hidden property="fdTemplateId" />
							<html:hidden property="fdNeedContent"/>
							<html:hidden property="fdReadSendOpinion"/>
							
						
							<input type="hidden" name="mobileEditAttId" value="${mobileEditAttId}">
							<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm" />
								<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							</c:import>
							<c:import url="/sys/news/mobile/import/edit.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm" />
								<c:param name="fdKey" value="receiveMainDoc" /> 
							 </c:import>
							<c:import url="/sys/relation/mobile/edit_hidden.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm" />
							</c:import>
						</div>
						<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
							<c:if test="${kmImissiveReceiveMainForm.method_GET=='add'}">
							<tr id="fdEditType">
								<td class="muiTitle" style="width:105px">
									<bean:message key="kmImissiveReceiveTemplate.fdNeedContent" bundle="km-imissive" />
								</td>
								<td>
									<xform:radio property="fdEditType" mobile="true" showStatus="edit" value="${kmImissiveReceiveMainForm.fdNeedContent}">
										<xform:enumsDataSource enumsType="kmImissiveReceiveTemplate_fdNeedContent" />
									</xform:radio>
								</td>
							</tr>
							</c:if>
							<tr>
								<td colspan="2">
									<div id="wordEdit" <c:if test="${'0' eq kmImissiveReceiveMainForm.fdNeedContent}">style="display:none"</c:if>>
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
						            <div id="attEdit"  <c:if test="${'1' eq kmImissiveReceiveMainForm.fdNeedContent}">style="display:none"</c:if>>
						                <div class="path_addopt" >
						                	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
												<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
												<c:param name="fdKey" value="mainonline"></c:param>
												<c:param name="fdMulti" value="false"></c:param>
												<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
												<c:param name="customSubject" value="正文上传"></c:param>
												<c:param name="widgitId" value="attList_mainonline"></c:param>
											</c:import> 
						                </div>
						            </div>
					            </td>
							</tr>
							<tr>
								<td colspan="2">
									 ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }:
									<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelId" value="${param.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
									</c:import>
								</td>
							</tr>
						</table>	
					</div>
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo"/>',icon:'mui-ul'">
						<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
							charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveReceiveMainForm" />
							<c:param name="fdKey" value="receiveMainDoc" />
							<c:param name="backTo" value="scrollView" />
						</c:import>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " 
				  		data-dojo-props='moveTo:"lbpmView",transition:"slide"'><bean:message  bundle="km-imissive"  key="button.next" /></li>
				</ul>
			</div>
			<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm" />
				<c:param name="fdKey" value="sendMainDoc" />
				<c:param name="viewName" value="lbpmView" />
				<c:param name="backTo" value="scrollView" />
				<c:param name="onClickSubmitButton" value="review_submit();" />
			</c:import>
			<script>
			require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
				ready(function() {
				  <c:if  test="${nodeExtAttributeMap['modifyDocNum4Draft'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'true' or nodeAdditionalMap['modifyDocNum'] == 'on'}">
				  	BarTip.tip({text: '移动设备不支持正文编号功能，建议使用电脑操作'});
				  </c:if>
				}); 
			});
			</script>
			<script type="text/javascript">
			
			require(["mui/form/ajax-form!kmImissiveReceiveMainForm"]);
			require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util",'dojo/date/locale'],
					function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,locale){
				
				ready(function() {
					var devType = device.getClientType();
					if (devType != 9 && devType != 10){
						var fdEditType = document.getElementById("fdEditType");
						fdEditType.style.display = "none";
					}
				});
				
				
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					var _wordEdit = document.getElementById("wordEdit");
					var _attEdit = document.getElementById("attEdit");
					var type=document.getElementsByName("fdNeedContent")[0];
					if(widget && widget.name=="fdEditType"){
						if(args.value == '1'){
							type.value='1';
							_wordEdit.style.display = "block";
							_attEdit.style.display = "none";
							//请求在线编辑附件的id
							req(util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addOnlineFile"), {
								handleAs : 'json',
								method : 'post',
								data : {
									fdTemplateId:"${kmImissiveReceiveMainForm.fdTemplateId}"
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
							_attEdit.style.display = "block";
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
							key :"${kmImissiveReceiveMainForm.fdTemplateId}"
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
				
				window.review_submit = function (){
					var type=document.getElementsByName("fdNeedContent")[0]; 
					if(type.value == '1'){
						var attList = registry.byId("attList_mainonline");
						if(attList && attList.filekeys.length > 0){
							attList.filekeys.splice(0,attList.filekeys.length);
						}
					}
					
					var docStatus = document.getElementsByName("docStatus")[0];
					var docNum = document.getElementsByName("fdReceiveNum")[0];
					docStatus.value="20";
						if('${nodeExtAttributeMap['modifyDocNum4Draft']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'true' ||'${nodeAdditionalMap['modifyDocNum']}' == 'on'){
							if(""==docNum.value){
							   if("${fdNoId}" != ""){
								   var docNum = document.getElementsByName("fdReceiveNum")[0];
									var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
								    var fdNoRule = document.getElementsByName("fdNoRule")[0];
								    var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
								    req(util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=generateNumByNumberId"), {
										handleAs : 'json',
										method : 'post',
										data : {
											fdNumberId:"${fdNoId}",
											fdId:"${kmImissiveReceiveMainForm.fdId}"
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
										Com_Submit(document.forms[0],'saveReceive');
									}));
							   }else{
								  confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
							   }
						   }else{
							   req(util.formatUrl("/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkUniqueNum"), {
									handleAs : 'json',
									method : 'post',
									data : {
										fdNo:docNum.value,
										fdId:"${kmImissiveReceiveMainForm.fdId}",
										fdTempId:"${kmImissiveReceiveMainForm.fdTemplateId}"
									}
								}).then(lang.hitch(this, function(results) {
								if (results){
							    	 if(results['unique'] =='false'){
							    		 Tip.tip({icon:'mui mui-warn', text:'<bean:message key="kmImissiveSendMain.message.error.fdDocNum.repeat" bundle="km-imissive" />',width:'260',height:'60'});
							    	 }
								}
							}));
						 }
					  }else{
						  Com_Submit(document.forms[0],'saveReceive');
					  }
				}
			});
			</script>
		</html:form>
	</template:replace>
</template:include>
