<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<c:if test="${kmImissiveRuleForm.method_GET=='edit'}">
		 <ui:button text="${ lfn:message('button.update') }" order="2" onclick="Com_Submit(document.kmImissiveRuleForm, 'update');">
		 </ui:button>
		</c:if>
		<c:if test="${kmImissiveRuleForm.method_GET=='add'}">
			<ui:button text="${ lfn:message('button.submit') }" order="1" onclick="Com_Submit(document.kmImissiveRuleForm, 'save');">
		    </ui:button>
		    <ui:button text="${ lfn:message('button.saveadd') }" order="2" onclick="Com_Submit(document.kmImissiveRuleForm, 'saveadd');">
		    </ui:button>
		</c:if>
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		 </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<html:form action="/km/imissive/km_imissive_rule/kmImissiveRule.do">

<p class="txttitle">权限设置</p>

<center>

<script language="JavaScript">
seajs.use([
    'km/imeeting/resource/js/dateUtil',
    'km/imeeting/resource/js/arrayUtil',
    'lui/jquery',
    'lui/dialog',
    'lui/topic',
    'lui/util/env'],function(dateUtil,arrayUtil,$,dialog,topic,env){
	
	$(document).ready(function () {
		var addition = $('input[name="fdAdditionRule"]').val();
		if(addition!=""){
			addition=JSON.parse(addition);
			var additionText='';
			$(addition).each(function(i){
	           if (i != 0) {
	        	   additionText += ";" + this.val;
				} else {
					additionText +=this.val;
				}
			});
			$('input[name="additionNames"]').val(additionText);
		}
		
	});
	function selectEquipment(){
		var fdNodeRule = $('input[name="fdNodeRule"]').val();
		var url="/km/imissive/km_imissive_rule/kmImissiveRule_basic.jsp";
		dialog.iframe(url,'节点权限',function(data){
			if(data){
				$('input[name="fdNodeRule"]').val(data.basicRuleStr);
				$('input[name="fdNodeRuleText"]').val(data.basicRuleText);
			}
		},{width:500,height:420,params:{"fdNodeRule":fdNodeRule}});
	};
	function selectAddition(){
		var modelName = "";
		var imissiveType =  $('input:radio[name="fdImissiveType"]:checked').val();
		if(imissiveType=="0"){
			modelName = "com.landray.kmss.km.imissive.model.KmImissiveSendMain";
		}else if(imissiveType =="1"){
			modelName = "com.landray.kmss.km.imissive.model.KmImissiveReceiveMain";
		}else if(imissiveType =="2"){
			modelName = "com.landray.kmss.km.imissive.model.KmImissiveSignMain";
		}
		var url="/km/imissive/km_imissive_rule/kmImissiveRule_addition.jsp?nodeType=reviewNode&modelName="+modelName;
		var addition = $('input[name="fdAdditionRule"]').val();
		dialog.iframe(url,'附加权限',function(additionStr){
			if(additionStr){
				$('input[name="fdAdditionRule"]').val(additionStr);
				additionStr=JSON.parse(additionStr);
				var additionText='';
				$(additionStr).each(function(i){
		           if (i != 0) {
		        	   additionText += ";" + this.val;
					} else {
						additionText +=this.val;
					}
				});
				
				$('input[name="fdAdditionRuleText"]').val(additionText);
				
				
			}
		},{width:500,height:420,params:{"addition":addition}});
	};
	
	$("input[name='fdImissiveType']").change(function(){
		//执行事件
		$('input[name="fdAdditionRule"]').val("");
		$('input[name="fdAdditionRuleText"]').val("");
	});
	
	window.selectEquipment = selectEquipment;
	window.selectAddition = selectAddition;
	
	Com_Parameter.event["submit"].push(function(){
		var jobsElementIds = $('input[name="jobsElementIds"]').val();
		if(jobsElementIds)
			$('input[name="authReaders"]').val("1");
		else
			$('input[name="authReaders"]').val("0");
		return true;
	});
});
</script>
<table class="tb_normal" width=100%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			权限名称
		</td><td width=35% colspan="3">
			<xform:text property="docSubject" required="true" style="width:85%"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveType.fdOrder"/>
		</td><td width=35%>
			<xform:text property="fdOrder" style="width:85%" validators="digits"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			公文类型
		</td><td width=35%>
			<sunbor:enums property="fdImissiveType" enumsType="kmImissive_rule" elementType="radio" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			节点权限
			
		</td><td width=35%>
				<input name="fdNodeRule" type="hidden" value='${kmImissiveRuleForm.fdNodeRule}'/>	
				<input name="fdNodeRuleText" type="hidden" value='${kmImissiveRuleForm.fdNodeRuleText}'/>	
				<xform:dialog propertyId="fdNodeRuleTextIds" propertyName="fdNodeRuleText" showStatus="edit" 
					 				className="inputsgl" style="width:98%;float:left">
							  	 	selectEquipment();
								</xform:dialog>

		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			附加权限
		</td><td width=35%>
		<input name="fdAdditionRuleText" type="hidden" value='${kmImissiveRuleForm.fdAdditionRuleText}'/>	
		<input name="authReaders" type="hidden" value='${kmImissiveRuleForm.authReaders}'/>	
		<input name="fdAdditionRule" type="hidden" value='${kmImissiveRuleForm.fdAdditionRule}'/>	
			<xform:dialog propertyId="fdAdditionRuleTextIds" propertyName="fdAdditionRuleText" showStatus="edit" 
					 				className="inputsgl" style="width:98%;float:left">
							  	 	selectAddition();
								</xform:dialog>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveType.fdIsAvailable"/>
		</td><td width=35%>
			<sunbor:enums property="fdIsAvailable" enumsType="common_yesno" elementType="radio" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			可使用者
		</td><td width=35%>
			<xform:address  style="width:96%;" textarea="true" showStatus="edit"  propertyId="jobsElementIds" propertyName="jobsElementNames" 
									orgType="ORG_TYPE_ALL" mulSelect="true" validators="validateattend"
									subject="可使用者">
						</xform:address>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
<script language="JavaScript">
      $KMSSValidation(document.forms['kmImissiveRuleForm']);
</script>
</html:form>
</template:replace>
</template:include>