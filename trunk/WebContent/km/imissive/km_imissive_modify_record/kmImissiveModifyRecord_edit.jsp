<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<script>
	seajs.use(['theme!form']);
	Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
	</script>
	<html:form action="/km/imissive/km_imissive_modify_record/kmImissiveModifyRecord.do">
	<p class="txttitle"><bean:message bundle="km-imissive" key="table.kmImissiveModifyRecord"/></p>
	<center>
	<div id="div_condtionSection">
	<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
		<html:hidden property="fdType"/>
		<html:hidden property="fdImissiveId"/>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="km-imissive" key="kmImissiveModifyRecord.docCreator"/>
			</td>
			<td width=35%>
				<c:out value="${kmImissiveModifyRecordForm.docCreatorName}"></c:out>
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="km-imissive" key="kmImissiveModifyRecord.docCreateTime"/>
			</td>
			<td width=35%>
				<c:out value="${kmImissiveModifyRecordForm.docCreateTime}"></c:out>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="km-imissive" key="kmImissiveModifyRecord.docContent"/>
			</td>
			<td width=85% colspan="3">
				<xform:textarea property="docContent" style="width:95%" required="true" subject="${lfn:message('km-imissive:kmImissiveModifyRecord.docContent') }"></xform:textarea>
			</td>
		</tr>
	</table>
	</div>
	<div style="padding-top:17px">
		   <ui:button text="${ lfn:message('button.submit') }"  onclick=" SubmitForm();">
		   </ui:button>
	 </div>
	</center>
	<html:hidden property="method_GET"/>
	</html:form>
	<script language="JavaScript">
		var validation = $KMSSValidation(document.forms['kmImissiveModifyRecordForm']);
		
		function SubmitForm(){
			if(validation.validate()){
				var url=Com_Parameter.ContextPath+"km/imissive/km_imissive_modify_record/kmImissiveModifyRecord.do?method=save";
				$.post(url, $.param(getFormData(), true), function(data) {
					// results =  eval("("+data+")");
			    	    $dialog.hide(data);
				}, 'json');
			}
		}
		
		function getFormData(){
 			var data = {};
			$("#div_condtionSection").find(":input").each( function() {
				var thisObj = $(this);
				var name = thisObj.attr("name");
				if (name != null && name != '') {
					if (thisObj.is(":radio")) {
						if (thisObj.is(":checked")) {
							data[name] = thisObj.val();
						}
					} else if (thisObj.is(":checkbox")) {
						if (thisObj.is(":checked")) {
							var oldVal = data[name];
							if (oldVal == null) {
								data[name] = thisObj.val();
							} else {
								data[name] = oldVal + ";" + thisObj.val();
							}
						}
					} else {
						data[name] = thisObj.val();
					}
				}
			});
			return data;
 		}
	</script>
	</template:replace>
</template:include>