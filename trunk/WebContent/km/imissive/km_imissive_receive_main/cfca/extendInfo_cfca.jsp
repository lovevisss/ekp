<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content">
<script type="text/javascript">
	Com_IncludeFile("jquery.js|xform.js");

	function dialogSelect(mul, idField, nameField,targetWin){
		seajs.use(['lui/jquery','lui/dialog','lui/dialog_common','lui/util/str'], function($, dialog, dialogCommon,strutil){
			var url = "/km/signature/km_signature_main/KmSignatureMainData.do?method=relativelist";
			targetWin = targetWin||window.top;
			targetWin['__dialog_' + idField + '_dataSource'] = function(){
                return strutil.variableResolver(url ,null);
            }
			dialogCommon.dialogSelect("com.landray.kmss.km.signature.model.KmSignatureMain",
					mul,url, null, idField, nameField,null,function(data){
				for ( var q in data) {
					$("input[name='fdSigner']").val(data[q].fdMarkName);
					$("input[name='fdSignatureId']").val(data[q].fdId);
					$("input[name='fdSignatureName']").val(data[q].fdMarkName);
					$("input[name='signKey']").val("receive");
				}
			});
		});
	}
</script>
<style>
.change-div-class {
	display:none;
}
</style>
<center>
<html:form action="/km/imissive/km_imissive_out_sign/kmImissiveOutSign.do">
<html:hidden property="fdId" />
<div align="left">&nbsp;&nbsp;<font size="5">|&nbsp;签署模式CFCA</font></div>
<br/>
<div align="left">&nbsp;&nbsp;<font size="5">|&nbsp;签章信息</font></div>
<br/>
<!-- 当前人信息 -->
<div align="left">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<font size="3">签章名称：</font>
	<xform:text property="fdSigner" showStatus="readOnly" required="true" value="" style="width:5%"/>
	<input type="hidden" name="fdMainId" value="${kmImissiveReceiveMain.fdId}"/>
	<input type="hidden" name="fdSignatureId" />
	<input type="hidden" name="fdSignatureName" />
	<input type="hidden" name="signKey" />
	&nbsp;&nbsp;&nbsp;&nbsp;
	<xform:dialog propertyId="accountId" propertyName="accountName"  showStatus="edit" style="width:15%;" nameValue="选择签署信息">
	    dialogSelect(false,'accountId','accountNames');
	</xform:dialog>
</div>
 


<div style="padding-top:17px">
<kmss:auth requestURL="/km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=sign">
						<ui:button text="确定签署" onclick="Com_Submit(document.kmImissiveOutSignForm, 'sign');"></ui:button>
					</kmss:auth>
</div>
</html:form>
</center>
</template:replace>
</template:include>