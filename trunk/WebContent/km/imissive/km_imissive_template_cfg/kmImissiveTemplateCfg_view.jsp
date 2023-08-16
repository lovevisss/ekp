<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<kmss:auth requestURL="/km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			 <ui:button text="${ lfn:message('button.edit') }" order="2" onclick="Com_OpenWindow('kmImissiveTemplateCfg.do?method=edit&fdId=${param.fdId}','_self');">
			 </ui:button>
		 </kmss:auth>
		 <kmss:auth requestURL="/km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do?method=clone&fdId=${param.fdId}" requestMethod="GET">
			 <ui:button text="${ lfn:message('km-imissive:button.copy') }" order="2" onclick="Com_OpenWindow('kmImissiveTemplateCfg.do?method=clone&cloneModelId=${param.fdId}','_blank');">
			 </ui:button>
	    </kmss:auth>
   		 <kmss:auth requestURL="/km/imissive/km_imissive_template_cfg/kmImissiveTemplateCfg.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
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
});
function Delete(){
	dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
    	if(flag==true){
    		Com_OpenWindow('kmImissiveTemplateCfg.do?method=delete&fdId=${param.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn");
};
	
</script>
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissive.nav.Exchange"/></p>
<center>
<table class="tb_normal" width=100%>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdName"/>
		</td><td width=35% colspan='3'>
			<c:out value="${kmImissiveTemplateCfgForm.fdName}"/> 
		</td>
	</tr>
		<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdTableHead"/>
		</td><td width=35% colspan='3'>
			<c:out value="${kmImissiveTemplateCfgForm.fdTableHead}"/> 
		</td>
	</tr>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.fdType"/>
		</td><td width=85% colspan=3>
			<xform:radio property="fdType" value="${kmImissiveTemplateCfgForm.fdType}">
			   <xform:enumsDataSource enumsType="kmImissiveTemplateCfg_type"></xform:enumsDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.from"/>
		</td><td width=35%>
		    <c:out value="${kmImissiveTemplateCfgForm.fdSendTempListOneNames}"/> 
		    <c:out value="${kmImissiveTemplateCfgForm.fdReceiveTempListOneNames}"/> 
		</td>
		<td class="td_normal_title"  width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveTemplateCfg.to"/>
		</td><td width=35%>
		    <c:out value="${kmImissiveTemplateCfgForm.fdSendTempListTwoNames}"/>
		    <c:out value="${kmImissiveTemplateCfgForm.fdReceiveTempListTwoNames}"/>
		</td>
	</tr>
	<tr>
			<td class="td_normal_title" width=15%><bean:message
				key="model.tempEditorName" /></td>
			<td colspan="3">
			   <c:out value="${kmImissiveTemplateCfgForm.authEditorNames}"/>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				key="model.tempReaderName" /></td>
			<td colspan="3">
			   <c:out value="${kmImissiveTemplateCfgForm.authReaderNames}"/>
			</td>
		</tr>
</table>
</center>
</template:replace>
</template:include>
