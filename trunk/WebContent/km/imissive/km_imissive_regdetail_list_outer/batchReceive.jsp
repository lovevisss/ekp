<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<script language="JavaScript">
		seajs.use(['theme!form']);
		Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
	</script>
		<div>
			<center>
				<table class="tb_normal numberTb" width=95% style="margin-top:25px">
				   <tr>
					    <td>时间</td>
						<td>
							<xform:datetime property="fdTime"  showStatus="edit"></xform:datetime>
						</td>
					</tr>
				</table>
			</center>
			<center>
				<div style="margin-top: 25px;z-index: 100">
				    <ui:button id="ok_id" text="${lfn:message('button.ok') }" order="2"  onclick="optSubmit();">
					</ui:button>&nbsp;&nbsp;
					<ui:button text="${lfn:message('button.cancel') }" order="2"  onclick="$dialog.hide('cancel');">
					</ui:button>
				</div> 
			</center>
		</div>
	<script language="JavaScript">
		function optSubmit(){
			var fdTime = document.getElementsByName("fdTime")[0];
			$dialog.hide(fdTime.value);
		}
	</script>
	</template:replace>
</template:include>
