<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<c:if test="${kmImissiveTemplateCfgForm.method_GET=='edit'}">
		    <ui:button text="${ lfn:message('button.submit') }" order="2" onclick="submitMethod('update');">
		    </ui:button>
		</c:if>
		<c:if test="${kmImissiveTemplateCfgForm.method_GET=='add'||kmImissiveTemplateCfgForm.method_GET=='clone'}">
	  	    <ui:button text="${ lfn:message('button.submit') }" order="1" onclick="submitMethod('save');">
		    </ui:button>
		    <ui:button text="${ lfn:message('button.saveadd') }" order="2" onclick="submitMethod('saveadd');">
		    </ui:button>
		</c:if>
		 <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		 </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script language="JavaScript">

//校验目标和来源是否为空
function validateFrom(){
	if(document.getElementsByName("fdSendTempListOneIds")[0].value==""&&document.getElementsByName("fdReceiveTempListOneIds")[0].value==""){
         return false;
	}else{
		 return true;
	}
}
function validateTo(){
	if(document.getElementsByName("fdReceiveTempListTwoIds")[0].value==""&&document.getElementsByName("fdSendTempListTwoIds")[0].value==""){
         return false;
	}else{
		 return true;
	}
}

function submitMethod(method){
	var formObj = document.kmImissiveTemplateCfgForm;
	if(method!="update"){
		var fdCfgType,fdOneId,fdTwoId;
		var fdType = document.getElementsByName("fdType");
		for(var i=0;i<fdType.length;i++){
			if(fdType[i].checked){
				fdCfgType=fdType[i].value;
				if(fdType[i].value=='SR'){
					fdOneId = document.getElementsByName("fdSendTempListOneIds")[0].value;
					fdTwoId = document.getElementsByName("fdReceiveTempListTwoIds")[0].value;
				}
				if(fdType[i].value=='RS'){
					fdOneId = document.getElementsByName("fdReceiveTempListOneIds")[0].value;
					fdTwoId = document.getElementsByName("fdSendTempListTwoIds")[0].value;
				}
				if(fdType[i].value=='RR'){
					fdOneId = document.getElementsByName("fdReceiveTempListOneIds")[0].value;
					fdTwoId = document.getElementsByName("fdReceiveTempListTwoIds")[0].value;
				}
		    }
		}
		 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do?method=checkUnique"; 
		 $.ajax({     
		     type:"post",     
		     url:url,     
		     data:{fdOneId:fdOneId,fdTwoId:fdTwoId,fdCfgType:fdCfgType},    
		     async:false,    //用同步方式 
		     success:function(data){
		 	    var results =  eval("("+data+")");
			    if(results['repeat'] =='true'){
			    	alert("该交换配置已存在");
			    	return;
				}else{
					var formObj = document.kmImissiveTemplateCfgForm;
			    	Com_Submit(formObj, method);
				}
			}    
	    });
	}else{
		Com_Submit(formObj, method);
	}	
}

function selcetSendOne(){
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		dialog.category('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','fdSendTempListOneIds','fdSendTempListOneNames',true,null,'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.select.sendTemplate"/>');
    });
}
function selcetSendTwo(){
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		dialog.category('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','fdSendTempListTwoIds','fdSendTempListTwoNames',true,null,'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.select.sendTemplate"/>');
    });
}
function selcetReceiveOne(){
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		dialog.category('com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate','fdReceiveTempListOneIds','fdReceiveTempListOneNames',true,null,'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.select.ReceiveTemplate"/>');
    });
}
function selcetReceiveTwo(){
	seajs.use(['sys/ui/js/dialog'], function(dialog) {
		dialog.category('com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate','fdReceiveTempListTwoIds','fdReceiveTempListTwoNames',true,null,'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.select.ReceiveTemplate"/>');
    });
}
function changeType(value){
	//移除校验
	 document.getElementById("s1").setAttribute("validate", "");
	 document.getElementById("s2").setAttribute("validate", "");
	 document.getElementById("r1").setAttribute("validate", "");
	 document.getElementById("r2").setAttribute("validate", "");
	 $("#s1").parent().parent().unbind("click"); //移除click
	 $("#s2").parent().parent().unbind("click"); //移除click
	 $("#r1").parent().parent().unbind("click"); //移除click
	 $("#r2").parent().parent().unbind("click"); //移除click
	 $("#send1").hide();
	 $("#receive1").hide();
	 $("#send2").hide();
	 $("#receive2").hide();
	 //切换转换类型时，清空值
	document.getElementsByName("fdSendTempListOneIds")[0].value = "";
	document.getElementsByName("fdSendTempListOneNames")[0].value="";
	document.getElementsByName("fdSendTempListTwoIds")[0].value = "";
	document.getElementsByName("fdSendTempListTwoNames")[0].value="";
	document.getElementsByName("fdReceiveTempListOneIds")[0].value = "";
	document.getElementsByName("fdReceiveTempListOneNames")[0].value="";
	document.getElementsByName("fdReceiveTempListTwoIds")[0].value = "";
	document.getElementsByName("fdReceiveTempListTwoNames")[0].value="";
	if(value == "SR"){
		$("#send1").show();
		$("#receive2").show();
		document.getElementById("s1").setAttribute("validate", "required");
		document.getElementById("r2").setAttribute("validate", "required");
	  $("#s1").parent().parent().click(function(){
			selcetSendOne();
      });
	  $("#r2").parent().parent().click(function(){
		  selcetReceiveTwo();
      });
	}
	if(value == "RS"){
		$("#send2").show();
		$("#receive1").show();
		document.getElementById("r1").setAttribute("validate", "required");
		document.getElementById("s2").setAttribute("validate", "required");
	  $("#r1").parent().parent().click(function(){
		 selcetReceiveOne();
      });
	  $("#s2").parent().parent().click(function(){
		  selcetSendTwo();
      });
	}
	if(value == "RR"){
		$("#receive2").show();
		$("#receive1").show();
		document.getElementById("r1").setAttribute("validate", "required");
		document.getElementById("r2").setAttribute("validate", "required");
	  $("#r1").parent().parent().click(function(){
			 selcetReceiveOne();
	   });
	  $("#r2").parent().parent().click(function(){
			 selcetReceiveTwo();
	  });
	}
	if(value == "SS"){
		$("#send1").show();
		$("#send2").show();
		document.getElementById("s1").setAttribute("validate", "required");
		document.getElementById("s2").setAttribute("validate", "required");
      $("#s1").parent().parent().click(function(){
			  selcetSendOne();
	   });
      $("#s2").parent().parent().click(function(){
			  selcetSendTwo();
	  });
	}
}
//编辑的时候初始化
function intType(value){
	 document.getElementById("s1").setAttribute("validate", "");
	 document.getElementById("s2").setAttribute("validate", "");
	 document.getElementById("r1").setAttribute("validate", "");
	 document.getElementById("r2").setAttribute("validate", "");
	 $("#s1").parent().parent().unbind("click"); //移除click
	 $("#s2").parent().parent().unbind("click"); //移除click
	 $("#r1").parent().parent().unbind("click"); //移除click
	 $("#r2").parent().parent().unbind("click"); //移除click
	 $("#send1").hide();
	 $("#receive1").hide();
	 $("#send2").hide();
	 $("#receive2").hide();
	if(value == "SR"){
		document.getElementsByName("fdSendTempListTwoIds")[0].value = "";
		document.getElementsByName("fdSendTempListTwoNames")[0].value="";
		document.getElementsByName("fdReceiveTempListOneIds")[0].value = "";
		document.getElementsByName("fdReceiveTempListOneNames")[0].value="";
		$("#send1").show();
		$("#receive2").show();
		document.getElementById("s1").setAttribute("validate", "required");
		document.getElementById("r2").setAttribute("validate", "required");
	  $("#s1").parent().parent().click(function(){
			selcetSendOne();
      });
	  $("#r2").parent().parent().click(function(){
		  selcetReceiveTwo();
    	  });
	}
	if(value == "RS"){
		document.getElementsByName("fdSendTempListOneIds")[0].value = "";
		document.getElementsByName("fdSendTempListOneNames")[0].value="";
		document.getElementsByName("fdReceiveTempListTwoIds")[0].value = "";
		document.getElementsByName("fdReceiveTempListTwoNames")[0].value="";
		$("#send2").show();
		$("#receive1").show();
		document.getElementById("r1").setAttribute("validate", "required");
		document.getElementById("s2").setAttribute("validate", "required");
	    $("#r1").parent().parent().click(function(){
		 selcetReceiveOne();
        });
	    $("#s2").parent().parent().click(function(){
		  selcetSendTwo();
        });
	}
	if(value == "RR"){
		document.getElementsByName("fdSendTempListOneIds")[0].value = "";
		document.getElementsByName("fdSendTempListOneNames")[0].value="";
		document.getElementsByName("fdSendTempListTwoIds")[0].value = "";
		document.getElementsByName("fdSendTempListTwoNames")[0].value="";
		$("#receive2").show();
		$("#receive1").show();
		document.getElementById("r1").setAttribute("validate", "required");
		document.getElementById("r2").setAttribute("validate", "required");
	    $("#r1").parent().parent().click(function(){
			 selcetReceiveOne();
	    });
	    $("#r2").parent().parent().click(function(){
			 selcetReceiveTwo();
	    });
	}
	if(value == "SS"){
		document.getElementsByName("fdReceiveTempListOneIds")[0].value = "";
		document.getElementsByName("fdReceiveTempListOneNames")[0].value="";
		document.getElementsByName("fdReceiveTempListTwoIds")[0].value = "";
		document.getElementsByName("fdReceiveTempListTwoNames")[0].value="";
		$("#send1").show();
		$("#send2").show();
		document.getElementById("s1").setAttribute("validate", "required");
		document.getElementById("s2").setAttribute("validate", "required");
	    $("#s1").parent().parent().click(function(){
			  selcetSendOne();
	    });
	    $("#s2").parent().parent().click(function(){
			  selcetSendTwo();
	   });
	}
}
$(document).ready(function(){
	if("${kmImissiveTemplateCfgForm.method_GET}"=='add'){
		if("${kmImissiveTemplateCfgForm.fdType}" !=""){
			intType("${kmImissiveTemplateCfgForm.fdType}");
		}else{
			changeType("SR");
		}
	}
	if("${kmImissiveTemplateCfgForm.method_GET}"=='edit'||"${kmImissiveTemplateCfgForm.method_GET}"=='clone'){
		intType("${kmImissiveTemplateCfgForm.fdType}");
	}
});
</script>
<html:form action="/km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do">
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissive.nav.Exchange"/></p>

<center>
<table class="tb_normal" width=100%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdName"/>
		</td><td width=85% colspan=3>
			<xform:text property="fdName" style="width:95%" required="true" showStatus="edit"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdTableHead"/>
		</td><td width=85% colspan=3>
			<xform:text property="fdTableHead" style="width:95%" showStatus="edit"/>
			<br>
			    <bean:message bundle="km-imissive" key="kmImissive.config.message"/>
				<FONT color="red"><bean:message bundle="km-imissive" key="kmImissive.config.message1"/></FONT>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdType"/>
		</td><td width=85% colspan=3>
			<xform:radio property="fdType" onValueChange="changeType(this.value);" value="${kmImissiveTemplateCfgForm.fdType}" showStatus="edit">
			   <xform:enumsDataSource enumsType="kmImissiveTemplateCfg_type"></xform:enumsDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.from"/>
		</td><td width=35%>
		   <div id="send1" style="display:none">
				<xform:dialog htmlElementProperties="id='s1'" mulSelect="true" required="true" idValue="${kmImissiveTemplateCfgForm.fdSendTempListOneIds}" nameValue="${kmImissiveTemplateCfgForm.fdSendTempListOneNames}" propertyId="fdSendTempListOneIds" propertyName="fdSendTempListOneNames" style="width:95%"  textarea="true" subject="${ lfn:message('km-imissive:kmImissiveTemplateCfg.from')}" showStatus="edit">
			    </xform:dialog>
		   </div>
		    <div id="receive1" style="display:none">
			   <xform:dialog htmlElementProperties="id='r1'" mulSelect="true" required="true" idValue="${kmImissiveTemplateCfgForm.fdReceiveTempListOneIds}" nameValue="${kmImissiveTemplateCfgForm.fdReceiveTempListOneNames}" propertyId="fdReceiveTempListOneIds" propertyName="fdReceiveTempListOneNames" style="width:95%" textarea="true"  subject="${ lfn:message('km-imissive:kmImissiveTemplateCfg.from')}" showStatus="edit">
			   </xform:dialog>
		   </div>
		</td>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.to"/>
		</td><td width=35%>
		    <div id="send2" style="display:none">
		    <xform:dialog htmlElementProperties="id='s2'" mulSelect="true" required="true" idValue="${kmImissiveTemplateCfgForm.fdSendTempListTwoIds}" nameValue="${kmImissiveTemplateCfgForm.fdSendTempListTwoNames}"  propertyId="fdSendTempListTwoIds" propertyName="fdSendTempListTwoNames" style="width:95%"  textarea="true"  subject="${ lfn:message('km-imissive:kmImissiveTemplateCfg.to')}" showStatus="edit"> 
		    </xform:dialog>
		    </div>
		    <div id="receive2" style="display:none">
		    <xform:dialog htmlElementProperties="id='r2'" mulSelect="true" required="true" idValue="${kmImissiveTemplateCfgForm.fdReceiveTempListTwoIds}" nameValue="${kmImissiveTemplateCfgForm.fdReceiveTempListTwoNames}"  propertyId="fdReceiveTempListTwoIds" propertyName="fdReceiveTempListTwoNames" style="width:95%"  textarea="true" subject="${ lfn:message('km-imissive:kmImissiveTemplateCfg.to')}" showStatus="edit">
		    </xform:dialog>
		    </div>
		</td>
	</tr>
	<tr>
			<td class="td_normal_title" width=15%><bean:message
				key="model.tempEditorName" /></td>
			<td colspan="3">
			 <xform:address propertyName="authEditorNames" propertyId="authEditorIds" textarea="true" mulSelect="true" style="width:95%">
			 </xform:address>
			<div class="description_txt">
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.authEditors.desc" />
			</div>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				key="model.tempReaderName" /></td>
			<td colspan="3">
			<div id="Cate_AllUserId">
			 <xform:address propertyName="authReaderNames" propertyId="authReaderIds" textarea="true" mulSelect="true" style="width:95%">
			 </xform:address>
			</div>
			<div id="Cate_AllUserNote">
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.authReaders.desc" />
			</div>
			</td>
		</tr>
	
</table>
</center>
<html:hidden property="method_GET"/>
<script language="JavaScript">
      var _validation = $KMSSValidation(document.forms['kmImissiveTemplateCfgForm']);
		//校验来源不为空
		_validation.addValidator("fromNotNull",'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.from.notNull" />',function(v, e, o) {
			return validateFrom();
		});
		//校验目标不为空
		_validation.addValidator("toNotNull",'<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.to.notNull" />',function(v, e, o) {
			return validateTo();
		});
</script>
</html:form>
</template:replace>
</template:include>