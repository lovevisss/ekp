<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="auto">
<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<kmss:auth requestURL="/km/imissive/km_imissive_secret_grade/kmImissiveSecretGrade.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			 <ui:button text="${ lfn:message('button.edit') }" order="2" onclick="Com_OpenWindow('kmImissiveSecretGrade.do?method=edit&fdId=${param.fdId}','_self');">
			 </ui:button>
		</kmss:auth>
		<kmss:auth requestURL="/km/imissive/km_imissive_secret_grade/kmImissiveSecretGrade.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
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
    		Com_OpenWindow('kmImissiveSecretGrade.do?method=delete&fdId=${param.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn");
};
</script>
<p class="txttitle"><bean:message  bundle="km-imissive" key="table.kmImissiveSecretGrade"/></p>
<center>
<table class="tb_normal" width=100%>
		<html:hidden name="kmImissiveSecretGradeForm" property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSecretGrade.fdName"/>
		</td><td width=35% colspan=3>
			<c:out value="${kmImissiveSecretGradeForm.fdName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSecretGrade.fdOrder"/>
		</td><td width=35%>
			<c:out value="${kmImissiveSecretGradeForm.fdOrder}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSecretGrade.fdIsAvailable"/>
		</td><td width=35%>
			<sunbor:enumsShow value="${kmImissiveSecretGradeForm.fdIsAvailable}" enumsType="common_yesno" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-imissive" key="kmImissiveSecretGrade.docCreateId"/>
		</td><td width=35%>
			<c:out value="${kmImissiveSecretGradeForm.docCreatorName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSecretGrade.docCreateTime"/>
		</td><td width=35%>
			<c:out value="${kmImissiveSecretGradeForm.docCreateTime}" />
		</td>
	</tr>
</table>
</center>
</template:replace>
</template:include>