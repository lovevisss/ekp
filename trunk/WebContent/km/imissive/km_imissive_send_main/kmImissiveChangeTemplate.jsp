<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="auto">
<template:replace name="body"> 
<script>
	seajs.use(['theme!form']);
	Com_IncludeFile("jquery.js");
</script>
<script language="JavaScript">
	$(document).ready(function(){ 
		var value = opener.values;
		document.getElementsByName("values")[0].value = value;
	});
	function save() {
		var tName = document.getElementsByName("fdTemplateName");
		if(tName[0].value=="") {
			alert("<bean:message key="message.no.template" bundle="km-imissive"/>");
			return false;
		}
		Com_Submit(document.kmImissiveSendMainForm, 'changeTemplate');
	}
  function selectTemplate(){
		seajs.use(['sys/ui/js/dialog'], function(dialog) {
			dialog.category({
				modelName:"com.landray.kmss.km.imissive.model.KmImissiveSendTemplate",
				idField:"fdTemplateId",
				nameField:"fdTemplateName",
				mulSelect:false,
				winTitle:"选择模板",
				canClose:true,
				isShowTemp:true,
				authType:"01",
				notNull:true
			});
			//dialog.category('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','fdTemplateId','fdTemplateName',false,null,"选择模板");
	   });
  }
</script>
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
	<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissive.title.trans" /></p>
	<center>
	<table class="tb_normal" width=90%>
	   <input type="hidden" name ="values"/>
		<tr>
			<td class="td_normal_title" width=30%>
			   模板
			</td>
			<td>
			<xform:dialog required="true" propertyId="fdTemplateId" propertyName="fdTemplateName" showStatus="edit" style="width:95%"  className="inputsgl" subject="模板">
			   selectTemplate();
			 </xform:dialog>
			</td>
		</tr>
	</table>
	<br>
	<div>
	   <input type=button class="lui_form_button" value="<bean:message key="button.update"/>" onclick="save();">&nbsp;
	   <input type="button" class="lui_form_button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
	</div>
	</center>
	<html:hidden property="method_GET" />
</html:form>
</template:replace>
</template:include>

