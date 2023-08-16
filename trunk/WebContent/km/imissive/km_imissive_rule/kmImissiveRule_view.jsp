<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<kmss:auth requestURL="/km/imissive/km_imissive_rule/kmImissiveRule.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			 <ui:button text="${ lfn:message('button.edit') }" order="2" onclick="Com_OpenWindow('kmImissiveRule.do?method=edit&fdId=${param.fdId}','_self');">
			 </ui:button>
		</kmss:auth>
		<kmss:auth requestURL="/km/imissive/km_imissive_rule/kmImissiveRule.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			 <ui:button text="${ lfn:message('button.delete') }" order="2" onclick="Delete();">
			 </ui:button>
		</kmss:auth>
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		 </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script>
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog=dialog;
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
});
function Delete(){
	dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
    	if(flag==true){
    		Com_OpenWindow('kmImissiveRule.do?method=delete&fdId=${param.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn");
};
</script>
<p class="txttitle"><bean:message  bundle="km-imissive" key="table.kmImissiveRule"/></p>
<center>
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
			<sunbor:enumsShow value="${kmImissiveRuleForm.fdImissiveType}" enumsType="kmImissive_rule" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			节点权限
			
		</td><td width=35%>
				<input name="fdNodeRule" type="hidden" value="${kmImissiveRuleForm.fdNodeRule}"/>	
				<xform:dialog propertyId="fdNodeRuleIds" propertyName="fdNodeRuleText" showStatus="readOnly"  
					 				className="inputsgl" style="width:98%;float:left">
							  	 	selectEquipment();
								</xform:dialog>

		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			附加权限
		</td><td width=35%>
		<input name="fdAdditionRule" type="hidden" value='${kmImissiveRuleForm.fdAdditionRule}'/>	
			<xform:dialog propertyId="additionIds" propertyName="additionNames" showStatus="readOnly"  
					 				className="inputsgl" style="width:98%;float:left">
							  	 	selectEquipment1();
								</xform:dialog>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveType.fdIsAvailable"/>
		</td><td width=35%>
			<sunbor:enumsShow value="${kmImissiveRuleForm.fdIsAvailable}" enumsType="common_yesno" />
		</td>
	</tr>
</table>
</center>
</template:replace>
</template:include>
