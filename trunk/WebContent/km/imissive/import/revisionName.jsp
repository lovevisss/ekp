<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<script language="JavaScript">
	seajs.use(['theme!form']);
	seajs.use(['lui/jquery'],function($){
		$(document).ready(function(){
			var defaultName = "${JsParam.defaultName}";
			if(defaultName && defaultName != ""){
				defaultName = defaultName.replace(/&#039;/g, "'").replace(/&#034;/g, "\"");
				document.getElementsByName("fdName")[0].value = defaultName;
			}
		});
	});
	function optSubmit(){
		var fdName = document.getElementsByName("fdName")[0].value;
		$dialog.hide(fdName);
		return true;	
	}
	</script>
	<center>
		<div>
			<table class="tb_normal" width=95% style="margin-top:25px">
				<tr>
					<td>
					 <xform:textarea property="fdName" style="width:99%" showStatus="edit"  />
					</td>
				</tr>
			</table>
			<br/>
			<span>
			    <ui:button id="ok_id" text="${lfn:message('button.ok') }" order="2"  onclick="optSubmit();">
				</ui:button>&nbsp;&nbsp;
				<ui:button text="${lfn:message('button.cancel') }" order="2"  onclick="$dialog.hide('cancel');">
				</ui:button>
			</span>
		</div>
	</center>
	</template:replace>
</template:include>
