<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.common.forms.IExtendForm" %>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.xform.service.DictLoadService"%>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<%
String formBeanName = request.getParameter("formName");
String mainFormName = null;
int indexOf = formBeanName.indexOf('.');
if (indexOf > -1) {
	mainFormName = formBeanName.substring(0, indexOf);
} else {
	mainFormName = formBeanName;
}

Object mainForm = request.getAttribute(formBeanName);
Object xform = mainForm ;

DictLoadService dictService=(DictLoadService)SpringBeanUtil.getBean("sysFormDictLoadService");
String path = "";
if(xform instanceof IExtendForm){
	IExtendForm extendForm = (IExtendForm)xform;
	path=dictService.findExtendFileFullPath(extendForm);
}else{
	path = (String) PropertyUtils.getProperty(xform, "extendDataFormInfo.extendFilePath");
	path=dictService.findExtendFileFullPath(path);
}
request.setAttribute("path", path);
%>
<script>
var datas = [];
function openBookmarkHelp(url){	
	datas = [];
	var xformTemplateId = "${JsParam.fdTemplateId}";
	var baseObjs = new KMSSData().AddBeanData("sysFormDictVarTree&fdPath=${path}").GetHashMapArray();
	for(var i = 0 ; i< baseObjs.length;i++){
		var record = {};
		record.label=baseObjs[i].label;
		var name =baseObjs[i].name;
		if(baseObjs[i].isXFormDict && name.indexOf('.') >-1){
			name=name.split('.')[1];
		}
		if(baseObjs[i].businessType && baseObjs[i].businessType=='auditShow'){
			name = name + "_auditShow";//区分审批意见
		}
		record.name = name;
		datas.push(record);
	}
	
	Com_OpenWindow(url,'_blank');
	
}
</script>