<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content"> 
			<br/>
			<p class="txttitle">
				节点权限
			</p>
			<br/>
			<table class="tb_normal" width="98%">
			<input name="fdNodeRule" type="hidden"/>
				<tr>
					<td class="tdTitle">意见配置参数</td>
					<td>
						<label><input name="opinionConfig" type="checkbox" value="true">意见是否可配置</input></label>
					</td>
				</tr>
				<tr>
					<td class="tdTitle" style="word-break:break-all;">意见类型</td>
					<td>
						<xform:select property="opinionType" showStatus="edit" subject="默认意见类型" value="">
								<xform:customizeDataSource className="com.landray.kmss.sys.lbpmservice.support.service.spring.LbpmAuditNoteTypeDataSource"></xform:customizeDataSource>
						</xform:select>
					</td>
				</tr>
				<tr>
					<td class="tdTitle" style="word-break:break-all;"><kmss:message key="FlowChartObject.Lang.Node.onHandlerSame" bundle="sys-lbpmservice"/></td>
					<td>
						<select id="handlerSelect" name="handlerSameSelect">
							<option value="1" selected="selected">
								<kmss:message key="FlowChartObject.Lang.Node.onAdjoinHandlerSame" bundle="sys-lbpmservice" /></option>
							<option value="2">
								<kmss:message key="FlowChartObject.Lang.Node.onSkipHandlerSame" bundle="sys-lbpmservice" /></option>
							<option value="0">
								<kmss:message key="FlowChartObject.Lang.Node.ignoreOnHandlerSame" bundle="sys-lbpmservice" /></option>
							<option value="3">
								<kmss:message key="FlowChartObject.Lang.Node.ignoreOnFutureHandlerSame" bundle="sys-lbpmservice" /></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="tdTitle"><bean:message bundle="sys-lbpmservice" key="lbpmNode.currentNode.notify.type" /></td>
					<td id="NODE_TD_notifyType">
						<%-- <kmss:editNotifyType property="node_notifyType" value="no" /><br /> --%>
						<label>
							<input name="todo" type="checkbox" value="todo">
							待办
						</label>
						&nbsp;&nbsp;
						<label>
							<input name="email" type="checkbox" value="email">
							邮箱
						</label>
						&nbsp;&nbsp;
						<label>
							<input name="mobile" type="checkbox" value="mobile">
							短消息
						</label>
					</td>
				</tr>
				<tr>
					<td class="tdTitle"><kmss:message key="FlowChartObject.Lang.Node.popedom" bundle="sys-lbpmservice" /></td>
					<td>
						<label>
							<input name="canModifyMainDoc" type="checkbox" value="true">
							<kmss:message key="FlowChartObject.Lang.Node.canModifyMainDoc" bundle="sys-lbpmservice" />
						</label>
						&nbsp;&nbsp;
						<label>
							<input name="canAddAuditNoteAtt" type="checkbox" value="true">
							<kmss:message key="FlowChartObject.Lang.Node.canAddAuditNoteAtt" bundle="sys-lbpmservice" />
						</label>
					</td>
				</tr>
				<tr>
					<td class="tdTitle"><kmss:message key="FlowChartObject.Lang.Node.flowPopedom" bundle="sys-lbpmservice" /></td>
					<td>
						<label>
							<input name="flowPopedom" type="radio" value="0" >
							<kmss:message key="FlowChartObject.Lang.Node.flowPopedom_0" bundle="sys-lbpmservice" />
						</label><label>
							<input name="flowPopedom" type="radio" value="1">
							<kmss:message key="FlowChartObject.Lang.Node.flowPopedom_1" bundle="sys-lbpmservice" />
						</label><label id="flowPopedom_modify">
							<input name="flowPopedom" type="radio" value="2">
							<kmss:message key="FlowChartObject.Lang.Node.flowPopedom_2" bundle="sys-lbpmservice" />
						</label>
					</td>
				</tr>
				<tr>
					<%--查询按钮--%>
					<td colspan="4" style="text-align: center;">
					  	<%--选择--%>
						<ui:button id="select_resource_submit" text="${lfn:message('button.submit')}"   onclick="selectSubmit();"/>
						<%--取消--%>
						<ui:button id="select_resource_cancel" text="${lfn:message('button.cancel') }"  onclick="selectCancel();"/>
					</td>
				</tr>
			</table>
	</template:replace>
</template:include>
<script>
	seajs.use([
 	      'lui/jquery',
 	      'lui/dialog',
 	      'lui/topic',
 	      'lui/util/str'
 	        ],function($,dialog,topic,str){
		
		$(document).ready(function () {
			var timer = setInterval(function() {
				var dialogR = $dialog;
				if (!dialogR) {
					return;
				} else {
					clearInterval(timer);
				}
				var rule =$dialog.content.params.fdNodeRule;
				if(rule!=""&&rule!=undefined&&rule!=null){
					rule=JSON.parse(rule);
					$('#handlerSelect').find('option[value="'+rule.ignoreOnHandlerSame+'"]').attr('selected','selected');
					$("select[name='opinionType']").find('option[value="'+rule.opinionType+'"]').attr('selected','selected');
					if(rule.opinionConfig == 'true'){
						 if(rule.opinionConfig != null) {
						        $.each($("input[name='opinionConfig']"), function(key, value) {
						            $("input[name='opinionConfig']").attr("checked", true);
						        });
						  }
					}
					if(rule.canAddAuditNoteAtt == 'true'){
						 if(rule.canAddAuditNoteAtt != null) {
						        $.each($("input[name='canAddAuditNoteAtt']"), function(key, value) {
						            $("input[name='canAddAuditNoteAtt']").attr("checked", true);
						        });
						    }
					}
					if(rule.canModifyMainDoc == 'true'){
						 if(rule.canModifyMainDoc != null) {
						        $.each($("input[name='canModifyMainDoc']"), function(key, value) {
						            $("input[name='canModifyMainDoc']").attr("checked", true);
						        });
						    }
					}
					var notifyType = rule.notifyType;
					if(notifyType!=""){
						notifyType=notifyType.split(";");
	                    for(index in notifyType){
	                    	$("input[name="+notifyType[index]+"]").attr("checked", true);
	                    }
					}
					if(rule.flowPopedom){
						$("input:radio[value='"+rule.flowPopedom+"']").prop('checked', true);
					}
				}else{
					//如果等于空展示默认值
			        $("input[name='opinionConfig']").attr("checked", true);
			        $("input[name='todo']").attr("checked", true);
			        $("input[name='canAddAuditNoteAtt']").attr("checked", true);
			        $("input:radio[value='2']").prop('checked', true);
				}
				
				
				
			}, 100);
			
		});
		//获取checkBox值
		function getCheckBoxValueThree(name) {
            var data = $("input:checkbox[name="+name+"]:checked").map(function () {
                return $(this).val();
            }).get().join(",");
            return data
		}
		
		//获取checkBox文本
		function getCheckBoxValueText(name) {
			var checkText = $("input:checkbox[name="+name+"]:checked").parent().parent().parent();
			checkText = $(checkText).find(".tdTitle");
			if(checkText[0]){
				checkText = checkText[0].innerText;
			}
			return checkText;
		}
		
		//身份重复配置下拉选项
		function switchHandlerSameSelect(){
			var itemVal = $("#handlerSelect option:selected").val();
			return itemVal;
		}
		
		//身份重复配置下拉选项标题
		function switchSelectTitle(){
			var handlerSelect = $("#handlerSelect").parent().parent();
			handlerSelect = $(handlerSelect).find(".tdTitle");
			if(handlerSelect[0]){
				handlerSelect = handlerSelect[0].innerText;
			}
			return handlerSelect.trim();
		}
		//身份重复配置下拉选项标题
		function switchSelectText(){
			var itemVal = $("#handlerSelect option:selected").text();
			return itemVal.trim();
		}
		//提交
		window.selectSubmit=function(){
			var opinionConfig = getCheckBoxValueThree("opinionConfig");
			var canAddAuditNoteAtt = getCheckBoxValueThree("canAddAuditNoteAtt");
			var canModifyMainDoc = getCheckBoxValueThree("canModifyMainDoc");
			var todo = getCheckBoxValueThree("todo");
			var email = getCheckBoxValueThree("email");
			var mobile = getCheckBoxValueThree("mobile");
			var flowPopedom =  $('input:radio[name="flowPopedom"]:checked').val();
			var ignoreOnHandlerSame = switchHandlerSameSelect();
			var basicRule = {};
			var basicRuleText ="";
			basicRule['opinionConfig'] = opinionConfig;
			basicRule['canAddAuditNoteAtt'] = canAddAuditNoteAtt;
			basicRule['canModifyMainDoc'] = canModifyMainDoc;
			basicRule['flowPopedom'] = flowPopedom;
			basicRule['ignoreOnHandlerSame'] = ignoreOnHandlerSame;
			var notifyType = '';
			var notifyTypeText = '';
			if(todo!=""){
				notifyType = notifyType +todo +";";
				notifyTypeText = notifyTypeText +"待办,";
			}
			if(email!=""){
				notifyType = notifyType + email + ";";
				notifyTypeText = notifyTypeText +  "邮箱,";
			}
			if(mobile!=""){
				notifyType = notifyType +mobile + ";";
				notifyTypeText = notifyTypeText + "短消息,";
			}
			if(notifyType!=""){
				notifyType = notifyType.substring(0,notifyType.lastIndexOf(";"));
				notifyTypeText = notifyTypeText.substring(0,notifyTypeText.lastIndexOf(","));
			}
			basicRule['notifyType'] = notifyType;
			
			//展示
			var opinionConfigText =  getCheckBoxValueText('opinionConfig');
			var canAddAuditNoteText = getCheckBoxValueText("canAddAuditNoteAtt");
			var canModifyMainDocText = getCheckBoxValueText("canModifyMainDoc");
			
			//意见配置参数
			if(opinionConfig == "true"){
				basicRuleText += "意见配置参数:意见可配置;";
			}
			//身份重复
			var selectTitle = switchSelectTitle();
			var selectText = switchSelectText();
			basicRuleText[selectTitle] = selectText;
			basicRuleText += selectTitle+":"+selectText+";";
			
			//通知方式
			basicRuleText +="通知方式:"+notifyTypeText+";";
			
			//权限
			if(canAddAuditNoteAtt =="true" && canModifyMainDoc =="true"){
				basicRuleText += canAddAuditNoteText +":编辑主文档,审批意见中上传附件;";
			}else if(canModifyMainDoc =="true"){
				basicRuleText += canModifyMainDocText +":编辑主文档;";
			}else if(canAddAuditNoteAtt =="true"){
				basicRuleText += canAddAuditNoteText +":审批意见中上传附件;";
			}
			
			//节点权限
			if(flowPopedom =="0"){
				basicRuleText += "节点权限:无;";
			}else if(flowPopedom =="1"){
				basicRuleText += "节点权限:增加节点;";
			}else if(flowPopedom =="2"){
				basicRuleText += "节点权限:编辑流程;";
			}
			
			
			var opinionType = $("select[name='opinionType'] option:selected").val();
			var opinionTypeText = $("select[name='opinionType'] option:selected").text();
			basicRule['opinionType'] = opinionType;
			if(opinionType !=""){
				basicRuleText += "意见类型:"+opinionTypeText;
			}
			
			
			//var basicRuleTextStr = JSON.stringify(basicRuleText);
			var basicRuleStr = JSON.stringify(basicRule);
			if(window.$dialog){
				window.$dialog.hide({"basicRuleStr":basicRuleStr,"basicRuleText":basicRuleText});
			}else{//兼容旧UED
				opener._closeDialog();
				window.close();
			}
		};
		//取消
		window.selectCancel=function(){
			if(typeof($dialog)!="undefined"){
				//dialog.iframe形式
				$dialog.hide(null);
			}else{
				//兼容window.open和dialog.showModalDialog形式
				if(window.showModalDialog){
					window.returnValue=null;
				}else{
					opener.dialogCallback(null);
				}
				window.close();
			}
		};
	});
</script>