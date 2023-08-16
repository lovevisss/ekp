<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissive.yqqSignzq') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_send_dr/kmImissiveSendDR.do">
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel" class="editPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'签署',icon:'mui-ul'">
						<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
							<tr>
							    <td class="muiTitle">
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.contactWay"/>
								</td>
							    <td>
						    		<xform:text property="phone" showStatus="edit" mobile="true" required="true" value="${phone}" />
								</td>
							</tr>
							<tr>
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.signPattern"/>
								</td>
							    <td>
						    		 <xform:select property="fdType" mobile="true" onValueChange="changeValue();" required="true"  htmlElementProperties="id=_fdNeedEnterprise" showStatus="edit" style="width:200px">
						    			<xform:enumsDataSource enumsType="kmImissive_yqq" />
						    		 </xform:select>
								</td>
							</tr>
							<tr>
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.name"/>
								</td>
							    <td>
						    		<xform:text property="fdSigner" mobile="true" showStatus="view" value="${fdSigner.fdName}"/>
								</td>
							</tr>
							<tr id='_fdEnterprise' style="display:none;">
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.enterrisename"/>
								</td>
							    <td>
									<xform:text property="fdEnterprise" showStatus="edit" mobile="true" required="true" style="width:20%"/><span class="txtstrong">(企业名称必须跟营业执照上的名称一致)</span>
								</td>
							</tr>
							<tr>
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.information"/>
								</td>
							    <td>
									<span class="fdSchemeSelectBtn" id="selectSchemeButton"  onclick="selectYqqMsg();">
										<span id="fdEnterprise" class="muiImeetingSIFont">
										</span>
										<span class="fontmuis muis-to-right"></span>
									</span>
								</td>
							</tr>
							<tr>
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissive.yqq.signFile"/>
								</td>
							    <td>
							    	<script type="text/javascript">
							    	</script>
									<c:if test="${kmImissiveSendMain.fdNeedContent eq '1'}">
										<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										   	<c:param name="fdKey" value="editonline" />
										   	<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
											<c:param name="fdModelId" value="${kmImissiveSendMain.fdId}" />
											<c:param name="formName" value="kmImissiveSendMainForm"/>
										</c:import>	
									</c:if>
									<c:if test="${kmImissiveSendMain.fdNeedContent eq '0'}">
										<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										   	<c:param name="fdKey" value="mainonline" />
										   	<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
											<c:param name="fdModelId" value="${kmImissiveSendMain.fdId}" />
											<c:param name="formName" value="kmImissiveSendMainForm"/>
										</c:import>	
									</c:if>
								</td>
							</tr>
							
						</table>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<li data-dojo-type="mui/tabbar/TabBarButton" onclick="sendYqq()">确认签署</li>
				</ul>
			</div>
			<%@include file="/km/imissive/mobile/DRScript.jsp"%> 
			<script type="text/javascript">
			require(["mui/form/ajax-form!kmImissiveSendDRForm"]);
			require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util",'dojo/date/locale','mui/commondialog/DialogSelector'],
				function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,locale,DialogSelector){
				window.selectYqqMsg = function() {
					var fdType=query("input[name='fdType']").val();
					if (fdType==''||fdType==null) {
						Tip.tip({icon:'mui mui-warn', text:'请选择签署模式',width:'260',height:'60'});
						return;
					}
					var fdNeedEnterprise=registry.byId("_fdNeedEnterprise");
					var url = '/elec/yqqs/elec_yqqs_acc_info/elecYqqsAccInfo.do?method=accoutList&moduleSource=km-ImissiveSend&fdUserName=${fdSigner.fdName}';
					if (fdNeedEnterprise.value == "1") {
						url += "&fdType=0";//企业签署
					}else{
						url += "&fdType=1";//个人签署
					}
		    			DialogSelector.select({
		    				key : '____imissiveYqqSendPs',
		    				dataURL : url,
		    				modelName:'com.landray.kmss.elec.yqqs.model.ElecYqqsAccInfo',
		    				callback : function(evt){
		    						query("[name='fdEnterprise']").val(evt.data[0].curNames);
		    						query("[name='phone']").val(evt.data[0].fdPhone);
		    						query("[name='fdSigner']").val(evt.data[0].fdUserName);
		    						var fdNeedEnterprise=registry.byId("_fdNeedEnterprise");
		    						if (fdNeedEnterprise.value == "1") {
		    							query("[name='fdEnterprise']").val(evt.data[0].fdName);
		    						}
		    			}
		    			})
		    		};
	    		window.changeValue = function(){
					var fdNeedEnterprise=registry.byId("_fdNeedEnterprise");
					if(fdNeedEnterprise.value== "1"){
						$('#_fdEnterprise').show();
					}else{
						$('#_fdEnterprise').hide();
					}
				};
				
				window.sendYqq = function(){
					var phone=query("input[name='phone'][type='text']").val();
					var fdType=query("input[name='fdType']").val();
					var fdEnterprise=query("input[name='fdEnterprise']").val();
					var checkboxVal = query('#fdNeedEnterprise').val();
					if (fdType==''||fdType==null) {
						Tip.tip({icon:'mui mui-warn', text:'请选择签署模式',width:'260',height:'60'});
						return;
					}
					if(phone==''||phone==null){
						Tip.tip({icon:'mui mui-warn', text:'请输入手机号',width:'260',height:'60'});
						return;
					}else{
						if(!(/^(13[0-9]|14[5679]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[01256789])\d{8}$/.test(phone))){
							Tip.tip({icon:'mui mui-warn', text:'请输入正确的手机号',width:'260',height:'60'});
							return;
						}
						var ajaxUrl = Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=sendYqq&signId=${param.signId}&phone='+phone;
						var fdNeedEnterprise=registry.byId("_fdNeedEnterprise");
						if(fdNeedEnterprise.value == '1'){
							if(fdEnterprise =='' || fdEnterprise==null){
								Tip.tip({icon:'mui mui-warn', text:'请输入企业名称',width:'260',height:'60'});
								return;
							}else{
								ajaxUrl += '&fdEnterprise='+fdEnterprise;
							}
						}
						var processing = Tip.processing();
						var promise = req.post(ajaxUrl);
						promise.response.then(function(data) {
							processing.hide();
							if(data){
								var json=JSON.parse(data.data);
								var yqqSendCode=json['sendStatus'];
								var signId=json['signId'];
								if("true"==yqqSendCode){
									var url=Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/yqq/yqq_loading.jsp?signId='+signId;
									window.location.href=url;
								}else{
									Tip.tip({icon:'mui mui-warn', text:'发送签署失败，请确认发送方是否已经在易企签平台注册。',width:'260',height:'60'});
								}
							}
						});
					}
				};
				
			});	
			
		</script>	
		</html:form>
	</template:replace>
</template:include>
